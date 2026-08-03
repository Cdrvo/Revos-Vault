SMODS.Enhancement({
	key = "bomb",
	atlas = "revo_enhancements",
	pos = { x = 0, y = 0 },
	discovered = true,
	unlocked = true,
	replace_base_card = true,
	no_rank = true,
	no_suit = true,
	overrides_base_rank = false,
	any_suit = false,
	always_scores = true,
	config = { extra = { xmult = 2, odds = 2 } },
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		local num, den = SMODS.get_probability_vars(card, 1, cae.odds, "m_bomb_seed")
		return { vars = { card.ability.extra.xmult, num, den } }
	end,
	calculate = function(self, card, context, effect)
		if context.main_scoring and context.cardarea == G.play then
			return {
				xmult = card.ability.extra.xmult,
			}
		end
		if
			context.destroying_card
			and SMODS.pseudorandom_probability(card, "m_bomb_seed", 1, card.ability.extra.odds)
			and context.destroy_card == card
		then
			return {
				remove = true,
			}
		end
	end,
	in_pool = function(self)
		return false
	end,
})
