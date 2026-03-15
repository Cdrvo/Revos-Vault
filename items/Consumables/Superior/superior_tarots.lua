SMODS.Consumable({
	name = "Superior Fool",
	key = "supfool",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Tarot",

	pos = {
		x = 0,
		y = 0,
	},
	discovered = true,
	config = {
		extra = { cards = nil },
	},
	pools = {
		SuperiorTarot = true,
	},
	loc_vars = function(self, info_queue, card)
		local joka
		local c
		if G.GAME.dont_question then
			joka = localize({ type = "name_text", key = G.GAME.dont_question, set = "Joker" })
			c = G.C.GREEN
		else
			joka = localize("k_none")
			c = G.C.RED
		end
		if G.GAME.dont_question then
			info_queue[#info_queue + 1] = G.P_CENTERS[G.GAME.dont_question]
		end
		return {
			main_end = {
				{
					n = G.UIT.C,
					config = { align = "bm", padding = 0.02 },
					nodes = {
						{
							n = G.UIT.C,
							config = { align = "m", colour = c, r = 0.05, padding = 0.05 },
							nodes = {
								{
									n = G.UIT.T,
									config = {
										text = " " .. joka .. " ",
										colour = G.C.UI.TEXT_LIGHT,
										scale = 0.3,
										shadow = true,
									},
								},
							},
						},
					},
				},
			},
			vars = {},
		}
	end,
	can_use = function(self, card)
		if G and G.GAME and G.GAME.last_destroyed_joker and RevosVault.has_room(G.jokers) then
			return true
		end
		return false
	end,
	use = function(self, card, area, copier)
		SMODS.add_card({
			key = G.GAME.dont_question,
		})
	end,
})

SMODS.Consumable({
	key = "supmagician",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Tarot",

	pos = {
		x = 1,
		y = 0,
	},
	discovered = true,
	config = {
		max_highlighted = 3,
		min_highlighted = 1,
		extra = {},
	},
	pools = {
		SuperiorTarot = true,
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted, card.ability.extra.cards } }
	end,
	use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			v:flip()
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.2,
				func = function()
					v:set_ability("m_lucky")
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
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card, "m_lucky") then
				return {
					repetitions = 1,
				}
			end
		end
	end,
})

SMODS.Consumable({
	key = "suphigh_priestess",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Tarot",

	pos = {
		x = 2,
		y = 0,
	},
	discovered = true,
	config = {
		extra = { create = 3 },
	},
	pools = {
		SuperiorTarot = true,
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.create } }
	end,
	can_use = function(self, card)
		return true
	end,
	use = function(self, card, area, copier)
		local _planet, _hand = nil, RevosVault.most_played()
		for _, v in pairs(G.P_CENTER_POOLS.Planet) do
			if v.config.hand_type == _hand then
				_planet = v.key
			end
		end
		for i = 1, card.ability.extra.create do
			SMODS.add_card({
				key = _planet,
				edition = "e_negative",
			})
		end
	end,
})

SMODS.Consumable({
	key = "supempress",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Tarot",

	pos = {
		x = 3,
		y = 0,
	},
	discovered = true,
	config = {
		max_highlighted = 2,
		min_highlighted = 1,
		extra = {},
	},
	pools = {
		SuperiorTarot = true,
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted, card.ability.extra.cards } }
	end,
	use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			v:flip()
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.2,
				func = function()
					v:set_ability("m_crv_xmultcard")
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
})

SMODS.Consumable({
	key = "supemperor",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Tarot",

	pos = {
		x = 4,
		y = 0,
	},
	discovered = true,
	config = {
		extra = {},
	},
	pools = {
		SuperiorTarot = true,
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted, card.ability.extra.cards } }
	end,
	can_use = function(self, card)
		local a = 0
		if G.consumeables and G.consumeables.cards then
			a = G.consumeables.config.card_limit - #G.consumeables.cards
			for k, v in pairs(G.consumeables.cards) do
				if v == card then
					a = a + 1
				end
			end
		end
		if a > 0 then
			return true
		end
		return false
	end,
	use = function(self, card, area, copier)
		for i = 1, (math.max(0, math.min(2, RevosVault.has_room(G.consumeables, true)))) do
			SMODS.add_card({
				key = pseudorandom_element(G.P_CENTER_POOLS.Superior).key,
				area = G.consumeables,
			})
		end
	end,
})

