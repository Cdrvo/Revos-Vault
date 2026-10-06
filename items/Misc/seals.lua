SMODS.Seal({
	key = "printer_seal",
	atlas = "revo_seals",
	pos = { x = 0, y = 0 },
	badge_colour = HEX("A020F0"),
	sound = { sound = "gold_seal", per = 1.2, vol = 0.4 },
	calculate = function(self, card, context)
		if context.main_scoring and context.cardarea == G.play then
			local card = SMODS.copy_card(card, {area = G.hand, playing_card = 1}) -- does this work like this 
			card.states.visible = nil
			card:set_seal() -- fuck vscode for giving me error on this
			G.E_MANAGER:add_event(Event({
				func = function()
					card:start_materialize()
					return true
				end,
			}))
			return {
				message = localize("k_printed_ex"),
			}
		end
	end,
})