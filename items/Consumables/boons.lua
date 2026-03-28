SMODS.ConsumableType({
	key = "crv_boons",
	collection_rows = { 4, 5 },
	primary_colour = G.C.IMPORTANT,
	secondary_colour = G.C.IMPORTANT,
})

RevosVault.Boon = SMODS.Consumable:extend({
	config = {
		crv_no_buttons = true
	},
	crv_credits = {
		art = {"GeorgeTheRat"},
	}
})

RevosVault.Boon({
	atlas = "boons",
	display_size = {
		w = 42,
		h = 42,
	},
	config = {
		extra = {
			num_cards = 5
		}
	},
	pos = { x = 0, y = 2 },
	soul_pos = { x = 0, y = 3 },
	key = "knowledge",
	set = "crv_boons",
	discovered = true,
	loc_vars = function(self, info_queue, card)
		local t = {}
		local cae = card.ability.extra
		local _key = card.config.center.key
		if not card.added_to_deck or card.area == G.boon_shop then
			_key = _key .. "_unowned"
		end
		if card.area and card.area.config and not card.area.config.collection and card.area ~= G.boon_shop then
			if G.crv_nextfivecard then
				G.crv_nextfivecard:remove()
				G.crv_nextfivecard = nil
			end

			G.crv_nextfivecard = CardArea(
				G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2,
				G.ROOM.T.h,
				G.CARD_W * 1.8,
				G.CARD_H * 0.8,
				{ card_limit = 1e308, type = "joker", highlight_limit = 0, no_card_count = true }
			)

			if G.deck and G.deck.cards then
				for i = 1, cae.num_cards do
					local ccard = copy_card(G.deck.cards[#G.deck.cards-(i-1)], nil, nil, G.playing_card)
					ccard.T.w = ccard.T.w / 1.3
					ccard.T.h = ccard.T.h / 1.3
					G.crv_nextfivecard:emplace(ccard)
				end
			end

			t = {
				{
					n = G.UIT.C,
					config = { align = "bm", padding = 0.02 },
					nodes = {
						{ n = G.UIT.O, config = { object = G.crv_nextfivecard } },
					},
				},
			}
			if not card.added_to_deck then
				t = {}
			end
		end
			return {
				main_end = t,
				key = _key,
				vars = {cae.num_cards}
			}
		end
})

--[[
RevosVault.Boon{
    key = "closure"
}


RevosVault.Boon{
 key = "trust"
}]]

RevosVault.Boon({
	atlas = "boons",
	display_size = {
		w = 42,
		h = 42,
	},
	pos = { x = 1, y = 0 },
	soul_pos = { x = 1, y = 1 },
	key = "health",
	set = "crv_boons",
	discovered = true,
	calculate = function(self, card, context)
		if context.before then
			for k, v in pairs(G.play.cards) do
				v:set_debuff(false)
			end
		end
	end,
})

RevosVault.Boon({
	atlas = "boons",
	display_size = {
		w = 42,
		h = 42,
	},
	pos = { x = 2, y = 0 },
	soul_pos = { x = 2, y = 1 },
	key = "wealth",
	set = "crv_boons",
	discovered = true,
	config = {
		extra = {
			give = 1,
			blinds = 0,
		},
	},
	loc_vars = function(self, info_queue, card)
		local jud = card.ability.extra
		return {
			vars = {
				card.ability.extra.blinds,
				jud.give,
			},
		}
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval then
			local jud = card.ability.extra
			jud.blinds = jud.blinds + jud.give
			return {
				message = "$" .. jud.blinds,
				colour = G.C.MONEY
			}
		end
	end,
calc_dollar_bonus = function(self, card)
		return card.ability.extra.blinds
	end,
})

RevosVault.Boon({
	atlas = "boons",
	display_size = {
		w = 42,
		h = 42,
	},
	pos = { x = 1, y = 2 },
	soul_pos = { x = 1, y = 3 },
	key = "power",
	set = "crv_boons",
	discovered = true,
	config = {
		extra = {},
	},
	loc_vars = function(self,info_queue,card)
		info_queue[#info_queue+1] = {set = "Other", key = "crv_fixed_chances"}
	end,
	calculate = function(self, card, context)
		if context.setting_blind then
			if pseudorandom("power") < 1 / 50 then
				SMODS.add_card({
					set = "Joker",
					legendary = true,
				})
			end
		end
	end,
})

RevosVault.Boon({
	atlas = "boons",
	display_size = {
		w = 42,
		h = 42,
	},
	pos = { x = 3, y = 0 },
	soul_pos = { x = 3, y = 1 },
	key = "resource",
	set = "crv_boons",
	discovered = true,
	config = {
		extra = {
			setsize = 5,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.setsize,
			},
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		local jud = card.ability.extra
		SMODS.change_discard_limit(jud.setsize)
	end,
	remove_from_deck = function(self, card, from_debuff)
		local jud = card.ability.extra
		local jud = card.ability.extra
		SMODS.change_discard_limit(-jud.setsize)
	end,
})

RevosVault.Boon({
	atlas = "boons",
	display_size = {
		w = 42,
		h = 42,
	},
	pos = { x = 2, y = 2 },
	soul_pos = { x = 2, y = 3 },
	key = "serendipity",
	set = "crv_boons",
	discovered = true,
	config = {
		extra = {},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.defaults,
			},
		}
	end,
	cost = 5,
	add_to_deck = function(self, card, from_debuff)
		G.GAME.rare_mod = G.GAME.rare_mod + 0.3
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.GAME.rare_mod = G.GAME.rare_mod - 0.3
	end,
})

--[[RevosVault.Boon({
	atlas = "boons",
	display_size = {
		w = 42,
		h = 42,
	},
	pos = { x = 0, y = 0 },
	soul_pos = { x = 0, y = 1 },
	key = "respect",
	set = "crv_boons",
	discovered = true,
	config = {
		extra = {
			original = 0,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.original },
		}
	end,
	cost = 5,
	add_to_deck = function(self, card, from_debuff)
		if #G.jud_boons.cards > 0 then
			for i = 1, #G.jud_boons.cards do
				SMODS.destroy_cards(G.jud_boons.cards[i])
			end
		end
		card.ability.extra.original = SMODS.ObjectTypes["Joker"].rarities[1].weight
		SMODS.ObjectTypes["Joker"].rarities[1].weight = SMODS.ObjectTypes["Joker"].rarities[3].weight
	end,
	remove_from_deck = function(self, card, from_debuff)
		SMODS.ObjectTypes["Joker"].rarities[1].weight = card.ability.extra.original
	end,
})]]

RevosVault.Boon({
	atlas = "boons",
	display_size = {
		w = 42,
		h = 42,
	},
	pos = { x = 4, y = 0 },
	soul_pos = { x = 4, y = 1 },
	key = "leadership",
	set = "crv_boons",
	discovered = true,
	config = {
		extra = {
			xchips = 2,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.xchips },
		}
	end,
	cost = 5,
	calculate = function(self, card, context)
		local jud = card.ability.extra
		if context.individual and context.cardarea == G.play then
			if #context.scoring_hand > 1 then
				if context.other_card ~= context.scoring_hand[1] then
					local a, b = context.other_card:get_id(), context.scoring_hand[1]:get_id()
					if a == b then
						return {
							xchips = jud.xchips,
						}
					end
				end
			end
		end
	end,
})

RevosVault.Boon({
	atlas = "boons",
	display_size = {
		w = 42,
		h = 42,
	},
	pos = { x = 4, y = 2 },
	soul_pos = { x = 4, y = 3 },
	key = "opportunity",
	set = "crv_boons",
	discovered = true,
	config = {
		extra = {},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {},
		}
	end,
	cost = 5,
	calculate = function(self, card, context)
		local _tag = G.GAME.crv_skip_tag
		if context.end_of_round and not G.GAME.blind.boss and G.GAME.current_round.hands_played <= 1 then
			if _tag and _tag.config and _tag.config.ref_table then
				add_tag(_tag.config.ref_table)
				G.GAME.crv_skip_tag = ""
			end
		end
	end,
})

RevosVault.Boon({
	atlas = "boons",
	display_size = {
		w = 42,
		h = 42,
	},
	pos = { x = 5, y = 0 },
	soul_pos = { x = 5, y = 1 },
	key = "love",
	set = "crv_boons",
	discovered = true,
})
