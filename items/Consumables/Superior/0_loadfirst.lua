-- Superior Card Type

SMODS.ConsumableType({
	key = "Superior",

	collection_rows = { 4, 5 },
	primary_colour = RevosVault.C.SUP,
	secondary_colour = RevosVault.C.SUP,
	default = "c_crv_supfool",
	inject = function(self)
		SMODS.ObjectType.inject(self)
		G.localization.descriptions[self.key] = G.localization.descriptions[self.key] or {}
		G.C.SET[self.key] = self.primary_colour
		G.C.SECONDARY_SET[self.key] = self.secondary_colour
		G.C.UI[self.key] = self.text_colour or G.C.UI.TEXT_LIGHT
		G.FUNCS["your_collection_" .. string.lower(self.key) .. "s"] = function(e)
			G.FUNCS.your_collection_SUPERIORSCRV()
		end
	end,
})

SMODS.ObjectType({
	key = "SuperiorTarot",
	cards = {},
})

SMODS.ObjectType({
	key = "SuperiorSpectral",
	cards = {},
})

SMODS.ObjectType({
	key = "SuperiorPlanet",
	cards = {},
})

SMODS.ObjectType({
	key = "SuperiorEnchancedDocuments",
	cards = {},
})

SMODS.ObjectType({
	key = "Superiorscrap",
	cards = {},
})


--[[ template for copy pasting

SMODS.Consumable({
	key = "supKEY",
	discovered = true, 
	unlocked = true,
	set = "Superior",
	atlas = "Superior",
    crv_in_set = "CONSUMABLE_SET",
	cost = 0,
	pos = { x = 0, y = 0 },
	can_use = function(self, card)
		return true
	end,
    pools = {
        SuperiorCONSUMABLE_SET = true
    },
	use = function()
		
	end,
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("STRING"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})


]]