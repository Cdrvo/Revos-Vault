SMODS.Back({
	key = "golden_deck",
	atlas = "revo_decks",
	pos = {
		x = 0,
		y = 0,
	},

	crv_credits = {
		idea = { "superb_thing" },
	},

	crv_apply = function(self)
		SMODS.set_scoring_calculation("crv_dollar_scoring")
	end,
})


SMODS.Back({
	key = "printer_deck",
	atlas = "revo_decks",
	pos = {
		x = 1,
		y = 0,
	},

	crv_credits = {
		idea = { "superb_thing" },
	},
})
