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
	attributes = {
		"xmult",
		"chance",
		"destroy_card",
	},
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

SMODS.Enhancement({
	key = "honey",
	atlas = "revo_enhancements",
	pos = { x = 0, y = 1 },
	discovered = true,
	unlocked = true,
	config = {
		extra = { dollars = 3, odds = 3 },
	},
	attributes = {
		"economy",
		"chance"
	},
	loc_vars = function(self, info_queue, card)
		local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "crv_honey_seed")
		return {
			vars = {
				card.ability.extra.dollars,
				num,
				den
			},
		}
	end,
	calculate = function(self, card, context)
		if context.main_scoring and context.cardarea == G.play then
			return {
				dollars = card.ability.extra.dollars,
			}
		end
		if
			context.stay_flipped
			and context.other_card == card
			and context.to_area == G.discard
			and SMODS.pseudorandom_probability(card, "crv_honey_seed", 1, card.ability.extra.odds)
			and G.GAME.blind.in_blind
		then
			return { message = localize("k_crv_sticky"), modify = { to_area = G.hand } }
		end
	end,
	crv_credits = {
		art = "mr.cr33ps",
	},
})
