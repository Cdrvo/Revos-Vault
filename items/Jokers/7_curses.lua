SMODS.Joker({
    key = "black_clover",
    atlas = "revo_curses",
    pos = {
        x = 0,
        y = 0,
    },
    rarity = "crv_curse",
    cost = 0,
    add_to_deck = function(self, card, from_debuff)
        for k, v in pairs(G.playing_cards) do
            if v.ability.set == "Enhanced" then
                v:set_ability("c_base")
            end
        end
    end,
    calculate = function(self, card, context)
        if context.card_enhanced and context.area then
            context.card:set_ability("c_base")
            if G.crv_curses.T.y > G.jokers.T.y then
                RVF.msg(card, localize("crv_not_allowed"))
            else
                RVF.msg((#G.deck.cards > 0 and G.deck.cards[1] or G.deck), localize("crv_not_allowed"))
            end
        end
    end,
})


SMODS.Joker({
    key = "limited_stock",
    atlas = "revo_curses",
    pos = {
        x = 4,
        y = 0,
    },
    rarity = "crv_curse",
    cost = 0,
    add_to_deck = function(self, card, from_debuff)
        change_shop_size(-1)
    end,
    remove_from_deck = function(self, card, from_debuff)
        change_shop_size(1)
    end,
})

SMODS.Joker({
    key = "inflation",
    atlas = "revo_curses",
    pos = {
        x = 5,
        y = 0,
    },
    rarity = "crv_curse",
    blueprint_compat = false,
    cost = 0,
})

SMODS.Joker({
    key = "greed",
    atlas = "revo_curses",
    pos = {
        x = 6,
        y = 0,
    },
    rarity = "crv_curse",
    cost = 0,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.curse_cashout = G.GAME.curse_cashout + 1
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.curse_cashout = G.GAME.curse_cashout - 1
    end,
})

SMODS.Joker({
    key = "demotion",
    atlas = "revo_curses",
    pos = {
        x = 7,
        y = 0,
    },
    config = {
        extra = {
            def = nil
        }
    },
    rarity = "crv_curse",
    cost = 0,
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.def = G.GAME.rare_mod
        G.GAME.rare_mod = 0
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.rare_mod = G.GAME.rare_mod + card.ability.extra.def
    end,
})

-- removed cursed printer

-- removed soulless


SMODS.Joker({
    key = "clumsy",
    atlas = "revo_curses",
    pos = {
        x = 1,
        y = 1,
    },
    config = {
        extra = {
        }
    },
    rarity = "crv_curse",
    blueprint_compat = false,
    cost = 0,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { set = "Other", key = "crv_immutable" }
        local num, den = SMODS.get_probability_vars(card, 1, 4, "crv_clumsy", nil, true)
        return {
            vars = {
                num, den
        }}
    end,
    calculate = function(self, card, context)
        if context.buying_card and not context.blueprint and context.card and SMODS.pseudorandom_probability(card, "crv_clumsy", 1, 4, nil, true) and (context.card.ability.set == "Joker" or context.card.ability.consumeable) then
            SMODS.destroy_cards(context.card, { bypass_eternal = true })
        end
    end
})

SMODS.Joker({
    key = "hardcore",
    atlas = "revo_curses",
    pos = {
        x = 2,
        y = 1,
    },
    config = {
        extra = {
            def = nil
        }
    },
    rarity = "crv_curse",
    blueprint_compat = false,
    cost = 0,
    add_to_deck = function(self, card, from_debuff)
        if not card.ability.crv_curse_triggered then
            card.ability.extra.def = G.GAME.starting_params.ante_scaling
            G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling * 3
            card.ability.extra.def = G.GAME.starting_params.ante_scaling - card.ability.extra.def
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling - card.ability.extra.def
    end,
})

SMODS.Joker({
    key = "sneak_attack",
    atlas = "revo_curses",
    pos = {
        x = 3,
        y = 1,
    },
    config = {
        extra = {

        }
    },
    rarity = "crv_curse",
    blueprint_compat = false,
    cost = 0,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { set = "Other", key = "crv_immutable" }
        local num, den = SMODS.get_probability_vars(card, 1, 10, "crv_sneak_attack", nil, true)
        return{vars={num, den}}
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint and SMODS.pseudorandom_probability(card, "crv_clumsy", 1, 10, nil, true) then
            G.GAME.blind.chips = G.GAME.blind.chips * 10
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips) -- i dont think this is needed but i will keep it just in case
            card:juice_up(0.3, 0.4)
            return {
                message = localize("k_crv_cursed")
            }
        end
    end
})

-- removed hardstuck

SMODS.Joker({
    key = "small_hands",
    atlas = "revo_curses",
    pos = {
        x = 1,
        y = 0,
    },
    rarity = "crv_curse",
    blueprint_compat = false,
    cost = 0,
    add_to_deck = function(self, card, from_debuff)
        SMODS.change_play_limit(-1)
        SMODS.change_discard_limit(-1)
    end,
    remove_from_deck = function(self, card, from_debuff)
        SMODS.change_play_limit(1)
        SMODS.change_discard_limit(1)
    end,
})

SMODS.Joker({
    key = "unknown_assassin",
    atlas = "revo_curses",
    pos = {
        x = 2,
        y = 0,
    },
    rarity = "crv_curse",
    blueprint_compat = false,
    cost = 0,
    crv_credits = {
        art = { "rat" }
    },
    add_to_deck = function(self, card, from_debuff)
    end,
    calculate = function(self, card, context)
        if context.destroy_card and context.cardarea == G.play then
            if context.destroy_card:is_face() then
                return {
                    remove = true,
                }
            end
        end
    end
})

SMODS.Joker({
    key = "rush",
    atlas = "revo_curses",
    pos = {
        x = 9,
        y = 0,
    },
    config = {
        extra = {
            def = nil
        }
    },
    rarity = "crv_curse",
    blueprint_compat = false,
    cost = 0,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.modifiers.curse_no_shop = true
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.modifiers.curse_no_shop = false
    end,
})

SMODS.Joker({
    key = "fan",
    atlas = "revo_curses",
    pos = {
        x = 8,
        y = 0,
    },
    rarity = "crv_curse",
    cost = 0,
    calculate = function(self, card, context)
        if context.crv_before_before then
            pseudoshuffle(G.jokers.cards)
            pseudoshuffle(G.hand.cards)
            pseudoshuffle(G.consumeables.cards)
            pseudoshuffle(G.play.cards)
        end
    end
})

SMODS.Joker({
    key = "cursed_banana",
    atlas = "revo_curses",
    pos = { x = 5, y = 1 },
    rarity = "crv_curse",
    blueprint_compat = false,
    cost = 0,
    calculate = function(self, card, context)
        if context.setting_blind then
            local a = {}
            for k, v in pairs(G.jokers.cards) do
                if not v.ability.perishable and not v.ability.eternal and v.config.center.perishable_compat then
                    a[#a + 1] = v
                end
            end


            local joker = pseudorandom_element(a, pseudoseed("brr_brr_bananacurse"))
            if joker then
                joker:add_sticker("perishable", true)
                joker:juice_up()
                play_sound("tarot1")
            end
        end
    end,
    crv_credits = {
        art = { "ven_the_person" }
    }
})


SMODS.Joker({
    key = "the_nameless_creature_that_shouldnotbe_spoken_of",
    atlas = "revo_curses",
    pos = {
        x = 6,
        y = 1,
    },
    config = {
        extra = {
            def = nil
        }
    },
    rarity = "crv_curse",
    blueprint_compat = false,
    cost = 0,
    crv_credits = {
        art = { "isa" },
        idea = { "isa" }
    }
})

SMODS.Joker({
    key = "sdms_nightmare",
    atlas = "revo_curses",
    pos = {
        x = 4,
        y = 1,
    },
    config = {
        extra = {
            def = nil
        }
    },
    rarity = "crv_curse",
    blueprint_compat = false,
    cost = 0,
    add_to_deck = function(self, card, from_debuff)
        RVF.reset_all_blinds()
    end,
    remove_from_deck = function(self, card, from_debuff)
        RVF.reset_all_blinds()
    end
})
