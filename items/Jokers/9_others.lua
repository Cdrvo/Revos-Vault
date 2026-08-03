SMODS.Joker({
	key = "holybanana",
	config = {
		extra = {
			xmult = 4011,
			chips = 4011,
			odds = 4011,
		},
	},
	rarity = "crv_holy",
	atlas = "revo_jokers",
	blueprint_compat = true,
	discovered = false,
    perishable_compat = false,
    eternal_compat = false,
	pos = {
		x = 8,
		y = 0,
	},
	soul_pos = {
		x = 9,
		y = 0,
	},
	cost = 6,
    attributes = {
        "food",
        "xmult",
        "xchips",
        "chance",
		"banana"
    },
	loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        local n, d = SMODS.get_probability_vars(card, 1, cae.odds, "crv_holy_odds")
		return {
			vars = {
				card.ability.extra.xmult,
				card.ability.extra.chips,
				n,d
			},
		}
	end,
	calculate = function(self, card, context)
        local cae = card.ability.extra
		if context.joker_main then
			return {
				x_mult = card.ability.extra.xmult,
				chips = card.ability.extra.chips,
			}
		end
		if context.end_of_round and context.main_eval and not context.blueprint then
			if SMODS.pseudorandom_probability(card,"crv_holy_odds",1,cae.odds) then
				SMODS.destroy_cards(card, {pinch_anim = true})
				G.GAME.pool_flags.holybanana_extinct = true
				return {
					message = localize("k_extinct_ex"),
					delay(0.6),
				}
			else
				return {
					message = localize("k_safe_ex"),
					delay(0.6),
				}
			end
		end
	end,
})