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