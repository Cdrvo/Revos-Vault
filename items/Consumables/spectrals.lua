SMODS.Consumable({
	key = "brush",
	atlas = "revo_spectrals",
	set = "Spectral",
	pos = { x = 0, y = 0 },
	config = { max_highlighted = 1, extra = { seal = "crv_printer_seal" } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
		return { vars = { card.ability.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		local conv_card = G.hand.highlighted[1]
		G.E_MANAGER:add_event(Event({
			func = function()
				play_sound("tarot1")
				card:juice_up(0.3, 0.5)
				return true
			end,
		}))

		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.1,
			func = function()
				conv_card:set_seal(card.ability.extra.seal, nil, true)
				return true
			end,
		}))

		delay(0.5)
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.2,
			func = function()
				G.hand:unhighlight_all()
				return true
			end,
		}))
	end,
})

SMODS.Consumable({
	key = "crown",
	atlas = "revo_spectrals",
	set = "Spectral",
	pos = { x = 1, y = 1 },
	config = { max_highlighted = 1, extra = { seal = "crv_royal" } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
		return { vars = { card.ability.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		local conv_card = G.hand.highlighted[1]
		G.E_MANAGER:add_event(Event({
			func = function()
				play_sound("tarot1")
				card:juice_up(0.3, 0.5)
				return true
			end,
		}))

		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.1,
			func = function()
				conv_card:set_seal(card.ability.extra.seal, nil, true)
				return true
			end,
		}))

		delay(0.5)
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.2,
			func = function()
				G.hand:unhighlight_all()
				return true
			end,
		}))
	end,
})
