SMODS.Atlas({
	key = "revo_totems",
	path = "Cross-Mod/felisadditionsgallery/totems.png",
	px = 71,
	py = 95,
})

--[[FELI_FAG.Consumable({
	key = "feli_fag_" .. "ttm_hd_printer",
	set = "feli_fag_totem_parts",
	config = {
		is_totem_head = true,
		tribe = "Printer",
	},
	atlas = "revo_totems",
	pos = { x = 0, y = 0 },
	cost = 6,
	can_use = function(self, card) end,
	use = function(self, card, area, copier) end,
})
]]

-- on hold im tired