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
	},
	pools = {
		Food = true,
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