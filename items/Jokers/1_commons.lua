SMODS.Joker({
	key = "ghostslices",
	atlas = "revo_jokers",
	rarity = 1,
	cost = 1,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	pos = {
		x = 2,
		y = 1,
	},
	config = {
		extra = {
			chips = 50,
		},
	},
	attributes = {
		"chips",
		"food",
		"banana",
	},
	pools = {
		Food = true,
		Banana = true,
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.chips },
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				chips = card.ability.extra.chips,
			}
		end
	end,
	in_pool = function(self)
		return false
	end,
})

SMODS.Joker({
	key = "golden_banana",
	atlas = "revo_jokers",
	no_pool_flag = "crv_golden_nopool",
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = false,
	pos = {
		x = 1,
		y = 4,
	},
	config = {
		extra = {
			dollars = 2,
			odds = 3,
			odds2 = 6,
		},
	},
	attributes = {
		"banana",
		"food",
		"economy",
		"chance"
	},
	pools = {
		Food = true,
		BananaPool = true,
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		local num, den = SMODS.get_probability_vars(card, 1, cae.odds, "crv_golden_seed")
		local num2, den2 = SMODS.get_probability_vars(card, 1, cae.odds2, "crv_golden_seed")
		return {
			vars = { card.ability.extra.dollars, num, den, den2 },
		}
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		if
			context.individual
			and context.cardarea == G.play
			and SMODS.pseudorandom_probability(card, "crv_golden_seed", 1, cae.odds)
		then
			return {
				dollars = cae.dollars,
			}
		end
		if context.end_of_round and context.main_eval and not context.blueprint then
			if
				SMODS.pseudorandom_probability(card, "crv_golden_seed", 1, card.ability.extra.odds2)
				and not context.blueprint
			then
				SMODS.destroy_cards(card, { pinch_anim = true })
				G.GAME.pool_flags.crv_golden_nopool = true
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

SMODS.Joker({
	key = "daily_news",
	atlas = "revo_jokers",
	rarity = 1,
	cost = 3,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	pos = {
		x = 2,
		y = 4,
	},
	config = {
		extra = {
			odds = 4,
		},
	},
	attributes = {},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		local num,den = SMODS.get_probability_vars(card, 1, cae.odds, "news_seed")
		return {
			vars = { (num), den},
		}
	end,

	calculate = function(self, card, context)
		local cae = card.ability.extra
		if
			context.end_of_round
			and context.main_eval
			and SMODS.pseudorandom_probability(card, "news_seed", 1 ,cae.odds)
			and not context.blueprint
		then
			RVF.add_tag("tag_coupon")
		end
	end,
})