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