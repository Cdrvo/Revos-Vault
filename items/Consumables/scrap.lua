SMODS.ConsumableType({
	key = "crv_Scrap",
	collection_rows = { 4, 5 },
	primary_colour = G.C.RED,
	secondary_colour = G.C.RED,
	shop_rate = nil,
})

SMODS.Consumable({
	in_pool = function(self)
		return true, { allow_duplicates = true }
	end,
	key = "horn",
	discovered = true,
	unlocked = true,
	set = "crv_Scrap",
	atlas = "revo_scraps",
	cost = 0,
	config = {
		extra = {
			dollars = 20
		}
	},
	pos = { x = 2, y = 0 },
	loc_vars = function(self, info_queue, card)
		return{vars={card.ability.extra.dollars}}
	end,s = { x = 2, y = 0 },
	can_use = function(self, card)
		return true
	end,
	use = function(self, card, area, copier)
		ease_dollars(card.ability.extra.dollars)
	end,
})

SMODS.Consumable({
	in_pool = function(self)
		return true, { allow_duplicates = true }
	end,
	key = "pickles",
	discovered = true,
	unlocked = true,
	set = "crv_Scrap",
	atlas = "revo_scraps",
	cost = 0,
	pos = { x = 0, y = 0 },
	config = {
		extra = {
			dollars = 15
		}
	},
	loc_vars = function(self, info_queue, card)
		return{vars={card.ability.extra.dollars}}
	end,
	can_use = function(self, card)
		return true
	end,
	use = function(self, card, area, copier)
		ease_dollars(card.ability.extra.dollars)
	end,
})
SMODS.Consumable({
	in_pool = function(self)
		return true, { allow_duplicates = true }
	end,
	key = "metal_piece",
	discovered = true,
	unlocked = true,
	set = "crv_Scrap",
	atlas = "revo_scraps",
	cost = 0,
	pos = { x = 1, y = 0 },
	config = {
		extra = {
			dollars = 10
		}
	},
	loc_vars = function(self, info_queue, card)
		return{vars={card.ability.extra.dollars}}
	end,
	can_use = function(self, card)
		return true
	end,
	use = function(self, card, area, copier)
		ease_dollars(card.ability.extra.dollars)
	end,
})

SMODS.Consumable({
	in_pool = function(self)
		return true, { allow_duplicates = true }
	end,
	key = "apparatus",
	discovered = true,
	unlocked = true,
	set = "crv_Scrap",
	atlas = "revo_scraps",
	cost = 0,
	pos = { x = 3, y = 0 },
	config = {
		extra = {
			dollars = 25
		}
	},
	loc_vars = function(self, info_queue, card)
		return{vars={card.ability.extra.dollars}}
	end,
	can_use = function(self, card)
		return true
	end,
	use = function(self, card, area, copier)
		ease_dollars(card.ability.extra.dollars)
	end,
})

SMODS.Consumable({
	in_pool = function(self)
		return true, { allow_duplicates = true }
	end,
	key = "duck",
	discovered = true,
	unlocked = true,
	set = "crv_Scrap",
	atlas = "revo_scraps",
	cost = 0,
	pos = { x = 4, y = 0 },
	config = {
	extra = {
			dollars = 5
		}
	},
	loc_vars = function(self, info_queue, card)
		return{vars={card.ability.extra.dollars}}
	end,
	can_use = function(self, card)
		return true
	end,
	use = function(self, card, area, copier)
		ease_dollars(card.ability.extra.dollars)
	end,
})