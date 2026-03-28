SMODS.PokerHand({
	key = "blackjack",
	mult = 3,
	chips = 21,
	l_mult = 1,
	l_chips = 5,
	example = {
		{ "S_3", true },
		{ "S_5", true },
		{ "D_8", true },
		{ "H_3", true },
		{ "D_2", true },
	},
	evaluate = function(parts, hand)
        local start = 0
        local finish = 21
		for i, card in ipairs(hand) do
			start = start + card.base.nominal
		end
		return start == finish and { hand } or {}
	end,
})
