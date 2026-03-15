SMODS.Consumable({
	key = "suphorn",
	discovered = true,
	unlocked = true,
	set = "Superior",
	atlas = "Superior",
    crv_in_set = "scrap",
	cost = 0,
	pos = { x = 15, y = 3 },
	can_use = function(self, card)
		return true
	end,
    pools = {
        Superiorscrap = true
    },
	use = function()
		return {
			ease_dollars(60),
		}
	end,
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_scrap"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "suppickles",
	discovered = true,
	unlocked = true,
	set = "Superior",
	atlas = "Superior",
    crv_in_set = "scrap",
	cost = 0,
	pos = { x = 13, y = 3 },
	can_use = function(self, card)
		return true
	end,
    pools = {
        Superiorscrap = true
    },
	use = function()
		return {
			ease_dollars(45),
		}
	end,
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_scrap"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "supmp",
	discovered = true,
	unlocked = true,
	set = "Superior",
	atlas = "Superior",
    crv_in_set = "scrap",
	cost = 0,
	pos = { x = 14, y = 3 },
	can_use = function(self, card)
		return true
	end,
    pools = {
        Superiorscrap = true
    },
	use = function()
		return {
			ease_dollars(30),
		}
	end,
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_scrap"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "supap",
	discovered = true,
	unlocked = true,
	set = "Superior",
	atlas = "Superior",
    crv_in_set = "scrap",
	cost = 0,
	pos = { x = 16, y = 3 },
	can_use = function(self, card)
		return true
	end,
    pools = {
        Superiorscrap = true
    },
	use = function()
		return {
			ease_dollars(75),
		}
	end,
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_scrap"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "supdc",
	discovered = true,
	unlocked = true,
	set = "Superior",
	atlas = "Superior",
    crv_in_set = "scrap",
	cost = 0,
	pos = { x = 17, y = 3 },
	can_use = function(self, card)
		return true
	end,
    pools = {
        Superiorscrap = true
    },
	use = function()
		return {
			ease_dollars(15),
		}
	end,
    set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_scrap"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})