SMODS.ConsumableType({
    key = "crv_Skarot",
    collection_rows = { 5, 6 },
    primary_colour = G.C.BLACK,
    secondary_colour = G.C.WHITE,
    text_colour = G.C.BLACK,
    shop_rate = 4,
})

SMODS.Consumable({
    key = "sketch_fool",
    set = "crv_Skarot",
    cost = 2,
    atlas = "revo_skarots",
    pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        local fool_c = G.GAME.crv_second_last_tarot_planet and G.P_CENTERS[G.GAME.crv_second_last_tarot_planet] or nil
        local last_tarot_planet = fool_c and localize({ type = "name_text", key = fool_c.key, set = fool_c.set })
            or localize("k_none")
        local colour = (not fool_c or fool_c.name == "The Fool") and G.C.RED or G.C.GREEN

        if not (not fool_c or fool_c.key == "c_crv_sketch_fool") then
            info_queue[#info_queue + 1] = fool_c
        end

        local main_end = {
            {
                n = G.UIT.C,
                config = { align = "bm", padding = 0.02 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "m", colour = colour, r = 0.05, padding = 0.05 },
                        nodes = {
                            {
                                n = G.UIT.T,
                                config = {
                                    text = " " .. last_tarot_planet .. " ",
                                    colour = G.C.UI.TEXT_LIGHT,
                                    scale = 0.3,
                                    shadow = true,
                                },
                            },
                        },
                    },
                },
            },
        }

        return { vars = { last_tarot_planet }, main_end = main_end }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    play_sound("timpani")
                    SMODS.add_card({ key = G.GAME.crv_second_last_tarot_planet })
                    card:juice_up(0.3, 0.5)
                end
                return true
            end,
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return (#G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables)
            and G.GAME.crv_second_last_tarot_planet
    end,
})

