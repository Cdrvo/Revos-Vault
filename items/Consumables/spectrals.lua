SMODS.Consumable({
	key = "brush",
	set = "Spectral",
	config = { extra = { cards = 1 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_SEALS["crv_printer_seal"]
		return { vars = { card.ability.extra.cards } }
	end,
	pos = { x = 0, y = 0 },
	atlas = "spec",
	cost = 3,
	unlocked = true,
	discovered = true,
	can_use = function(self, card)
		if G and G.hand then
			if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then 
				return true
			end
		end
		return false
	end,
	use = function(self, card)
		for i, card in pairs(G.hand.highlighted) do
			card:set_seal("crv_printer_seal")
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					G.hand:unhighlight_all()
					return true
				end,
			}))
			delay(0.5)
		end
	end,
})