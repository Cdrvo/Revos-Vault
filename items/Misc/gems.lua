RevosVault.Gem =
    SMODS.Voucher:extend({
        required_params = { "key" },
        display_size = { w = 50, h = 50 },
        set = "crv_Gem",
        atlas = "crv_revo_gems",
        unlocked = true,
        discovered = true,
        cost = 6,
        config = {},
        set_card_type_badge = function(self, card, badges)
            badges[#badges + 1] = create_badge(localize("b_gem"), SMODS.Gradients["crv_gem"], G.C.WHITE, 1.2)
        end,
        class_prefix = "gem",
        apply_gem = function(self, card) end,
        increase_timer = function(self, card, by)
            card.ability.extra.timer_max = card.ability.extra.timer_max + (by or 1)
        end,
        inject = function(self)
            G.P_CENTERS[self.key] = self
            G.P_CENTER_POOLS[self.set] = G.P_CENTER_POOLS[self.set] or {}
            if not self.omit then SMODS.insert_pool(G.P_CENTER_POOLS[self.set], self) end
            for k, v in pairs(SMODS.ObjectTypes) do
                -- Should "cards" be formatted as `{[<center key>] = true}` or {<center key>}?
                -- Changing "cards" and "pools" wouldn't be hard to do, just depends on preferred format
                if ((self.pools and self.pools[k]) or (v.cards and v.cards[self.key])) then
                    v:inject_card(self)
                end
            end
            if self.attributes then
                for _, attribute in ipairs(self.attributes) do
                    if SMODS.Attributes[attribute] then
                        self.attributes[attribute] = true
                        SMODS.Attributes[attribute].keys = SMODS.merge_lists({ SMODS.Attributes[attribute].keys or {}, { self.key } })
                    end
                end
            end
            if self.soul_atlas and not self.soul_pos then
                self.soul_pos = { x = 0, y = 0 }
            end
        end,
    })


local Gem = RevosVault.Gem

-- Gem Redeeming function
--

G.FUNCS.can_redeem_gem = function(e)
    local card = e.config.ref_table
    if to_big(card.config.center.cost) > to_big(G.GAME.dollars) - to_big(G.GAME.bankrupt_at) then
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    else
        e.config.colour = G.C.GREEN
        e.config.button = 'redeem_gem'
    end
end

G.FUNCS.redeem_gem = function(e)
    RVF.hide_shop()

    local card = e.config.ref_table

    if card.children.price then card.children.price = nil end
    if card.children.use_button then card.children.use_button = nil end
    RVF.move_card(card, G.play)

    if card.config.center and type(card.config.center.apply_gem) == "function" then
        card.config.center:apply_gem(card)
    end



    local rgem = SMODS.add_card {
        key = card.config.center.key,
        area = G.crv_gems,
        no_edition = true
    }

    SMODS.calculate_context({ gem_redeemed = true, gem = rgem, ui_gem = card })

    check_for_unlock({ type = "gemming_it" })


    G.GAME.crv_activated_gems[card.config.center.key] = G.GAME.crv_activated_gems[card.config.center.key] + 1

    if card.ability.set == "crv_Gem" then
        stop_use()
        if not card.config.center.discovered then
            discover_card(card.config.center)
        end

        card.states.hover.can = false
        local top_dynatext = nil
        local bot_dynatext = nil

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                top_dynatext = DynaText({
                    string = localize { type = 'name_text', set = card.config.center.set, key = card.config.center.key },
                    colours = { G.C.WHITE },
                    rotate = 1,
                    shadow = true,
                    bump = true,
                    float = true,
                    scale = 0.9,
                    pop_in = 0.6 /
                        G.SPEEDFACTOR,
                    pop_in_rate = 1.5 * G.SPEEDFACTOR
                })
                bot_dynatext = DynaText({
                    string = localize('k_crv_activated'),
                    colours = { G.C.WHITE },
                    rotate = 2,
                    shadow = true,
                    bump = true,
                    float = true,
                    scale = 0.9,
                    pop_in = 1.4 /
                        G.SPEEDFACTOR,
                    pop_in_rate = 1.5 * G.SPEEDFACTOR,
                    pitch_shift = 0.25
                })
                card:juice_up(0.3, 0.5)
                play_sound('card1')
                play_sound('coin1')
                card.children.top_disp = UIBox {
                    definition = { n = G.UIT.ROOT, config = { align = 'tm', r = 0.15, colour = G.C.CLEAR, padding = 0.15 }, nodes = {
                        { n = G.UIT.O, config = { object = top_dynatext } }
                    } },
                    config = { align = "tm", offset = { x = 0, y = 0 }, parent = card }
                }
                card.children.bot_disp = UIBox {
                    definition = { n = G.UIT.ROOT, config = { align = 'tm', r = 0.15, colour = G.C.CLEAR, padding = 0.15 }, nodes = {
                        { n = G.UIT.O, config = { object = bot_dynatext } }
                    } },
                    config = { align = "bm", offset = { x = 0, y = 0 }, parent = card }
                }
                return true
            end
        }))
        ease_dollars(-card.config.center.cost)

        delay(0.6)


        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 2.6,
            func = function()
                top_dynatext:pop_out(4)
                bot_dynatext:pop_out(4)
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.5,
            func = function()
                card.children.top_disp:remove()
                card.children.top_disp = nil
                card.children.bot_disp:remove()
                card.children.bot_disp = nil
                SMODS.destroy_cards(card, true)
                RVF.show_shop()
                return true
            end
        }))
    end