SMODS.Consumable({
    key = "sketch_magician",
    set = "crv_Skarot",
    cost = 2,
    atlas = "revo_skarots",

    pos = {
        x = 1,
        y = 0,
    },
    discovered = true,
    config = {
        max_highlighted = 2,
        min_highlighted = 1,
        extra = {},
    },
    loc_vars = function(self, info_queue, card)
        local border_effect_table = RevosVault.MISC.Borders.border_crv_lucky.config
        local num1, den1 = SMODS.get_probability_vars(RevosVault.MISC.Borders.border_crv_lucky, 1,
            border_effect_table.odds)
        info_queue[#info_queue + 1] = {
            set = "crv_Border",
            key = "border_crv_lucky",
            vars = {
                num1,
                den1,
                border_effect_table.odds2,
                border_effect_table.dollars,
                border_effect_table.mult
            }
        }
        return { vars = { self.config.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        for _, v in pairs(G.hand.highlighted) do
            RVF.cool_enhance(v, function()
                RVF.set_border(v, "border_crv_lucky")
                play_sound("tarot1")
                card:juice_up(0.3, 0.5)
            end, true)
        end
        RVF.do_event(function()
            G.hand:unhighlight_all()
            return true
        end)
    end,
})

SMODS.Consumable({
    key = "sketch_priestess",
    set = "crv_Skarot",
    cost = 2,
    atlas = "revo_skarots",
    pos = {
        x = 2,
        y = 0,
    },
    discovered = true,
    config = {},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    use = function(self, card, area, copier)
        local stripped_hands = {}
        for k, v in pairs(G.GAME.hands) do
            if v.visible then
                stripped_hands[#stripped_hands + 1] = v.key
            end
        end
        local _hand = pseudorandom_element(stripped_hands, pseudoseed("crv_sketch_priestess"))
        SMODS.smart_level_up_hand(card, _hand)
    end,
    can_use = function(self, card)
        return true
    end,
})

SMODS.Consumable({
    key = "sketch_empress",
    set = "crv_Skarot",
    cost = 2,
    atlas = "revo_skarots",

    pos = {
        x = 3,
        y = 0,
    },
    discovered = true,
    config = {
        max_highlighted = 2,
        min_highlighted = 1,
        extra = {},
    },
    loc_vars = function(self, info_queue, card)
        local border_effect_table = RevosVault.MISC.Borders.border_crv_mult.config
        info_queue[#info_queue + 1] = {
            set = "crv_Border",
            key = "border_crv_mult",
            vars = {
                border_effect_table.effect
            }
        }
        return { vars = { self.config.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        for _, v in pairs(G.hand.highlighted) do
            RVF.cool_enhance(v, function()
                RVF.set_border(v, "border_crv_mult")
                play_sound("tarot1")
                card:juice_up(0.3, 0.5)
            end, true)
        end
        RVF.do_event(function()
            G.hand:unhighlight_all()
            return true
        end)
    end,
})

SMODS.Consumable({
    key = "sketch_emperor",
    set = "crv_Skarot",
    cost = 2,
    atlas = "revo_skarots",

    pos = {
        x = 4,
        y = 0,
    },
    discovered = true,
    config = {
        extra = {
            create = 2,
        },
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.create } }
    end,
    use = function(self, card, area, copier)
        for i = 1, math.min(card.ability.extra.create, G.consumeables.config.card_limit - #G.consumeables.cards) do
            RVF.do_event(function()
                if RVF.has_room(G.consumeables) then
                    play_sound("timpani")
                    SMODS.add_card({ set = "crv_Skarot" })
                    card:juice_up(0.3, 0.5)
                end
                return true
            end, nil, "after", 0.4)
        end
        delay(0.6)
    end,
    can_use = function(self, card)
        return RVF.has_room(G.consumeables) or card.area == G.consumeables
    end,
})

SMODS.Consumable({
    key = "sketch_hierophant",
    set = "crv_Skarot",
    cost = 2,
    atlas = "revo_skarots",

    pos = {
        x = 5,
        y = 0,
    },
    discovered = true,
    config = {
        max_highlighted = 2,
        min_highlighted = 1,
        extra = {},
    },
    loc_vars = function(self, info_queue, card)
        local border_effect_table = RevosVault.MISC.Borders.border_crv_bonus.config
        info_queue[#info_queue + 1] = {
            set = "crv_Border",
            key = "border_crv_bonus",
            vars = {
                border_effect_table.effect
            }
        }
        return { vars = { self.config.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        for _, v in pairs(G.hand.highlighted) do
            RVF.cool_enhance(v, function()
                RVF.set_border(v, "border_crv_bonus")
                play_sound("tarot1")
                card:juice_up(0.3, 0.5)
            end, true)
        end
        RVF.do_event(function()
            G.hand:unhighlight_all()
            return true
        end)
    end,
})

SMODS.Consumable({
    key = "sketch_lovers",
    set = "crv_Skarot",
    cost = 2,
    atlas = "revo_skarots",
    pos = {
        x = 6,
        y = 0,
    },
    discovered = true,
    config = {
        max_highlighted = 1,
        min_highlighted = 1,
        extra = {},
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { set = "crv_Border", key = "border_crv_smudged_alt" }
        return { vars = { self.config.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        for _, v in pairs(G.hand.highlighted) do
            RVF.cool_enhance(v, function()
                RVF.set_border(v, "border_crv_smudged")
                play_sound("tarot1")
                card:juice_up(0.3, 0.5)
            end, true)
        end
        RVF.do_event(function()
            G.hand:unhighlight_all()
            return true
        end)
    end,
})
SMODS.Consumable({
    key = "sketch_chariot",
    set = "crv_Skarot",
    cost = 2,
    atlas = "revo_skarots",
    pos = {
        x = 7,
        y = 0,
    },
    discovered = true,
    config = {
        max_highlighted = 1,
        min_highlighted = 1,
        extra = {},
    },
    loc_vars = function(self, info_queue, card)
        local border_effect_table = RevosVault.MISC.Borders.border_crv_steel.config
        info_queue[#info_queue + 1] = {
            set = "crv_Border",
            key = "border_crv_steel",
            vars = {
                border_effect_table.effect
            }
        }
        return { vars = { self.config.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        for _, v in pairs(G.hand.highlighted) do
            RVF.cool_enhance(v, function()
                RVF.set_border(v, "border_crv_steel")
                play_sound("tarot1")
                card:juice_up(0.3, 0.5)
            end, true)
        end
        RVF.do_event(function()
            G.hand:unhighlight_all()
            return true
        end)
    end,
})
SMODS.Consumable({
    key = "sketch_justice",
    set = "crv_Skarot",
    cost = 2,
    atlas = "revo_skarots",
    pos = {
        x = 8,
        y = 0,
    },
    discovered = true,
    config = {
        max_highlighted = 1,
        min_highlighted = 1,
        extra = {},
    },
    loc_vars = function(self, info_queue, card)
        local border_effect_table = RevosVault.MISC.Borders.border_crv_glass.config
        info_queue[#info_queue + 1] = {
            set = "crv_Border",
            key = "border_crv_glass",
            vars = {
                border_effect_table.effect
            }
        }
        return { vars = { self.config.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        for _, v in pairs(G.hand.highlighted) do
            RVF.cool_enhance(v, function()
                RVF.set_border(v, "border_crv_glass")
                play_sound("tarot1")
                card:juice_up(0.3, 0.5)
            end, true)
        end
        RVF.do_event(function()
            G.hand:unhighlight_all()
            return true
        end)
    end,
})
SMODS.Consumable({
    key = "sketch_hermit",
    set = "crv_Skarot",
    cost = 2,
    atlas = "revo_skarots",
    pos = {
        x = 9,
        y = 0,
    },
    discovered = true,
    config = {
        extra = {
            dollars = 10
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,
    use = function(self, card, area, copier)
        play_sound("tarot1")
        card:juice_up(0.3, 0.5)
        ease_dollars(card.ability.extra.dollars)
    end,
    can_use = function(self, card)
        return true
    end
})
SMODS.Consumable {
    key = 'sketch_wheel_of_fortune',
    atlas = 'revo_skarots',
    set = "crv_Skarot",
    pos = { x = 0, y = 1 },
    config = { extra = { odds = 6 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,
            'crv_sketch_wheel')
        return { vars = { numerator, denominator } }
    end,
    use = function(self, card, area, copier)
        if SMODS.pseudorandom_probability(card, 'crv_sketch_wheel', 1, card.ability.extra.odds) then
            local editionless_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)

            local eligible_card = pseudorandom_element(editionless_jokers, 'crv_sketch_wheel')
            local edition = SMODS.poll_edition { key = "crv_sketch_wheel", guaranteed = true }
            eligible_card:set_edition(edition, true)
        else
            RVF.nope({ card = card })
        end
    end,
    can_use = function(self, card)
        return next(SMODS.Edition:get_edition_cards(G.jokers, true))
    end
}
SMODS.Consumable {
    key = 'sketch_strength',
    set = 'crv_Skarot',
    atlas = "revo_skarots",
    pos = { x = 1, y = 1 },
    config = { max_highlighted = 2, extra = { decrease = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted, card.ability.extra.decrease } }
    end,
    use = function(self, card, area, copier)
        for i = 1, #G.hand.highlighted do
            RVF.cool_enhance(G.hand.highlighted[i],
                function()
                    play_sound('tarot1', 0.85, 0.6)
                    assert(SMODS.modify_rank(G.hand.highlighted[i], -card.ability.extra.decrease))
                    card:juice_up()
                end)
        end
        delay(0.5)
        RVF.do_event(
            function()
                play_sound("tarot2", 0.85, 0.6)
                G.hand:unhighlight_all()
                return true
            end
        )
    end,
}
SMODS.Consumable {
    key = 'sketch_hanged_man',
    set = 'crv_Skarot',
    atlas = "revo_skarots",
    pos = { x = 2, y = 1 },
    use = function(self, card, area, copier)
        play_sound('tarot1', 0.85, 0.6)
        card:juice_up()
        local random_card = nil
        random_card = pseudorandom_element(G.hand.cards, pseudoseed("crv_hanged_seed"))
        if random_card then
            SMODS.destroy_cards(random_card)
        end
        delay(0.5)
    end,
    can_use = function(self, card)
        if G.hand and #G.hand.cards > 0 then
            return true
        end
    end
}
-- 1/1 from vremade
SMODS.Consumable {
    key = 'sketch_death',
    set = 'crv_Skarot',
    atlas = "revo_skarots",
    pos = { x = 3, y = 1 },
    config = { max_highlighted = 2, min_highlighted = 2 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        local _suit, _rank = nil, nil
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        local rightmost = G.hand.highlighted[1]
        _suit = G.hand.highlighted[1].base.suit
        _rank = G.hand.highlighted[1].base.original_value
        for i = 1, #G.hand.highlighted do
            if G.hand.highlighted[i].T.x > rightmost.T.x then
                rightmost = G.hand.highlighted[i]
                _suit = G.hand.highlighted[i].base.suit
                _rank = G.hand.highlighted[i].base.original_value
                print(_suit, _rank)
            end
        end
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    if G.hand.highlighted[i] ~= rightmost then
                        print(_suit, _rank, "2")
                        assert(SMODS.change_base(G.hand.highlighted[i], _suit, _rank))
                    end
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,
}
SMODS.Consumable {
    key = 'sketch_temperance',
    set = 'crv_Skarot',
    atlas = "revo_skarots",
    pos = { x = 4, y = 1 },
    config = { extra = { max = 30 } },
    loc_vars = function(self, info_queue, card)
        local ease = 0
        if G.consumeables.cards then
            for k, v in pairs(G.consumeables.cards) do
                ease = ease + v.sell_cost
            end
        end
        ease = math.min(ease, card.ability.extra.max)
        return { vars = { card.ability.extra.max, ease } }
    end,
    use = function(self, card, area, copier)
        play_sound('tarot1', 0.85, 0.6)
        card:juice_up()
        local ease = 0
        for k, v in pairs(G.consumeables.cards) do
            ease = ease + v.sell_cost
        end
        ease_dollars(math.min((ease + card.sell_cost), card.ability.extra.max))
    end,
    can_use = function(self, card)
        return true
    end
}

SMODS.Consumable({
    key = "sketch_devil",
    set = "crv_Skarot",
    cost = 2,
    atlas = "revo_skarots",

    pos = {
        x = 5,
        y = 1,
    },
    discovered = true,
    config = {
        max_highlighted = 1,
        min_highlighted = 1,
        extra = {},
    },
    loc_vars = function(self, info_queue, card)
        local border_effect_table = RevosVault.MISC.Borders.border_crv_gold.config
        info_queue[#info_queue + 1] = {
            set = "crv_Border",
            key = "border_crv_gold",
            vars = {
                border_effect_table.effect
            }
        }
        return { vars = { self.config.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        for _, v in pairs(G.hand.highlighted) do
            RVF.cool_enhance(v, function()
                RVF.set_border(v, "border_crv_gold")
                play_sound("tarot1")
                card:juice_up(0.3, 0.5)
            end, true)
        end
        RVF.do_event(function()
            G.hand:unhighlight_all()
            return true
        end)
    end,
})

SMODS.Consumable({
    key = "sketch_tower",
    set = "crv_Skarot",
    cost = 2,
    atlas = "revo_skarots",

    pos = {
        x = 6,
        y = 1,
    },
    discovered = true,
    config = {
        max_highlighted = 1,
        min_highlighted = 1,
        extra = {},
    },
    loc_vars = function(self, info_queue, card)
        local border_effect_table = RevosVault.MISC.Borders.border_crv_stone.config
        info_queue[#info_queue + 1] = {
            set = "crv_Border",
            key = "border_crv_stone",
            vars = {
                border_effect_table.effect
            }
        }
        return { vars = { self.config.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        for _, v in pairs(G.hand.highlighted) do
            RVF.cool_enhance(v, function()
                RVF.set_border(v, "border_crv_stone")
                play_sound("tarot1")
                card:juice_up(0.3, 0.5)
            end, true)
        end
        RVF.do_event(function()
            G.hand:unhighlight_all()
            return true
        end)
    end,
})

SMODS.Consumable({
    key = "sketch_star",
    set = "crv_Skarot",
    cost = 2,
    atlas = "revo_skarots",

    pos = {
        x = 7,
        y = 1,
    },
    discovered = true,
    config = {
        max_highlighted = 1,
        min_highlighted = 1,
        extra = {},
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        for _, v in pairs(G.hand.highlighted) do
            RVF.cool_enhance(v, function()
                assert(SMODS.change_base(v, "Diamonds"))
                play_sound("tarot1")
                card:juice_up(0.3, 0.5)
            end, true)
        end
        RVF.do_event(function()
            G.hand:unhighlight_all()
            return true
        end)
    end,
})
SMODS.Consumable({
    key = "sketch_moon",
    set = "crv_Skarot",
    cost = 2,
    atlas = "revo_skarots",

    pos = {
        x = 8,
        y = 1,
    },
    discovered = true,
    config = {
        max_highlighted = 1,
        min_highlighted = 1,
        extra = {},
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        for _, v in pairs(G.hand.highlighted) do
            RVF.cool_enhance(v, function()
                assert(SMODS.change_base(v, "Clubs"))
                play_sound("tarot1")
                card:juice_up(0.3, 0.5)
            end, true)
        end
        RVF.do_event(function()
            G.hand:unhighlight_all()
            return true
        end)
    end,
})


SMODS.Consumable({
    key = "sketch_sun",
    set = "crv_Skarot",
    cost = 2,
    atlas = "revo_skarots",

    pos = {
        x = 9,
        y = 1,
    },
    discovered = true,
    config = {
        max_highlighted = 1,
        min_highlighted = 1,
        extra = {},
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        for _, v in pairs(G.hand.highlighted) do
            RVF.cool_enhance(v, function()
                assert(SMODS.change_base(v, "Hearts"))
                play_sound("tarot1")
                card:juice_up(0.3, 0.5)
            end, true)
        end
        RVF.do_event(function()
            G.hand:unhighlight_all()
            return true
        end)
    end,
})


SMODS.Consumable {
    key = 'sketch_judgement',
    set = 'crv_Skarot',
    atlas = "revo_skarots",
    pos = { x = 0, y = 2 },
    use = function(self, card, area, copier)
        play_sound('tarot1', 0.85, 0.6)
        card:juice_up()
        local random_card = nil
        random_card = pseudorandom_element(SMODS.get_clean_pool("Joker", "Common"), pseudoseed("crv_judgement_seed"))
        if random_card then
            SMODS.add_card {
                key = random_card
            }
        end
        delay(0.5)
    end,
    can_use = function(self, card)
        if RVF.has_room(G.jokers) then
            return true
        end
        return false
    end
}


SMODS.Consumable({
    key = "sketch_world",
    set = "crv_Skarot",
    cost = 2,
    atlas = "revo_skarots",

    pos = {
        x = 1,
        y = 2,
    },
    discovered = true,
    config = {
        max_highlighted = 1,
        min_highlighted = 1,
        extra = {},
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        for _, v in pairs(G.hand.highlighted) do
            RVF.cool_enhance(v, function()
                assert(SMODS.change_base(v, "Spades"))
                play_sound("tarot1")
                card:juice_up(0.3, 0.5)
            end, true)
        end
        RVF.do_event(function()
            G.hand:unhighlight_all()
            return true
        end)
    end,
})
