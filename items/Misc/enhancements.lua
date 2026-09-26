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
	calculate = function(self, card, context)
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
		"chance",
	},
	loc_vars = function(self, info_queue, card)
		local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "crv_honey_seed")
		return {
			vars = {
				card.ability.extra.dollars,
				num,
				den,
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

SMODS.Enhancement({
	key = "reinforced_glass",
	atlas = "revo_enhancements",
	pos = { x = 0, y = 2 },
	attributes = {
		"xmult",
		"chance",
	},
	config = { extra = { xmult = 3, odds = 6 } },
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		local num, den = SMODS.get_probability_vars(card, 1, cae.odds, "m_reinforced_seed")
		return { vars = { card.ability.extra.xmult, num, den } }
	end,
	calculate = function(self, card, context)
		if context.main_scoring and context.cardarea == G.play then
			return {
				xmult = card.ability.extra.xmult,
			}
		end
		if
			context.destroying_card
			and SMODS.pseudorandom_probability(card, "m_reinforced_seed", 1, card.ability.extra.odds)
			and context.destroy_card == card
		then
			RVF.cool_enhance(card, "m_glass", true, nil, nil, true) -- hello
		end
	end,
	in_pool = function(self)
		return false
	end,
})

SMODS.Enhancement({
	key = "diamond",
	atlas = "revo_enhancements",
	pos = { x = 1, y = 2 },
	attributes = {
		"xmult",
	},
	config = { h_x_mult = 3 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.h_x_mult } }
	end,
	in_pool = function(self)
		return false
	end,
})

SMODS.Enhancement({
	key = "rhodium",
	atlas = "revo_enhancements",
	pos = { x = 2, y = 2 },
	attributes = {
		"economy",
	},
	config = { h_dollars = 6 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.h_dollars } }
	end,
	in_pool = function(self)
		return false
	end,
})

SMODS.Enhancement({
	key = "xmult",
	atlas = "revo_enhancements",
	pos = { x = 3, y = 2 },
	attributes = {
		"economy",
	},
	config = { xmult = 1.5 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.xmult } }
	end,
	in_pool = function(self)
		return false
	end,
})


SMODS.Enhancement {
    key = 'blessed',
    atlas = "revo_enhancements",
	pos = { x = 4, y = 2 },
	attributes = {
		"xmult",
		"economy",
		"chance"
	},
    config = { extra = { odds = 4, odds2 = 10, xmult = 2, dollars = 30} },
    loc_vars = function(self, info_queue, card)
        local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'm_crv_blessed_seed_1')
		local num2, den2 = SMODS.get_probability_vars(card, 1, card.ability.extra.odds2, 'm_crv_blessed_seed_2')
        return { vars = { num, den, den2, card.ability.extra.xmult, card.ability.extra.dollars, num2 } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            local ret = {}
            if SMODS.pseudorandom_probability(card, 'm_crv_blessed_seed_1', 1, card.ability.extra.odds) then
                ret.xmult = card.ability.extra.xmult
            end
            if SMODS.pseudorandom_probability(card, 'm_crv_blessed_seed_2', 1, card.ability.extra.odds2) then
                ret.dollars = card.ability.extra.dollars
            end
            return ret
        end
    end,
}

SMODS.Enhancement({
	key = "boosted",
	atlas = "revo_enhancements",
	pos = { x = 5, y = 2 },
	attributes = {
		"xmult",
	},
	config = { bonus = 80 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.bonus } }
	end,
	in_pool = function(self)
		return false
	end,
})
