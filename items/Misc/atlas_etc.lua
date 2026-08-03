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

-- object types

SMODS.ObjectType({
	key = "Banana",
	inject = function(self)
		SMODS.ObjectType.inject(self)
		self:inject_card(G.P_CENTERS.j_gros_michel)
		self:inject_card(G.P_CENTERS.j_cavendish)
	end,
})