SMODS.Consumable({
	key = "supheirophant",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Tarot",

	pos = {
		x = 5,
		y = 0,
	},
	discovered = true,
	config = {
		max_highlighted = 3,
		min_highlighted = 1,
		extra = {},
	},
	pools = {
		SuperiorTarot = true,
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted, card.ability.extra.cards } }
	end,
	use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			v:flip()
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.2,
				func = function()
					v:set_ability("m_bonus")
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
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card, "m_bonus") then
				return {
					repetitions = 1,
				}
			end
		end
	end,
})

SMODS.Consumable({
	key = "suplovers",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Tarot",

	pos = {
		x = 6,
		y = 0,
	},
	discovered = true,
	config = {
		max_highlighted = 3,
		min_highlighted = 1,
		extra = {},
	},
	pools = {
		SuperiorTarot = true,
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted, card.ability.extra.cards } }
	end,
	use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			v:flip()
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.2,
				func = function()
					v:set_ability("m_wild")
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
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card, "m_wild") then
				return {
					mult = context.other_card.base.id / 2,
				}
			end
		end
	end,
})

SMODS.Consumable({
	key = "supchariot",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Tarot",

	pos = {
		x = 7,
		y = 0,
	},
	discovered = true,
	config = {
		max_highlighted = 3,
		min_highlighted = 1,
		extra = {},
	},
	pools = {
		SuperiorTarot = true,
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted, card.ability.extra.cards } }
	end,
	use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			v:flip()
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.2,
				func = function()
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
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.hand then
			if SMODS.has_enhancement(context.other_card, "m_steel") then
				return {
					xchips = 2,
				}
			end
		end
	end,
})

SMODS.Consumable({
	key = "supjustice",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Tarot",

	pos = {
		x = 8,
		y = 0,
	},
	discovered = true,
	config = {
		max_highlighted = 3,
		min_highlighted = 1,
		extra = {},
	},
	pools = {
		SuperiorTarot = true,
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted, card.ability.extra.cards } }
	end,
	use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			v:flip()
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.2,
				func = function()
					v:set_ability("m_glass")
					v:set_edition("e_polychrome")
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
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card, "m_glass") then
				return {
					mult = context.other_card.base.id / 2,
				}
			end
		end
	end,
})

SMODS.Consumable({
	key = "suphermit",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Tarot",

	pos = {
		x = 9,
		y = 0,
	},
	discovered = true,
	config = {
		extra = {
			money = 100,
			give = 5,
		},
	},
	pools = {
		SuperiorTarot = true,
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.money, card.ability.extra.give } }
	end,
	can_use = function(self, card)
		return true
	end,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("timpani")
				card:juice_up(0.3, 0.5)
				ease_dollars(math.max(0, math.min(G.GAME.dollars + G.GAME.dollars, card.ability.extra.money)), true)
				return true
			end,
		}))
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval then
			return {
				dollars = card.ability.extra.give,
			}
		end
	end,
})

