SMODS.Joker({
	key = "those_who_joke",
	atlas = "revo_jokers",
	rarity = 2,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,

	pos = {
		x = 7,
		y = 2,
	},
	config = {
		extra = {
			odds = 4,
		},
	},
    attributes = {
        "generation",
        "chance",
    },
	crv_credits = {
		art = { "Crazy Dave" },
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.j_mr_bones
		local cae = card.ability.extra
		local num, den = SMODS.get_probability_vars(card, 1, cae.odds, "j_thoose")
		return {
			vars = { num, den },
		}
	end,

	calculate = function(self, card, context)
		local crv = card.ability.extra
		if context.setting_blind and SMODS.pseudorandom_probability(card, "j_thoose", 1, crv.odds) and not context.blueprint then
			SMODS.add_card({
				key = "j_mr_bones",
				area = G.jokers,
				edition = "e_negative",
			})
			SMODS.destroy_cards(card)
		end
	end,
})

SMODS.Joker{
	key = "rain_rabbit",
	atlas = "revo_jokers",
	rarity = 2,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 9,
		y = 3
	},
	config = {
		extra = {
			mult = 0,
			mult_gain = 10,
			hands = {},
			odds = 4
		}
	},
	loc_vars = function(self, info_queue, card)
		local num, den = SMDOS.get_probability_vars(card, 1, card.ability.extra.odds, "crv_rain_seed")
		return{vars={card.ability.extra.mult_gain, card.ability.extra.mult, num, den}}
	end,
	calculate = function(self, card, context)
		if context.initial_scoring_step and not context.blueprint and not card.ability.extra.hands[context.scoring_name] then
			card.ability.extra.hands[context.scoring_name] = true
			SMODS.scale_card(card,{
				ref_table = card.ability.extra,
				ref_value = "mult",
				scalar_value = "mult_gain",
				message_colour = G.C.MULT
			})
		end
		if context.joker_main then
			return{
				mult = card.ability.extra.mult
			}
		end
		if context.end_of_round and context.main_eval and not context.blueprint and not RVF.card_position(card, card.area).inbetween then
			if SMODS.pseudorandom_probability(card, "crv_rain_seed", 1, card.ability.extra.odds) then
				SMODS.destroy_cards(card)
				return{
					message = localize("k_crv_destroyed")
				}
			else
				return{
					message = localize("k_safe_ex")
				}
			end
		end
		if context.ante_end and not context.blueprint then
			card.ability.extra.hands = {}
			card.ability.extra.mult = 0
			return{
				message = localize("k_reset")
			}
		end
	end
}