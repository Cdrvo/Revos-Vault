-- Stuff for chaos are still using old keys etc internally
-- (ex: chaos = mythical) below

SMODS.Rarity({
	key = "chaos",
	badge_colour = SMODS.Gradients["crv_mythical"],
	pools = {},
})

--[[SMODS.Consumable({
	key = "chaoticsol",
	set = "Spectral",
	hidden = true,
	soul_set = "Spectral",
	soul_rate = 0.0001, --rare boy
	can_repeat_soul = false,
	config = { extra = {} },
	loc_vars = function(self, info_queue, card)
		return { vars = {} }
	end,
	pos = { x = 1, y = 1 },
	soul_pos = { x = 2, y = 1 },
	atlas = "spec",
	cost = 3,
	unlocked = true,
	discovered = false,
	can_use = function(self, card)
		return true
	end,
	use = function(self, card)
		SMODS.add_card{
			set = "Joker",
			rarity = "crv_chaos",
			area = G.jokers,
		}
	end,
	
})

]]

--[[SMODS.Joker({
	key = "chaoticprintermachine",
	atlas = "Jokers2",
	rarity = "crv_chaos",
	crv_special = true,
	cost = 30,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	pos = {
		x = 11,
		y = 16,
	},
	soul_pos = {
		x = 12,
		y = 16
	},
	config = {
		extra = { odds = 3
 },
	},
	loc_vars = function(self, info_queue, card)
		info_queue[1] = { set = "Other", key = "crv_special_joker" }

		if G.crv_chaoticarea then
			G.crv_chaoticarea:remove()
			G.crv_chaoticarea = nil
		end

		G.crv_chaoticarea = CardArea(
			G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2,
			G.ROOM.T.h,
			G.CARD_W * 4,
			G.CARD_H * 1.1,
			{ card_limit = 5, type = "joker", highlight_limit = 0, no_card_count = true }
		)

		local cae = card.ability.extra

		local t = nil
		if G.crv_chaos_calc and #G.crv_chaos_calc.cards>0 then
			for i = 1, #G.crv_chaos_calc.cards do
				local cc = G.crv_chaos_calc.cards[i]
				local ccf = cc.config.center
				local card = SMODS.create_card{key = ccf.key, area = G.crv_chaoticarea, no_edition = true}
				card.crv_fake = true
				G.crv_chaoticarea:emplace(card)
			end

			t = {
				{
					n = G.UIT.C,
					config = { align = "bm", padding = 0.02 },
					nodes = {
						{ n = G.UIT.O, config = { object = G.crv_chaoticarea } },
					},
				},
			}
		else
			t = nil
		end


		print(t==nil)
		return {
			main_end = t
			--vars = { cae.cj1, cae.cj2, cae.c1, cae.c2 },
		}

	end,
	calculate = function(self, card, context)
		if
			context.setting_blind
			and not context.blueprint
		then
			if #G.crv_chaos_calc.cards>0 then
				for i = 1, #G.crv_chaos_calc.cards do
					G.crv_chaos_calc.cards[i]:start_dissolve(nil, true)
				end
			end

			for i = 1, 5 do
				SMODS.add_card{set = "Joker", area = G.crv_chaos_calc, rarity = "crv_p"}
			end
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
})]]

SMODS.Joker({
	key = "thefaxprinter",
	discovered = false,
	unlocked = true,
	rarity = "crv_chaos",
	atlas = "Jokers2",
	blueprint_compat = true,
	pos = {
		x = 5,
		y = 16,
	},
	soul_pos = {
		x = 6,
		y = 16
	},
	cost = 30,
	config = {
		extra = {
			a = 5
		}
	},
	eternal_compat = true,
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra 
		info_queue[#info_queue + 1] = G.P_CENTERS.j_crv_promotion
		return { vars = { cae.a} }
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.setting_blind then
			local _key = pseudorandom_element(SMODS.get_clean_pool("EnchancedDocuments"), pseudoseed("randomnessgoesbrr"))
			for i = 1, cae.a do
				RevosVault.pseudorandom_printer({card = card,seed = "j_crv_thefax",area = G.consumeables, key = _key, always_negative = true })
			end
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
})

--[[SMODS.Joker({
	key = "promotion",
	config = { extra = { chips = 36286368, xmult = 4153211351420 } },
	rarity = "crv_chaos",
	atlas = "chaosa",
	blueprint_compat = true,
	discovered = false,
	pos = { x = 0, y = 0 },
	cost = 6,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips, card.ability.extra.xmult } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:is_face() or context.other_card:get_id() == 14 then
				return {
					chips = card.ability.extra.chips,
					x_mult = card.ability.extra.xmult,
					card = card.other_card,
				}
			end
		end
	end,

	in_pool = function(self, wawa, wawa2)
		return false
	end,
})]]

