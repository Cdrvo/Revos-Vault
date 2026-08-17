SMODS.Rarity({
	key = "holy",
	badge_colour = G.C.RARITY[2],
	pools = {},
})

SMODS.Rarity({
	key = "printer",
	badge_colour = G.C.RARITY[3],
	pools = {
		["Joker"] = {
			rate = 0.01,
		},
	},
	default_weight = 0.01,
})