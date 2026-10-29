SMODS.Rarity({
	key = "holy",
	badge_colour = G.C.RARITY[2],
	crv_no_agoraphobia = true,
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

SMODS.Rarity({
	key = "mythical",
	badge_colour = SMODS.Gradients["crv_mythical"],
	pools = {},
})