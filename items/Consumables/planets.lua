SMODS.Consumable({
	key = "smertrios",
	set = "Planet",
	atlas = "revo_planets",
	pos = {x=0,y=0},
	config = { hand_type = "crv_blackjack", softlock = true },
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				localize("crv_blackjack", "poker_hands"),
				G.GAME.hands["crv_blackjack"].level,
				G.GAME.hands["crv_blackjack"].l_mult,
				G.GAME.hands["crv_blackjack"].l_chips,
				colours = {
					((G.GAME.hands["crv_blackjack"].level == 1) and G.C.UI.TEXT_DARK),
				},
			},
		}
	end,
	crv_credits = {
		idea = {"theOfficialFem"},
		art = {"alex343xd"}
	}
})
