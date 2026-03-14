
SMODS.Consumable({
	key = "suppluto",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Planet",
	
	pos = {
		x = 10,
		y = 2,
	},
	pools = {
		SuperiorPlanet = true,
	},
	discovered = true,
	config = {
		max_highlighted = 2,
		extra = { can_activate = true, can_keep = true, level = 1 },
	},
	keep_on_use = function(self, card)
		if card.ability.extra.can_keep == true then
			return true
		end
	end,
	can_use = function(self, card)
		if card.ability.extra.can_activate and (RevosVault.has_room(G.consumeables) or card.area == G.consumeables) then
			return true
		end
	end,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				G.GAME.hands["High Card"].level,
				"High Card",
				G.GAME.hands["High Card"].mult,
				G.GAME.hands["High Card"].chips,
			},
		}
	end,
	use = function(self, card, area, copier)
		card.ability.extra.can_activate = false
		RevosVault.level_up_hand("High Card", card.ability.extra.level, card)
		local eval = function()
			return card.ability.extra.can_activate == false
		end
		juice_card_until(card, eval, true)
		card.ability.extra.can_keep = false
	end,
	calculate = function(self, card, context)
		if context.final_scoring_step and card.ability.extra.can_activate == false and context.scoring_name == "High Card" then
			card.ability.extra.can_keep = false
			RevosVault.boost_hand()
		end
		if context.end_of_round and context.main_eval then
			if card.ability.extra.can_keep == false then
				SMODS.destroy_cards(card)
			end
		end
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_p"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "supmercury",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Planet",
	
	pos = {
		x = 2,
		y = 2,
	},
	pools = {
		SuperiorPlanet = true,
	},
	discovered = true,
	config = {
		max_highlighted = 2,
		extra = { can_activate = true, can_keep = true, level = 1 },
	},
	keep_on_use = function(self, card)
		if card.ability.extra.can_keep == true then
			return true
		end
	end,
	can_use = function(self, card)
		if card.ability.extra.can_activate and (RevosVault.has_room(G.consumeables) or card.area == G.consumeables) then
			return true
		end
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { G.GAME.hands["Pair"].level, "Pair", G.GAME.hands["Pair"].mult, G.GAME.hands["Pair"].chips } }
	end,
	use = function(self, card, area, copier)
		card.ability.extra.can_activate = false
		RevosVault.level_up_hand("Pair", card.ability.extra.level, card)
		local eval = function()
			return card.ability.extra.can_activate == false
		end
		juice_card_until(card, eval, true)
		card.ability.extra.can_keep = false
	end,
	calculate = function(self, card, context)
		if context.jokfinal_scoring_steper_main and card.ability.extra.can_activate == false and context.scoring_name == "Pair" then
			card.ability.extra.can_keep = false
			RevosVault.boost_hand()
		end
		if context.end_of_round and context.main_eval then
			if card.ability.extra.can_keep == false then
				SMODS.destroy_cards(card)
			end
		end
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_p"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "supvenus",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Planet",
	
	pos = {
		x = 3,
		y = 2,
	},
	pools = {
		SuperiorPlanet = true,
	},
	discovered = true,
	config = {
		max_highlighted = 2,
		extra = { can_activate = true, can_keep = true, level = 1 },
	},
	keep_on_use = function(self, card)
		if card.ability.extra.can_keep == true then
			return true
		end
	end,
	can_use = function(self, card)
		if card.ability.extra.can_activate and (RevosVault.has_room(G.consumeables) or card.area == G.consumeables) then
			return true
		end
	end,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				G.GAME.hands["Three of a Kind"].level,
				"Three of a Kind",
				G.GAME.hands["Three of a Kind"].mult,
				G.GAME.hands["Three of a Kind"].chips,
			},
		}
	end,
	use = function(self, card, area, copier)
		card.ability.extra.can_activate = false
		RevosVault.level_up_hand("Three of a Kind", card.ability.extra.level, card)
		local eval = function()
			return card.ability.extra.can_activate == false
		end
		juice_card_until(card, eval, true)
		card.ability.extra.can_keep = false
	end,
	calculate = function(self, card, context)
		if
			context.final_scoring_step
			and card.ability.extra.can_activate == false
			and context.scoring_name == "Three of a Kind"
		then
			card.ability.extra.can_keep = false
			RevosVault.boost_hand()
		end
		if context.end_of_round and context.main_eval then
			if card.ability.extra.can_keep == false then
				SMODS.destroy_cards(card)
			end
		end
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_p"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "supearth",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Planet",
	
	pos = {
		x = 4,
		y = 2,
	},
	pools = {
		SuperiorPlanet = true,
	},
	discovered = true,
	config = {
		max_highlighted = 2,
		extra = { can_activate = true, can_keep = true, level = 1 },
	},
	keep_on_use = function(self, card)
		if card.ability.extra.can_keep == true then
			return true
		end
	end,
	can_use = function(self, card)
		if card.ability.extra.can_activate and (RevosVault.has_room(G.consumeables) or card.area == G.consumeables) then
			return true
		end
	end,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				G.GAME.hands["Full House"].level,
				"Full House",
				G.GAME.hands["Full House"].mult,
				G.GAME.hands["Full House"].chips,
			},
		}
	end,
	use = function(self, card, area, copier)
		card.ability.extra.can_activate = false
		RevosVault.level_up_hand("Full House", card.ability.extra.level, card)
		local eval = function()
			return card.ability.extra.can_activate == false
		end
		juice_card_until(card, eval, true)
		card.ability.extra.can_keep = false
	end,
	calculate = function(self, card, context)
		if context.final_scoring_step and card.ability.extra.can_activate == false and context.scoring_name == "Full House" then
			card.ability.extra.can_keep = false
			RevosVault.boost_hand()
		end
		if context.end_of_round and context.main_eval then
			if card.ability.extra.can_keep == false then
				SMODS.destroy_cards(card)
			end
		end
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_p"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "supmars",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Planet",
	
	pos = {
		x = 5,
		y = 2,
	},
	pools = {
		SuperiorPlanet = true,
	},
	discovered = true,
	config = {
		max_highlighted = 2,
		extra = { can_activate = true, can_keep = true, level = 1 },
	},
	keep_on_use = function(self, card)
		if card.ability.extra.can_keep == true then
			return true
		end
	end,
	can_use = function(self, card)
		if card.ability.extra.can_activate and (RevosVault.has_room(G.consumeables) or card.area == G.consumeables) then
			return true
		end
	end,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				G.GAME.hands["Four of a Kind"].level,
				"Four of a Kind",
				G.GAME.hands["Four of a Kind"].mult,
				G.GAME.hands["Four of a Kind"].chips,
			},
		}
	end,
	use = function(self, card, area, copier)
		card.ability.extra.can_activate = false
		RevosVault.level_up_hand("Four of a Kind", card.ability.extra.level, card)
		local eval = function()
			return card.ability.extra.can_activate == false
		end
		juice_card_until(card, eval, true)
		card.ability.extra.can_keep = false
	end,
	calculate = function(self, card, context)
		if
			context.final_scoring_step
			and card.ability.extra.can_activate == false
			and context.scoring_name == "Four of a Kind"
		then
			card.ability.extra.can_keep = false
			RevosVault.boost_hand()
		end
		if context.end_of_round and context.main_eval then
			if card.ability.extra.can_keep == false then
				SMODS.destroy_cards(card)
			end
		end
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_p"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "supjupiter",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Planet",
	
	pos = {
		x = 6,
		y = 2,
	},
	pools = {
		SuperiorPlanet = true,
	},
	discovered = true,
	config = {
		max_highlighted = 2,
		extra = { can_activate = true, can_keep = true, level = 1 },
	},
	keep_on_use = function(self, card)
		if card.ability.extra.can_keep == true then
			return true
		end
	end,
	can_use = function(self, card)
		if card.ability.extra.can_activate and (RevosVault.has_room(G.consumeables) or card.area == G.consumeables) then
			return true
		end
	end,
	loc_vars = function(self, info_queue, card)
		return {
			vars = { G.GAME.hands["Flush"].level, "Flush", G.GAME.hands["Flush"].mult, G.GAME.hands["Flush"].chips },
		}
	end,
	use = function(self, card, area, copier)
		card.ability.extra.can_activate = false
		RevosVault.level_up_hand("Flush", card.ability.extra.level, card)
		local eval = function()
			return card.ability.extra.can_activate == false
		end
		juice_card_until(card, eval, true)
		card.ability.extra.can_keep = false
	end,
	calculate = function(self, card, context)
		if context.final_scoring_step and card.ability.extra.can_activate == false and context.scoring_name == "Flush" then
			card.ability.extra.can_keep = false
			RevosVault.boost_hand()
		end
		if context.end_of_round and context.main_eval then
			if card.ability.extra.can_keep == false then
				SMODS.destroy_cards(card)
			end
		end
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_p"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "supsaturn",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Planet",
	
	pos = {
		x = 7,
		y = 2,
	},
	pools = {
		SuperiorPlanet = true,
	},
	discovered = true,
	config = {
		max_highlighted = 2,
		extra = { can_activate = true, can_keep = true, level = 1 },
	},
	keep_on_use = function(self, card)
		if card.ability.extra.can_keep == true then
			return true
		end
	end,
	can_use = function(self, card)
		if card.ability.extra.can_activate and (RevosVault.has_room(G.consumeables) or card.area == G.consumeables) then
			return true
		end
	end,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				G.GAME.hands["Straight"].level,
				"Straight",
				G.GAME.hands["Straight"].mult,
				G.GAME.hands["Straight"].chips,
			},
		}
	end,
	use = function(self, card, area, copier)
		card.ability.extra.can_activate = false
		RevosVault.level_up_hand("Straight", card.ability.extra.level, card)
		local eval = function()
			return card.ability.extra.can_activate == false
		end
		juice_card_until(card, eval, true)
		card.ability.extra.can_keep = false
	end,
	calculate = function(self, card, context)
		if context.final_scoring_step and card.ability.extra.can_activate == false and context.scoring_name == "Straight" then
			card.ability.extra.can_keep = false
			RevosVault.boost_hand()
		end
		if context.end_of_round and context.main_eval then
			if card.ability.extra.can_keep == false then
				SMODS.destroy_cards(card)
			end
		end
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_p"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "supuranus",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Planet",
	
	pos = {
		x = 8,
		y = 2,
	},
	pools = {
		SuperiorPlanet = true,
	},
	discovered = true,
	config = {
		max_highlighted = 2,
		extra = { can_activate = true, can_keep = true, level = 1 },
	},
	keep_on_use = function(self, card)
		if card.ability.extra.can_keep == true then
			return true
		end
	end,
	can_use = function(self, card)
		if card.ability.extra.can_activate and (RevosVault.has_room(G.consumeables) or card.area == G.consumeables) then
			return true
		end
	end,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				G.GAME.hands["Two Pair"].level,
				"Two Pair",
				G.GAME.hands["Two Pair"].mult,
				G.GAME.hands["Two Pair"].chips,
			},
		}
	end,
	use = function(self, card, area, copier)
		card.ability.extra.can_activate = false
		RevosVault.level_up_hand("Two Pair", card.ability.extra.level, card)
		local eval = function()
			return card.ability.extra.can_activate == false
		end
		juice_card_until(card, eval, true)
		card.ability.extra.can_keep = false
	end,
	calculate = function(self, card, context)
		if context.final_scoring_step and card.ability.extra.can_activate == false and context.scoring_name == "Two Pair" then
			card.ability.extra.can_keep = false
			RevosVault.boost_hand()
		end
		if context.end_of_round and context.main_eval then
			if card.ability.extra.can_keep == false then
				SMODS.destroy_cards(card)
			end
		end
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_p"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "supneptune",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Planet",
	
	pos = {
		x = 9,
		y = 2,
	},
	pools = {
		SuperiorPlanet = true,
	},
	discovered = true,
	config = {
		max_highlighted = 2,
		extra = { can_activate = true, can_keep = true, level = 1 },
	},
	keep_on_use = function(self, card)
		if card.ability.extra.can_keep == true then
			return true
		end
	end,
	can_use = function(self, card)
		if card.ability.extra.can_activate and (RevosVault.has_room(G.consumeables) or card.area == G.consumeables) then
			return true
		end
	end,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				G.GAME.hands["Straight Flush"].level,
				"Straight Flush",
				G.GAME.hands["Straight Flush"].mult,
				G.GAME.hands["Straight Flush"].chips,
			},
		}
	end,
	use = function(self, card, area, copier)
		card.ability.extra.can_activate = false
		RevosVault.level_up_hand("Straight Flush", card.ability.extra.level, card)
		local eval = function()
			return card.ability.extra.can_activate == false
		end
		juice_card_until(card, eval, true)
		card.ability.extra.can_keep = false
	end,
	calculate = function(self, card, context)
		if
			context.final_scoring_step
			and card.ability.extra.can_activate == false
			and context.scoring_name == "Straight Flush"
		then
			card.ability.extra.can_keep = false
			RevosVault.boost_hand()
		end
		if context.end_of_round and context.main_eval then
			if card.ability.extra.can_keep == false then
				SMODS.destroy_cards(card)
			end
		end
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_p"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "superis",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Planet",
	
	pos = {
		x = 11,
		y = 2,
	},
	discovered = true,
	config = {
		max_highlighted = 2,
		extra = { can_activate = true, can_keep = true, level = 1 },
	},
	keep_on_use = function(self, card)
		if card.ability.extra.can_keep == true then
			return true
		end
	end,
	can_use = function(self, card)
		if card.ability.extra.can_activate and (RevosVault.has_room(G.consumeables) or card.area == G.consumeables) then
			return true
		end
	end,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				G.GAME.hands["Flush Five"].level,
				"Flush Five",
				G.GAME.hands["Flush Five"].mult,
				G.GAME.hands["Flush Five"].chips,
			},
		}
	end,
	use = function(self, card, area, copier)
		card.ability.extra.can_activate = false
		RevosVault.level_up_hand("Flush Five", card.ability.extra.level, card)
		local eval = function()
			return card.ability.extra.can_activate == false
		end
		juice_card_until(card, eval, true)
		card.ability.extra.can_keep = false
	end,
	calculate = function(self, card, context)
		if context.final_scoring_step and card.ability.extra.can_activate == false and context.scoring_name == "Flush Five" then
			card.ability.extra.can_keep = false
			RevosVault.boost_hand()
		end
		if context.end_of_round and context.main_eval then
			if card.ability.extra.can_keep == false then
				SMODS.destroy_cards(card)
			end
		end
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_p"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "supceres",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Planet",
	
	pos = {
		x = 12,
		y = 2,
	},
	discovered = true,
	config = {
		max_highlighted = 2,
		extra = { can_activate = true, can_keep = true, level = 1 },
	},
	keep_on_use = function(self, card)
		if card.ability.extra.can_keep == true then
			return true
		end
	end,
	can_use = function(self, card)
		if card.ability.extra.can_activate and (RevosVault.has_room(G.consumeables) or card.area == G.consumeables) then
			return true
		end
	end,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				G.GAME.hands["Flush House"].level,
				"Flush House",
				G.GAME.hands["Flush House"].mult,
				G.GAME.hands["Flush House"].chips,
			},
		}
	end,
	use = function(self, card, area, copier)
		card.ability.extra.can_activate = false
		RevosVault.level_up_hand("Flush House", card.ability.extra.level, card)
		local eval = function()
			return card.ability.extra.can_activate == false
		end
		juice_card_until(card, eval, true)
		card.ability.extra.can_keep = false
	end,
	calculate = function(self, card, context)
		if
			context.final_scoring_step
			and card.ability.extra.can_activate == false
			and context.scoring_name == "Flush House"
		then
			card.ability.extra.can_keep = false
			RevosVault.boost_hand()
		end
		if context.end_of_round and context.main_eval then
			if card.ability.extra.can_keep == false then
				SMODS.destroy_cards(card)
			end
		end
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_p"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "supplanet_x",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Planet",
	
	pos = {
		x = 13,
		y = 2,
	},
	discovered = true,
	config = {
		max_highlighted = 2,
		extra = { can_activate = true, can_keep = true, level = 1 },
	},
	keep_on_use = function(self, card)
		if card.ability.extra.can_keep == true then
			return true
		end
	end,
	can_use = function(self, card)
		if card.ability.extra.can_activate and (RevosVault.has_room(G.consumeables) or card.area == G.consumeables) then
			return true
		end
	end,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				G.GAME.hands["Five of a Kind"].level,
				"Five of a Kind",
				G.GAME.hands["Five of a Kind"].mult,
				G.GAME.hands["Five of a Kind"].chips,
			},
		}
	end,
	use = function(self, card, area, copier)
		card.ability.extra.can_activate = false
		RevosVault.level_up_hand("Five of a Kind", card.ability.extra.level, card)
		local eval = function()
			return card.ability.extra.can_activate == false
		end
		juice_card_until(card, eval, true)
		card.ability.extra.can_keep = false
	end,
	calculate = function(self, card, context)
		if
			context.final_scoring_step
			and card.ability.extra.can_activate == false
			and context.scoring_name == "Five of a Kind"
		then
			card.ability.extra.can_keep = false
			RevosVault.boost_hand()
		end
		if context.end_of_round and context.main_eval then
			if card.ability.extra.can_keep == false then
				SMODS.destroy_cards(card)
			end
		end
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_p"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})
