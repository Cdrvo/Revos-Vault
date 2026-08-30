SMODS.Atlas{
    key = "modicon",
    path = "modicon.png",
    px = 34,
    py = 34
}

SMODS.Atlas {
    key = "revo_jokers",
    path = "jokers.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "wip",
    path = "wip.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "eol",
    path = "eol.png",
    px = 122,
    py = 95
}

SMODS.Atlas {
    key = "revo_enhancements",
    path = "enhancements.png",
    px = 71,
    py = 95
}

SMODS.Atlas({
	key = "revo_blinds",
	path = "blinds.png",
	atlas_table = "ANIMATION_ATLAS",
	px = 34,
	py = 34,
	frames = 21,
})

SMODS.Atlas({
	key = "shop_sign",
	path = "shop_sign.png",
	atlas_table = "ANIMATION_ATLAS",
	px = 71,
	py = 95,
	frames = 4,
})

SMODS.Atlas({
    key = "revo_tags",
    path = "tags.png",
    px = 34,
    py = 34
})

SMODS.Atlas({
    key = "revo_cartridges",
    path = "cartridges.png",
    px = 71,
    py = 95
})
-- sounds

SMODS.Sound({
	volume = 0.3,
	key = "swoon",
	path = "crv_swoon.ogg",
})


-- attributes

SMODS.Attribute{
    key = "banana",
    keys = {
        "j_gros_michel",
        "j_cavendish"
    },
    alias = {
        "food"
    }
}

SMODS.Attribute{
    key = "printer",
}
-- object types

SMODS.ObjectType({
	key = "Banana",
	inject = function(self)
		SMODS.ObjectType.inject(self)
		self:inject_card(G.P_CENTERS.j_gros_michel)
		self:inject_card(G.P_CENTERS.j_cavendish)
	end,
})


-- taken from Cryptid
SMODS.ObjectType({
	key = "Food",
	default = "j_reserved_parking",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
		-- insert base game food jokers
		self:inject_card(G.P_CENTERS.j_gros_michel)
		self:inject_card(G.P_CENTERS.j_egg)
		self:inject_card(G.P_CENTERS.j_ice_cream)
		self:inject_card(G.P_CENTERS.j_cavendish)
		self:inject_card(G.P_CENTERS.j_turtle_bean)
		self:inject_card(G.P_CENTERS.j_diet_cola)
		self:inject_card(G.P_CENTERS.j_popcorn)
		self:inject_card(G.P_CENTERS.j_ramen)
		self:inject_card(G.P_CENTERS.j_selzer)
	end,
})