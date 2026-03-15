SMODS.Consumable({
	key = "supfamiliar",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Spectral",

	pos = {
		x = 10,
		y = 0,
	},
	pools = {
		SuperiorSpectral = true,
	},
	discovered = true,
	config = {
		extra = { cards = 3 },
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
	can_use = function(self, card)
		local cards = {}
		if G and G.hand and #G.hand.cards > 0 then
			for i = 1, #G.hand.cards do
				if not G.hand.cards[i]:is_face() then
					cards[#cards + 1] = G.hand.cards[i]
					if #cards > 0 then
						return true
					end
				end
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		local cards = {}
		for i = 1, #G.hand.cards do
			if not G.hand.cards[i]:is_face() then
				cards[#cards + 1] = G.hand.cards[i]
			end
		end
		SMODS.destroy_cards(pseudorandom_element(cards))
		for i = 1, card.ability.extra.cards do
			SMODS.add_card({
				set = "Enhanced",
				area = G.hand,
				edition = poll_edition(pseudorandom("supfam"), nil, true, true),
				rank = pseudorandom_element(RevosVault.facepool()).card_key,
			})
		end
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_s"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "supgrim",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Spectral",

	pos = {
		x = 11,
		y = 0,
	},
	pools = {
		SuperiorSpectral = true,
	},
	discovered = true,
	config = {
		extra = { cards = 2 },
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
	can_use = function(self, card)
		local cards = {}
		if G and G.hand and #G.hand.cards > 0 then
			for i = 1, #G.hand.cards do
				if G.hand.cards[i]:get_id() == 14 then
					cards[#cards + 1] = G.hand.cards[i]
					if #cards > 0 then
						return true
					end
				end
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		local cards = {}
		for i = 1, #G.hand.cards do
			if G.hand.cards[i]:get_id() == 14 then
				cards[#cards + 1] = G.hand.cards[i]
			end
		end
		SMODS.destroy_cards(pseudorandom_element(cards))
		for i = 1, card.ability.extra.cards do
			SMODS.add_card({
				set = "Enhanced",
				area = G.hand,
				edition = poll_edition(pseudorandom("supgrim"), nil, true, true),
				rank = "Ace",
			})
		end
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_s"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "supincantation",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Spectral",

	pos = {
		x = 12,
		y = 0,
	},
	pools = {
		SuperiorSpectral = true,
	},
	discovered = true,
	config = {
		extra = { cards = 6 },
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
	can_use = function(self, card)
		local cards = {}
		if G and G.hand and #G.hand.cards > 0 then
			for i = 1, #G.hand.cards do
				cards[#cards + 1] = G.hand.cards[i]
				if #cards > 0 then
					return true
				end
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		local cards = {}
		for i = 1, #G.hand.cards do
			cards[#cards + 1] = G.hand.cards[i]
		end
		SMODS.destroy_cards(pseudorandom_element(cards))
		for i = 1, card.ability.extra.cards do
			SMODS.add_card({
				set = "Enhanced",
				area = G.hand,
				edition = poll_edition(pseudorandom("supgrim"), nil, true, true),
				rank = pseudorandom_element(SMODS.Ranks, pseudoseed("unowild")).card_key,
			})
		end
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_s"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "suptalisman",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Spectral",

	pos = {
		x = 13,
		y = 0,
	},
	pools = {
		SuperiorSpectral = true,
	},
	discovered = true,
	config = {
		max_highlighted = 2,
		extra = { cards = 2 },
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
	use = function(self, card, area, copier)
		for k, card2 in pairs(G.hand.highlighted) do
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
					card2:set_seal("Gold", nil, true)
					card2:set_ability("m_gold")
					return true
				end,
			}))
			G.hand:unhighlight_all()
		end
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_s"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "supaura",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Spectral",

	pos = {
		x = 14,
		y = 0,
	},
	discovered = true,
	config = {
		max_highlighted = 2,
		extra = { cards = 2 },
	},
	pools = {
		SuperiorSpectral = true,
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
	can_use = function(self, card)
		if G and G.jokers and #G.jokers.highlighted > 0 and #G.jokers.highlighted < self.config.max_highlighted + 1 then
			return true
		end
		return false
	end,
	use = function(self, card, area, copier)
		for k, card2 in pairs(G.jokers.highlighted) do
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
					card2:set_edition(pseudorandom_element({ "e_polychrome", "e_negative" }))
					return true
				end,
			}))
		end
		G.jokers:unhighlight_all()
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_s"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "supwraith",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Spectral",

	pos = {
		x = 15,
		y = 0,
	},
	pools = {
		SuperiorSpectral = true,
	},
	discovered = true,
	config = {
		max_highlighted = 2,
		extra = { cards = 2, odds = 6 },
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		local num, den = SMODS.get_probability_vars(card, 1, cae.odds, "wraith_seed")
		return { vars = { card.ability.extra.cards, den, num } }
	end,
	can_use = function(self, card)
		return RevosVault.has_room(G.jokers)
	end,
	use = function(self, card, area, copier)
		if
			SMODS.pseudorandom_probability(card, "wraith_seed", 1, card.ability.extra.odds)
			and G.jokers.config.card_limit > #G.jokers.cards
		then
			SMODS.add_card({
				set = "Joker",
				legendary = true,
			})
		elseif G.jokers.config.card_limit > #G.jokers.cards then
			SMODS.add_card({
				set = "Joker",
				rarity = "Rare",
			})
		end
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_s"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "supsigil",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Spectral",

	pos = {
		x = 16,
		y = 0,
	},
	discovered = true,
	config = {
		max_highlighted = 1,
		extra = { cards = 2, odds = 6 },
	},
	pools = {
		SuperiorSpectral = true,
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards, card.ability.extra.odds, (G.GAME.probabilities.normal or 1) } }
	end,
	use = function(self, card, area, copier)
		for i = 1, #G.hand.cards do
			local card2 = G.hand.cards[i]
			local _suit = G.hand.highlighted[1].base.suit
			card2:flip()
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound("tarot1")
					card2:juice_up(0.3, 0.4)
					return true
				end,
			}))

			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.1,
				func = function()
					SMODS.change_base(card2, _suit, nil)
					return true
				end,
			}))
			card2:flip()
		end
		G.hand:unhighlight_all()
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_s"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "supouija",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Spectral",

	pos = {
		x = 17,
		y = 0,
	},
	pools = {
		SuperiorSpectral = true,
	},
	discovered = true,
	config = {
		max_highlighted = 1,
		extra = { cards = 2, odds = 6 },
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards, card.ability.extra.odds, (G.GAME.probabilities.normal or 1) } }
	end,
	use = function(self, card, area, copier)
		for i = 1, #G.hand.cards do
			local card2 = G.hand.cards[i]
			local _rank = G.hand.highlighted[1]:get_original_rank()
			if card2 ~= G.hand.highlighted[1] then
				card2:flip()
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound("tarot1")
						card2:juice_up(0.3, 0.4)
						return true
					end,
				}))

				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.1,
					func = function()
						SMODS.change_base(card2, nil, _rank)
						return true
					end,
				}))
				card2:flip()
			end
		end
		G.hand:unhighlight_all()
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_s"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "supectoplasm",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Spectral",

	pos = {
		x = 18,
		y = 0,
	},
	discovered = true,
	config = {
		extra = { cards = 2 },
	},
	pools = {
		SuperiorSpectral = true,
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
	can_use = function(self, card)
		local _cards = {}
		for i = 1, #G.jokers.cards do
			if not G.jokers.cards[i].edition then
				_cards[#_cards + 1] = G.jokers.cards[i]
			end
		end
		if #_cards > 0 then
			return true
		end
	end,
	use = function(self, card, area, copier)
		local crv = card.ability.extra
		local _cards = {}
		for i = 1, #G.jokers.cards do
			if not G.jokers.cards[i].edition then
				_cards[#_cards + 1] = G.jokers.cards[i]
			end
		end
		for i = 1, card.ability.extra.cards do
			if #_cards == 0 then
				break
			end
			local _cards1 = RevosVault.random_joker(_cards)
			local num = RevosVault.index(_cards, _cards1)
			table.remove(_cards, num)
			_cards1:set_edition("e_negative")
		end
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_s"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "supimmolate",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Spectral",

	pos = {
		x = 19,
		y = 0,
	},
	pools = {
		SuperiorSpectral = true,
	},
	discovered = true,
	config = {
		extra = { cards = 3, dollars = 20 },
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards, card.ability.extra.dollars } }
	end,
	can_use = function(self, card)
		local _cards = {}
		if #G.hand.highlighted == card.ability.extra.cards then
			return true
		end
	end,
	use = function(self, card, area, copier)
		for k, cards2 in pairs(G.hand.cards) do
			SMODS.destroy_cards(cards2)
		end
		ease_dollars(card.ability.extra.dollars)
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_s"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "supankh",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Spectral",

	pos = {
		x = 10,
		y = 1,
	},
	discovered = true,
	config = {
		extra = { cards = 1, odds = 6 },
	},
	pools = {
		SuperiorSpectral = true,
	},
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		local num, den = SMODS.get_probability_vars(card, 1, cae.odds, "supankh_seed")
		return { vars = { card.ability.extra.cards, num, den } }
	end,
	can_use = function(self, card)
		local _cards = {}
		if #G.jokers.highlighted == 1 then
			return true
		end
	end,
	use = function(self, card, area, copier)
		local acard
		for k, cards2 in pairs(G.jokers.highlighted) do
			acard = copy_card(cards2)
			acard:add_to_deck()
			G.jokers:emplace(acard)
		end
		if SMODS.pseudorandom_probability(card, "supankh_seed", 1, card.ability.extra.odds) then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] ~= acard or G.jokers.cards[i] ~= G.jokers.highlighted[1] then
					SMODS.destroy_cards(G.jokers.cards[i])
				end
			end
		end
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_s"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "supdeja_vu",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Spectral",

	pos = {
		x = 11,
		y = 1,
	},
	pools = {
		SuperiorSpectral = true,
	},
	discovered = true,
	config = {
		max_highlighted = 2,
		extra = { cards = 2 },
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
	use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			v:flip()
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.2,
				func = function()
					v:set_seal("Red", nil, true)
					v:set_ability(pseudorandom_element({ "m_lucky", "m_glass" }))
					return true
				end,
			}))
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					v:flip()
					G.hand:unhighlight_all()
					return true
				end,
			}))
		end
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_s"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "suphex",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Spectral",

	pos = {
		x = 12,
		y = 1,
	},
	pools = {
		SuperiorSpectral = true,
	},
	discovered = true,
	config = {
		max_highlighted = 2,
		extra = { cards = 2 },
	},
	can_use = function(self, card)
		if #G.jokers.highlighted == 1 then
			return true
		end
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
	use = function(self, card, area, copier)
		G.jokers.highlighted[1]:set_edition("e_polychrome")
		local joker = G.jokers.cards
		local rr = RevosVault.index(G.jokers.cards, G.jokers.highlighted[1])
		if joker[rr + 1] and joker[rr - 1] then
			SMODS.destroy_cards(pseudorandom_element({ joker[rr + 1], joker[rr - 1] }))
		elseif joker[rr + 1] then
			SMODS.destroy_cards(joker[rr + 1])
		elseif joker[rr - 1] then
			SMODS.destroy_cards(joker[rr - 1])
		else
		end
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_s"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "suptrance",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Spectral",

	pos = {
		x = 13,
		y = 1,
	},
	pools = {
		SuperiorSpectral = true,
	},
	discovered = true,
	config = {
		max_highlighted = 2,
		extra = { cards = 2 },
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
	use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			v:flip()
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.2,
				func = function()
					v:set_seal("Blue", nil, true)
					v:set_ability("m_steel")
					return true
				end,
			}))
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					v:flip()
					G.hand:unhighlight_all()
					return true
				end,
			}))
		end
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_s"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "supmedium",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Spectral",

	pos = {
		x = 14,
		y = 1,
	},
	pools = {
		SuperiorSpectral = true,
	},
	discovered = true,
	config = {
		max_highlighted = 2,
		extra = { cards = 2 },
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
	use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			v:flip()
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.2,
				func = function()
					v:set_seal("Purple", nil, true)
					v:set_ability("m_steel")
					return true
				end,
			}))
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					v:flip()
					G.hand:unhighlight_all()
					return true
				end,
			}))
		end
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_s"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "supcryptid",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Spectral",

	pos = {
		x = 15,
		y = 1,
	},
	pools = {
		SuperiorSpectral = true,
	},
	discovered = true,
	config = {
		max_highlighted = 2,
		extra = { cards = 2 },
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
	use = function(self, card, area, copier)
		for i = 1, card.ability.extra.cards do
			local acard = copy_card(G.hand.highlighted[1])
			G.deck.config.card_limit = G.deck.config.card_limit + 1
			table.insert(G.playing_cards, acard)
			acard:set_edition("e_negative")
			acard:add_to_deck()
			if #G.hand.cards > 0 then
				G.hand:emplace(acard)
			else
				G.deck:emplace(acard)
			end
		end
		G.hand:unhighlight_all()
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_s"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

if RevoConfig and RevoConfig["7_chaos_enabled"] then
	SMODS.Consumable({
		key = "supsoul",
		set = "Superior",
		atlas = "Superior",
		crv_in_set = "Spectral",

		pos = {
			x = 17,
			y = 1,
		},
		crv_soul_pos = {
			x = 18,
			y = 1,
		},
		pools = {
			SuperiorSpectral = true,
		},
		discovered = true,
		config = {
			extra = {},
		},
		loc_vars = function(self, info_queue, card)
			return { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 }
		end,
		can_use = function()
			return RevosVault.check("space", G.jokers)
		end,
		use = function(self, card, area, copier)
			check_for_unlock({ type = "crv_myths" })
			RevosVault.use_with_sound(card, {
				sound_speed = 0.8,
				func = function()
					SMODS.add_card({ set = "Joker", rarity = "crv_chaos" })
				end,
			})
		end,
		set_card_type_badge = function(self, card, badges)
			badges[1] = create_badge(localize("k_superior_s"), get_type_colour(self or card.config, card), nil, 1.2)
		end,
		in_pool = function(self)
			return false
		end,
	})
end

SMODS.Consumable({
	key = "supbrush",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Spectral",

	pos = {
		x = 4,
		y = 3,
	},
	pools = {
		SuperiorSpectral = true,
	},
	discovered = true,
	config = {
		max_highlighted = 2,
		extra = { cards = 2 },
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
	use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			v:flip()
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.2,
				func = function()
					v:set_seal("crv_ps", nil, true)
					v:set_ability(pseudorandom_element({ "m_crv_superiore" }))
					return true
				end,
			}))
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					v:flip()
					G.hand:unhighlight_all()
					return true
				end,
			}))
		end
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_s"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
})

SMODS.Consumable({
	key = "suppurification",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Spectral",

	pos = {
		x = 3,
		y = 3,
	},
	pools = {
		SuperiorSpectral = true,
	},
	discovered = true,
	config = {
		max_highlighted = 2,
		extra = { cards = 2 },
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
	can_use = function(self, card)
		if G and G.crv_curses and #G.crv_curses.cards > 0 then
			return true
		end
		return false
	end,
	use = function(self, card, area, copier)
		SMODS.destroy_cards(G.crv_curses)
	end,
	after_use = function(self, card)
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.5,
			func = function()
				RevosVault.purified_curse = false
				return true
			end,
		}))
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_superior_s"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
	in_pool = function(self)
		return (
			G.crv_curses
			and (
				RevosVault.rarity_in("crv_curse", G.crv_curses.cards)
				and (RevosVault.rarity_in("crv_curse", G.crv_curses.cards) > 0)
			)
		)
	end,
})