end

-- Gems in Run Info

function G.UIDEF.used_gems()
    local silent = false
    local keys_used = {}
    local area_count = 0
    local voucher_areas = {}
    local voucher_tables = {}
    local voucher_table_rows = {}
    for k, v in ipairs(G.crv_gems.cards or {}) do
        keys_used[#keys_used + 1] = v
    end
    for k, v in ipairs(keys_used) do
        if next(v) then
            area_count = area_count + 1
        end
    end
    for k, v in ipairs(keys_used) do
        if next(v) then
            if #voucher_areas == 5 or #voucher_areas == 10 then
                table.insert(
                    voucher_table_rows,
                    { n = G.UIT.R, config = { align = "cm", padding = 0, no_fill = true }, nodes = voucher_tables }
                )
                voucher_tables = {}
            end
            voucher_areas[#voucher_areas + 1] = CardArea(
                G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2,
                G.ROOM.T.h,
                (#v == 1 and 1 or 1.33) * G.CARD_W,
                (area_count >= 10 and 0.75 or 1.07) * G.CARD_H,
                { card_limit = 2, type = "voucher", highlight_limit = 0 }
            )

            local center = v.config.center
            local card = Card(
                voucher_areas[#voucher_areas].T.x + voucher_areas[#voucher_areas].T.w / 2,
                voucher_areas[#voucher_areas].T.y,
                G.CARD_W,
                G.CARD_H,
                nil,
                center,
                { bypass_discovery_center = true, bypass_discovery_ui = true, bypass_lock = true }
            )
            -- RevosVault.create_gem_timer(card)
            card.ability = v.ability
            card.ability.order = v.ability.order -- no need
            card:start_materialize(nil, silent)
            silent = true
            voucher_areas[#voucher_areas]:emplace(card)

            table.insert(voucher_tables, {
                n = G.UIT.C,
                config = { align = "cm", padding = 0, no_fill = true },
                nodes = {
                    { n = G.UIT.O, config = { object = voucher_areas[#voucher_areas] } },
                },
            })
        end
    end
    table.insert(
        voucher_table_rows,
        { n = G.UIT.R, config = { align = "cm", padding = 0, no_fill = true }, nodes = voucher_tables }
    )

    local t = silent
        and {
            n = G.UIT.ROOT,
            config = { align = "cm", colour = G.C.CLEAR },
            nodes = {
                {
                    n = G.UIT.R,
                    config = { align = "cm" },
                    nodes = {
                        {
                            n = G.UIT.O,
                            config = {
                                object = DynaText({
                                    string = { localize("ui_active_gems") },
                                    colours = { G.C.UI.TEXT_LIGHT },
                                    bump = true,
                                    scale = 0.6,
                                }),
                            },
                        },
                    },
                },
                { n = G.UIT.R, config = { align = "cm", minh = 0.5 }, nodes = {} },
                {
                    n = G.UIT.R,
                    config = { align = "cm", colour = G.C.BLACK, r = 1, padding = 0.15, emboss = 0.05 },
                    nodes = {
                        { n = G.UIT.R, config = { align = "cm" }, nodes = voucher_table_rows },
                    },
                },
            },
        }
        or {
            n = G.UIT.ROOT,
            config = { align = "cm", colour = G.C.CLEAR },
            nodes = {
                {
                    n = G.UIT.O,
                    config = {
                        object = DynaText({
                            string = { localize("ui_no_gems") },
                            colours = { G.C.UI.TEXT_LIGHT },
                            bump = true,
                            scale = 0.6,
                        }),
                    },
                },
            },
        }
    return t
end

local function progress_timer(card)
    if card.ability.extra.timer < card.ability.extra.timer_max - 1 then
        card.ability.extra.timer = card.ability.extra.timer + 1
    else
        SMODS.destroy_cards(card, { silent = true })
        play_sound("glass1", 1, 0.5)
        play_sound("glass6", 0.7, 0.5)
        if card.config.center.remove_gem and type(card.config.center.remove_gem) then
            card.config.center:remove_gem(card)
        end
    end
end

Gem({
    key = "black_diamond",
    atlas = "revo_gems",
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            timer_max = 5,
            timer = 0,
        },
    },
    crv_credits = {
        art = { "mr.cr33ps" }
    },
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        return { vars = { cae.timer, cae.timer_max } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval then
            progress_timer(card)
        end
    end,
    apply_gem = function(self, card)
        for k, v in pairs(G.playing_cards) do
            if v:is_suit("Spades", true) or v:is_suit("Clubs") then
                SMODS.debuff_card(v, "prevent_debuff", "black_diamond")
            end
        end
    end,
    remove_gem = function(self, card)
        for k, v in pairs(G.playing_cards) do
            if v:is_suit("Spades", true) or v:is_suit("Clubs") then
                v.ability.debuff_sources.black_diamond = nil
            end
        end
    end
})


Gem({
    key = "emerald",
    atlas = "revo_gems",
    pos = { x = 1, y = 0 },
    config = {
        extra = {
            timer = 0,
            timer_max = 2,
        },
    },
    crv_credits = {
        art = { "mr.cr33ps" }
    },
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        return { vars = { cae.timer, cae.timer_max } }
    end,
    calculate = function(self, card, context)
        local cae = card.ability.extra
        if context.end_of_round and context.main_eval then
            progress_timer(card)
        end
    end,
    apply_gem = function(self, card)
        G.GAME.crv_double_earnings =  G.GAME.crv_double_earnings + 1
    end,
    remove_gem = function(self, card)
        G.GAME.crv_double_earnings =  G.GAME.crv_double_earnings - 1
    end
})

RevosVault.Gem({
	key = "ruby",
	atlas = "revo_gems",
	pos = { x = 2, y = 0 },
	config = {
		extra = {
			timer = 0,
            timer_max = 1,
			xmult = 5
		},
	},
	crv_credits = {
		art = {"mr.cr33ps"}
	},
	loc_vars = function(self,info_queue,card)
		local cae = card.ability.extra
		return{vars={cae.timer, cae.timer_max, cae.xmult}}
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.end_of_round and context.main_eval then
			progress_timer(card)
		end
		if context.final_scoring_step then
			return {
                xmult = cae.xmult,
				message_card = G.deck.cards[1] or G.deck
			}
		end
	end,
})


Gem({
    key = "diamond",
    atlas = "revo_gems",
    pos = { x = 3, y = 0 },
    config = {
        extra = {
            timer_max = 5,
            timer = 0,
        },
    },
    crv_credits = {
        art = { "mr.cr33ps" }
    },
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        return { vars = { cae.timer, cae.timer_max } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval then
            progress_timer(card)
        end
    end,
    apply_gem = function(self, card)
        for k, v in pairs(G.playing_cards) do
            if v:is_suit("Hearts", true) or v:is_suit("Diamonds") then
                SMODS.debuff_card(v, "prevent_debuff", "diamond")
            end
        end
    end,
    remove_gem = function(self, card)
        for k, v in pairs(G.playing_cards) do
            if v:is_suit("Hearts", true) or v:is_suit("Diamonds") then
                v.ability.debuff_sources.diamond = nil
            end
        end
    end
})

RevosVault.Gem({
	key = "star_sapphire",
	atlas = "revo_gems",
	pos = { x = 4, y = 0 },
	config = {
		extra = {
			timer = 0,
            timer_max = 1,
			level_up = 1
		},
	},
	crv_credits = {
		art = {"mr.cr33ps"}
	},
	loc_vars = function(self,info_queue,card)
		local cae = card.ability.extra
		return{vars={cae.timer, cae.timer_max, cae.level_up}}
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.end_of_round and context.main_eval then
			progress_timer(card)
		end
		if context.joker_main then
			return {
				level_up = cae.level_up,
			}
		end
	end,
})

Gem({
	key = "obsidian",
	atlas = "revo_gems",
	pos = { x = 5, y = 0},
	config = {
		extra = {
			timer = 0,
			timer_max = 3,
            multiply_by = 2
		},
	},
	crv_credits = {
		art = {"mr.cr33ps"}
	},
	loc_vars = function(self,info_queue,card)
		local cae = card.ability.extra
		return{vars={cae.timer, cae.timer_max, cae.multiply_by}}
	end,
    calculate = function(self, card, context)
		local cae = card.ability.extra
        if context.end_of_round and context.main_eval then
            progress_timer(card)
        end
		if context.mod_probability and context.identifier == "glass" and not context.blueprint then
			return {
				denominator = context.denominator * card.ability.extra.multiply_by,
			}
		end
	end,
	in_pool = function(self)
		return RVF.owned_enhancements("m_glass")>0
	end
})

Gem({
	key = "angelite",
		atlas = "revo_gems",
	pos = { x = 6, y = 0 },
	config = {
		extra = {
			timer = 0,
			timer_max = 3,
            odds = 4
		},
	},
	crv_credits = {
		art = {"mr.cr33ps"}
	},
	loc_vars = function(self,info_queue,card)
		info_queue[#info_queue+1] = {set = "Other", key = "crv_immutable"}
        local cae = card.ability.extra
		local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "angelite_seed")
		return{vars={cae.timer, cae.timer_max, num, den}}
	end,
    calculate = function(self, card, context)
        if context.joker_type_destroyed and context.card.ability.set == "Joker" and SMODS.pseudorandom_probability(card, "angelite_seed", 1, card.ability.extra.odds, nil, true) then
            local a = SMODS.copy_card(context.card)
            a:set_edition("e_negative")
        end
        if context.end_of_round and context.main_eval then
            progress_timer(card)
        end
	end,
})

Gem({
	key = "amethyst",
	atlas = "revo_gems",
	pos = { x = 7, y = 0 },
	config = {
		extra = {
			timer = 0,
			timer_max = 2,
		},
	},
	crv_credits = {
		art = {"mr.cr33ps"}
	},
	loc_vars = function(self,info_queue,card)
		local cae = card.ability.extra
		return{vars={cae.timer, cae.timer_max}}
	end,
	calculate = function(self,card,context)
        if context.end_of_round and context.main_eval then
            progress_timer(card)
        end
        if context.buying_card and (context.card.ability.set == "Joker" or SMODS.ConsumableTypes[context.card.ability.set]) then
            context.card:set_edition(SMODS.poll_edition{guaranteed = true})
        end
	end
})

Gem({
	key = "lapis_lazuli",
	atlas = "revo_gems",
	pos = { x = 0, y = 1 },
	config = {
		extra = {
			timer = 0,
			timer_max = 2,
			timer_increase = 2
		},
	},
	crv_credits = {
		art = {"Nyxel"}
	},
	loc_vars = function(self,info_queue,card)
		local cae = card.ability.extra
		return{vars={cae.timer, cae.timer_max, cae.timer_increase}}
	end,
	calculate = function(self,card,context)
		if context.gem_redeemed and context.gem and context.gem.config.center.key ~= "gem_crv_lapis_lazuli" then
			if context.gem.ability and context.gem.ability.extra.timer_max then
                context.gem.config.center:increase_timer(context.gem, card.ability.extra.timer_increase)
				progress_timer(card)
			end
		end
	end
})
