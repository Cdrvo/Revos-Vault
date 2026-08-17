SMODS.Joker({
	key = "blueprinter",
	atlas = "revo_jokers",
	rarity = "crv_printer",
	cost = 13,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	attributes = {
		"printer",
		"generation",
		"joker"
	},
	pos = {
		x = 8,
		y = 4,
	},
	config = {
		extra = {},
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_blueprint
	end,

	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint then
			RVF.printer_create(card, {key = "j_blueprint"})
		end
	end,
})

SMODS.Joker({
	key = "gros_printer",
	atlas = "revo_jokers",
	rarity = "crv_printer",
	cost = 13,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	attributes = {
		"printer",
		"generation",
		"joker"
	},
	pos = {
		x = 9,
		y = 4,
	},
	config = {
		extra = {
			odds = 4011
		},
	},
	loc_vars = function(self, info_queue, card)
		local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "gros_seed")
		info_queue[#info_queue + 1] = G.P_CENTERS.j_crv_holy_banana
		return{vars={num, den}}
	end,

	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint then
			if not SMODS.pseudorandom_probability(card, "gros_seed", 1, card.ability.extra.odds) then
				local banana = pseudorandom_element(SMODS.get_attribute_pool("banana"), pseudoseed("gros_seed"))
				RVF.printer_create(card, {key = banana})
			else
				RVF.printer_create(card, {key = "j_crv_holy_banana"})
			end
		end
	end,
})

SMODS.Joker({
	key = "rusty_printer",
	atlas = "revo_jokers",
	rarity = "crv_printer",
	cost = 13,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	attributes = {
		"printer",
		"generation",
		"joker"
	},
	pos = {
		x = 0,
		y = 5,
	},
	config = {
		extra = {},
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_brainstorm
	end,

	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint then
			RVF.printer_create(card, {key = "j_brainstorm"})
		end
	end,
})