SMODS.Consumable({
	key = "supwheel_of_fortune",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Tarot",

	pos = {
		x = 0,
		y = 1,
	},
	discovered = true,
	config = {
		extra = {},
	},
	pools = {
		SuperiorTarot = true,
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {} }
	end,
	can_use = function(self, card)
		local jokas = {}
		for i = 1, #G.jokers.cards do
			if not G.jokers.cards[i].edition then
				jokas[#jokas + 1] = G.jokers.cards[i]
			end
		end
		if #G.jokers.cards > 0 and #jokas > 0 then
			return true
		end
	end,
	use = function(self, card, area, copier)
		RevosVault.wheeloffortune(1, G.jokers.cards)
	end,
})

SMODS.Consumable({
	key = "supstrength",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Tarot",

	pos = {
		x = 1,
		y = 1,
	},
	discovered = true,
	config = {
		max_highlighted = 2,
		min_highlighted = 1,
		extra = {},
	},
	pools = {
		SuperiorTarot = true,
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			v:flip()
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.2,
				func = function()
					SMODS.change_base(v, nil, "King")
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
})

SMODS.Consumable({
	key = "suphanged_man",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Tarot",

	pos = {
		x = 2,
		y = 1,
	},
	pools = {
		SuperiorTarot = true,
	},
	discovered = true,
	config = {
		max_highlighted = 5,
		min_highlighted = 1,
		extra = {
			chips = 0,
		},
	},
	loc_vars = function(self, info_queue, card)
		if G and G.GAME then
			return { vars = { self.config.max_highlighted, card.ability.extra.chips } }
		else
			return { vars = { self.config.max_highlighted, G.GAME.hangedmanchips } }
		end
	end,
	use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			G.GAME.hangedmanchips = G.GAME.hangedmanchips + v.base.id
			SMODS.destroy_cards(v)
		end
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				chips = G.GAME.hangedmanchips,
			}
		end
	end,
})

SMODS.Consumable({
	key = "supdeath",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Tarot",

	pos = {
		x = 3,
		y = 1,
	},
	discovered = true,
	config = {
		max_highlighted = 2,
		min_highlighted = 1,
		extra = {
			chips = 0,
		},
	},
	pools = {
		SuperiorTarot = true,
	},
	can_use = function(self, card)
		if
			#G.hand.highlighted <= 2
			and #G.hand.highlighted > 0
			and RevosVault.find_lowest(G.playing_cards, nil, true)
		then
			return true
		end
		return false
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			v:flip()
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.2,
				func = function()
					copy_card((RevosVault.find_lowest(G.playing_cards, nil, true)), v)
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
})

SMODS.Consumable({
	key = "suptemp",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Tarot",

	pos = {
		x = 4,
		y = 1,
	},
	discovered = true,
	config = {
		extra = {
			money = 0,
			max = 100,
		},
	},
	pools = {
		SuperiorTarot = true,
	},
	can_use = function(self, card)
		return true
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.max } }
	end,
	use = function(self, card, area, copier)
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i].ability.set == "Joker" then
				card.ability.extra.money = card.ability.extra.money + G.jokers.cards[i].sell_cost
			end
		end
		for i = 1, #G.consumeables.cards do
			card.ability.extra.money = card.ability.extra.money + G.consumeables.cards[i].sell_cost
		end
		ease_dollars(math.max(0, math.min(card.ability.extra.money, card.ability.extra.max)), true)
	end,
})

SMODS.Consumable({
	key = "supdevil",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Tarot",

	pos = {
		x = 5,
		y = 1,
	},
	discovered = true,
	config = {
		max_highlighted = 3,
		min_highlighted = 1,
		extra = {
			money = 5,
		},
	},
	pools = {
		SuperiorTarot = true,
	},
	can_use = function(self, card)
		return true
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted, card.ability.extra.money } }
	end,
	use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			v:flip()
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.2,
				func = function()
					v:set_ability("m_gold")
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
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card, "m_gold") then
				return {
					dollars = card.ability.extra.money,
				}
			end
		end
	end,
})

SMODS.Consumable({
	key = "suptower",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Tarot",

	pos = {
		x = 6,
		y = 1,
	},
	discovered = true,
	config = {
		max_highlighted = 2,
		min_highlighted = 1,
		extra = {
			money = 0,
		},
	},
	pools = {
		SuperiorTarot = true,
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			v:flip()
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.2,
				func = function()
					v:set_ability("m_stone")
					v:set_edition("e_negative")
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
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card, "m_stone") then
				return {
					xmult = 2,
				}
			end
		end
	end,
})