SMODS.Joker({
	key = "dirtinator9999",
	atlas = "Jokers2",
	rarity = "crv_chaos",
	cost = 30,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	config = { extra = {} },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_crv_dirt
		return { vars = { card.ability.extra.xmult } }
	end,
	calculate = function(self, card, context)
		if context.first_hand_drawn then
			RevosVault.printer_apply("m_crv_dirt")
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
	pos = {
		x = 11,
		y = 15,
	},
	soul_pos = {
		x = 12,
		y = 15
	},
})

--[[SMODS.Consumable({
	key = "dirtdocument", 
	set = "EnchancedDocuments", 
	atlas = "chaosa",
	pos = { x = 2, y = 1 }, 
	discovered = true,
	config = {
		extra = {
			active = false,
			x_mult = 99999999
		},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
	keep_on_use = function(self,card)
		return true
	end,
	can_use = function(self, card)
		return card.ability.extra.active == false
	end,
	use = function(self, card, area, copier)
		card.ability.extra.active = true
	end,
	in_pool = function(self, wawa, wawa2)
		return false
	end,
	calculate = function(self,card,context)
		if card.ability.extra.active and context.individual then
			if SMODS.has_enhancement(context.other_card,"m_crv_dirt") then
				SMODS.destroy_cards(context.other_card)
			else
			return{
				xmult = card.ability.extra.x_mult
			}
		end
	end
		if context.end_of_round and card.ability.extra.active then 
			SMODS.destroy_cards(card)
		end
	end
})]]

SMODS.Enhancement({
	key = "dirt",
	atlas = "enh",
	pos = { x = 3, y = 3 },
	discovered = true,
	unlocked = true,
	replace_base_card = true,
	no_rank = true,
	no_suit = true,
	overrides_base_rank = true,
	any_suit = false,
	always_scores = true,
	weight = 0,
	config = { extra = { xchips = 16 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xchips } }
	end,
	calculate = function(self, card, context, effect)
		if
			context.main_scoring and context.cardarea == G.play
		then
			return {
				xchips = card.ability.extra.xchips,
			}
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return false
	end,
})

--[[SMODS.Joker({
	key = "holyprinter",
	atlas = "Jokers2",
	rarity = "crv_chaos",
	cost = 30,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	config = {
		extra = {},
	},
	pos = {
		x = 7,
		y = 16,
	},
	soul_pos = {
		x = 8,
		y = 16
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_crv_holybanana
		return { vars = {} }
	end,
	calculate = function(self, card, context)
		if context.setting_blind then
			RevosVault.pseudorandom_printer({card = card,seed = "j_crv_thefax",area = G.jokers, key = "j_crv_holybanana"})
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
})]]

SMODS.Joker({
	key = "hfj", -- ??????? what the actual fuck is this // idk what i ranted about here
	atlas = "Jokers2",
	rarity = "crv_chaos",
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 11,
		y = 13,
	},
	soul_pos = {
		x = 12,
		y = 13
	},
	config = {
		extra = { one = 0, xmult = 0, ok = 0 },
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult, card.ability.extra.ok } }
	end,

	calculate = function(self, card, context)
		local cae = card.ability.extra
		if context.after and not context.blueprint and G.GAME.current_round.hands_played==0 then
			cae.xmult = (to_number(hand_chips)+to_number(mult))/4
			return{
				message = localize("k_crv_stored")
			}
		end
		if context.joker_main and cae.xmult>0 then
			return{
				xmult = cae.xmult
			}
		end
		if context.end_of_round and context.main_eval and not context.blueprint then
			cae.xmult = 0
			return{
				message = localize("k_reset")
			}
		end
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
})

SMODS.Joker({
	key = "masterofjokers",
	atlas = "Jokers2",
	rarity = "crv_chaos",
	cost = 30,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 11,
		y = 14,
	},
	soul_pos = {
		x = 12,
		y = 14
	},
	config = {
		extra = {multi = 2},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.multi} }
	end,
	add_to_deck = function(self,card,from_debuff)
		local old, new = 0, nil
		for i = 1, G.jokers.config.card_limit do
			old = old + 1
			--print(old)
		end
		new = G.jokers.config.card_limit * card.ability.extra.multi
		G.jokers.config.card_limit = G.jokers.config.card_limit * card.ability.extra.multi
	
		--print(old, new)

		card.ability.extra.multi_aftermath = new - old
	end,
	remove_from_deck = function(self,card,from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.multi_aftermath
	end
})

--[[SMODS.Joker({
	key = "crash", --wow
	loc_vars = function(self, info_queue, card)
		return {
			vars = {},
		}
	end,
	atlas = "chaosa",
	rarity = "crv_chaos",
	cost = 30,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 2,
		y = 2,
	},
	config = {
		extra = {},
	},

	calculate = function(self, card, context)
		if context.setting_blind and G.GAME.blind.boss then
			for i = 1, G.jokers.config.card_limit - #G.jokers.cards do
				SMODS.add_card{
					key = "j_chicot"
				}
			end
		end
	end,
})
]]