SMODS.Consumable({
	key = "smertrios",
	set = "Planet",
	atlas = "planetsornot",
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
					((to_big(G.GAME.hands["crv_blackjack"].level) == to_big(1)) and G.C.UI.TEXT_DARK),
				},
			},
		}
	end,
	crv_credits = {
		idea = {"theOfficialFem"},
		art = {"alex343xd"}
	}
})