SMODS.Consumable({
	key = "supstar",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Tarot",

	pos = {
		x = 7,
		y = 1,
	},
	discovered = true,
	config = {
		max_highlighted = 2,
		min_highlighted = 1,
		extra = {
			money = 0,
		},
	},
	pools = {
		SuperiorTarot = true,
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			v:flip()
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.2,
				func = function()
					SMODS.change_base(v, "Diamonds", nil)
					v:set_ability("m_crv_superiore")
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
})

SMODS.Consumable({
	key = "supmoon",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Tarot",

	pos = {
		x = 8,
		y = 1,
	},
	discovered = true,
	config = {
		max_highlighted = 2,
		min_highlighted = 1,
		extra = {
			money = 0,
		},
	},
	pools = {
		SuperiorTarot = true,
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			v:flip()
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.2,
				func = function()
					SMODS.change_base(v, "Clubs", nil)
					v:set_ability("m_crv_superiore")
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
})

SMODS.Consumable({
	key = "supsun",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Tarot",

	pos = {
		x = 9,
		y = 1,
	},
	discovered = true,
	config = {
		max_highlighted = 2,
		min_highlighted = 1,
		extra = {
			money = 0,
		},
	},
	pools = {
		SuperiorTarot = true,
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			v:flip()
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.2,
				func = function()
					SMODS.change_base(v, "Hearts", nil)
					v:set_ability("m_crv_superiore")
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
})

SMODS.Consumable({
	key = "supworld",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Tarot",

	pos = {
		x = 1,
		y = 2,
	},
	discovered = true,
	config = {
		max_highlighted = 2,
		min_highlighted = 1,
		extra = {
			money = 0,
		},
	},
	pools = {
		SuperiorTarot = true,
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			v:flip()
			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.2,
				func = function()
					SMODS.change_base(v, "Spades", nil)
					v:set_ability("m_crv_superiore")
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
})

SMODS.Consumable({
	key = "supjudgement",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Tarot",

	pos = {
		x = 0,
		y = 2,
	},
	discovered = true,
	config = {
		extra = {
			default = 0,
			default2 = 0,
		},
	},
	pools = {
		SuperiorTarot = true,
	},
	can_use = function(self, card)
		return RevosVault.check("space", G.jokers)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({
			trigger = "immediate",
			delay = 0.2,
			func = function()
				local keys = {}
				for k, v in pairs(G.P_CENTER_POOLS.Joker) do
					if v and (v.rarity ~= 1 and v.rarity ~= 2) and not v.no_collection then
						if v.in_pool then
							if v:in_pool() == true then
								keys[#keys + 1] = v.key
							end
						else
							keys[#keys + 1] = v.key
						end
					end
				end

				local _key = pseudorandom_element(keys, pseudoseed("supjudgement"))

				local acard = SMODS.add_card({
					key = _key,
					area = G.jokers,
				})
				return true
			end,
		}))
	end,
})

SMODS.Consumable({
	key = "supinkintuition",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Tarot",

	pos = {
		x = 0,
		y = 3,
	},
	discovered = true,
	config = {
		extra = {
			default = 0,
			default2 = 0,
		},
	},
	pools = {
		SuperiorTarot = true,
	},
	can_use = function(self, card)
		return RevosVault.check("space", G.jokers)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		SMODS.add_card({ set = "Joker", area = G.jokers, rarity = "crv_p", edition = "e_negative" })
	end,
})

SMODS.Consumable({
	key = "supheart",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Tarot",

	pos = {
		x = 0,
		y = 4,
	},
	discovered = true,
	config = {
		extra = {
			cards = 1,
		},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
	pools = {
		SuperiorTarot = true,
	},
	can_use = function(self, card)
		if G and G.hand then
			if
				#G.hand.highlighted ~= 0
				and #G.hand.highlighted <= card.ability.extra.cards
				and #G.jokers.highlighted == 0
			then
				return true
			elseif
				#G.jokers.highlighted ~= 0
				and #G.jokers.highlighted <= card.ability.extra.cards
				and #G.hand.highlighted == 0
			then
				return true
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		if #G.jokers.highlighted > 0 then
			G.jokers.highlighted[1]:remove()
			G.jokers.highlighted[1] = nil
		else
			G.hand.highlighted[1]:remove()
			G.hand.highlighted[1] = nil
		end
	end,
})

SMODS.Consumable({
	key = "supdreamsdesires",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Tarot",

	pos = {
		x = 1,
		y = 4,
	},
	discovered = true,
	config = {
		extra = {},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
	pools = {
		SuperiorTarot = true,
	},
	can_use = function(self, card)
		return RevosVault.check("space", G.jokers)
	end,
	use = function(self, card, area, copier)
		SMODS.add_card({ key = "j_crv_full", edition = "e_negative" })
	end,
})

SMODS.Consumable({
	key = "supmastery",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Tarot",
	pos = {
		x = 2,
		y = 3,
	},
	pools = {
		SuperiorTarot = true,
	},
	config = {
		extra = {
			cards = 4,
		},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards } }
	end,
	can_use = function(self, card)
		if G and G.hand then
			if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then
				for i = 1, #G.hand.highlighted do
					if RevosVault.upgrade_enhancement(G.hand.highlighted[i], true) then
						return true
					end
				end
			end
		end
		return false
	end,
	use = function(self, card, area, copier)
		for i, card in pairs(G.hand.highlighted) do
			if RevosVault.upgrade_enhancement(card, true) then
				G.E_MANAGER:add_event(Event({
					trigger = "before",
					delay = 0.2,
					func = function()
						card:flip()
						card:juice_up()
						return true
					end,
				}))
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.5,
					func = function()
						card:set_ability(RevosVault.upgrade_enhancement(card))
						card:set_seal("crv_superior_seal")
						G.hand:unhighlight_all()
						card:flip()
						return true
					end,
				}))
			end
		end
		G.hand:unhighlight_all()
	end,
})

SMODS.Consumable({
	key = "supbottleflip",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Tarot",

	pos = {
		x = 2,
		y = 4,
	},
	discovered = true,
	config = {
		extra = {
			odds = 4,
		},
	},
	loc_vars = function(self, info_queue, card)
		local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "supbottleflip_seed")
		return { vars = { num, den } }
	end,
	pools = {
		SuperiorTarot = true,
	},
	can_use = function(self, card)
		return RevosVault.check("hasjoker")
	end,
	use = function(self, card, area, copier)
		if SMODS.pseudorandom_probability(card, "supbottleflip_seed", 1, card.ability.extra.odds) then
			for k, v in pairs(G.jokers.cards) do
				v:set_edition("e_negative")
			end
		else
			RevosVault.nope({ card = card })
		end
	end,
})

if RevoConfig["8_curses_enabled"] then
	SMODS.Consumable({
		key = "supprayer",
		set = "Superior",
		atlas = "Superior",
		crv_in_set = "Tarot",

		pos = {
			x = 1,
			y = 3,
		},
		discovered = true,
		config = {
			extra = {cards = 1},
		},
		loc_vars = function(self, info_queue, card) 
            return {vars = {card.ability.extra.cards} }
        end,
		pools = {
			SuperiorTarot = true,
		},
		can_use = function(self, card)
			if G and G.crv_curses then
				if #G.crv_curses.highlighted ~= 0 and #G.crv_curses.highlighted <= card.ability.extra.cards then
					for k, v in pairs(G.crv_curses.highlighted) do
						if v.config.center.rarity == "crv_curse" then
							return true
						end
					end
				end
			end
			return false
		end,
		use = function(self, card)
			local cae = card.ability.extra
			RevosVault.purified_curse = true
			for i, card in pairs(G.crv_curses.highlighted) do
				if card.config.center.rarity == "crv_curse" then
					SMODS.destroy_cards(card, true)
					check_for_unlock({ type = "purifying_it" })
				end
			end
		end,
		after_use = function()
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.5,
				func = function()
					if RevosVault.purified_curse then
						RevosVault.purified_curse = false
					end
					return true
				end,
			}))
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
end

SMODS.Consumable({
	key = "supcamera",
	set = "Superior",
	atlas = "Superior",
	crv_in_set = "Tarot",

	pos = {
		x = 3,
		y = 4,
	},
	discovered = true,
	config = {
		extra = {
		},
	},
	loc_vars = function(self, info_queue, card)
	end,
	pools = {
		SuperiorTarot = true,
	},
	can_use = function(self, card)
		return RevosVault.check("highlight",G.jokers)>0
	end,
	use = function(self, card, area, copier)
		RevosVault.copy_card({card = G.jokers.highlighted[1], edition = "e_negative"})
	end,
})