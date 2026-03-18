SMODS.Atlas({
	key = "revo_totems",
	path = "Cross-Mod/felisjokeria/totems.png",
	px = 71,
	py = 95,
})

--[[FELIJO.Consumable({
	key = "felijo_" .. "ttm_hd_printer",
	set = "felijo_totem_parts",
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