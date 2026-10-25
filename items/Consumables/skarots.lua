SMODS.ConsumableType({
	key = "crv_Skarot",
	collection_rows = { 5, 6 },
	primary_colour = G.C.BLACK,
	secondary_colour = G.C.WHITE,
	text_colour = G.C.BLACK,
	shop_rate = 4,
})

SMODS.Consumable({
	key = "sketch_fool",
	set = "crv_Skarot",
    cost = 2,
	atlas = "revo_skarots",
	pos = { x = 0, y = 0 },
	loc_vars = function(self, info_queue, card)
		local fool_c = G.GAME.crv_second_last_tarot_planet and G.P_CENTERS[G.GAME.crv_second_last_tarot_planet] or nil
		local last_tarot_planet = fool_c and localize({ type = "name_text", key = fool_c.key, set = fool_c.set })
			or localize("k_none")
		local colour = (not fool_c or fool_c.name == "The Fool") and G.C.RED or G.C.GREEN

		if not (not fool_c or fool_c.key == "c_crv_sketch_fool") then
			info_queue[#info_queue + 1] = fool_c
		end

		local main_end = {
			{
				n = G.UIT.C,
				config = { align = "bm", padding = 0.02 },
				nodes = {
					{
						n = G.UIT.C,
						config = { align = "m", colour = colour, r = 0.05, padding = 0.05 },
						nodes = {
							{
								n = G.UIT.T,
								config = {
									text = " " .. last_tarot_planet .. " ",
									colour = G.C.UI.TEXT_LIGHT,
									scale = 0.3,
									shadow = true,
								},
							},
						},
					},
				},
			},
		}

		return { vars = { last_tarot_planet }, main_end = main_end }
	end,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				if G.consumeables.config.card_limit > #G.consumeables.cards then
					play_sound("timpani")
					SMODS.add_card({ key = G.GAME.crv_second_last_tarot_planet })
					card:juice_up(0.3, 0.5)
				end
				return true
			end,
		}))
		delay(0.6)
	end,
	can_use = function(self, card)
		return (#G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables)
			and G.GAME.crv_second_last_tarot_planet
	end,
})

SMODS.Consumable({
	key = "sketch_magician",
	set = "crv_Skarot",
    cost = 2,
	atlas = "revo_skarots",

	pos = {
		x = 1,
		y = 0,
	},
	discovered = true,
	config = {
		max_highlighted = 2,
		min_highlighted = 1,
		extra = {},
	},
	loc_vars = function(self, info_queue, card)
        local border_effect_table = RevosVault.MISC.Borders.border_crv_lucky.config
        local num1, den1 = SMODS.get_probability_vars(RevosVault.MISC.Borders.border_crv_lucky, 1, border_effect_table.odds)
        info_queue[#info_queue+1] = { set = "crv_Border", key = "border_crv_lucky", vars = {
            num1, 
            den1,
            border_effect_table.odds2,
            border_effect_table.dollars,
            border_effect_table.mult
        }}
		return { vars = { self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			RVF.cool_enhance(v, function()
				RVF.set_border(v, "border_crv_lucky")
				play_sound("tarot1")
				card:juice_up(0.3, 0.5)
			end, true)
		end
		RVF.do_event(function()
			G.hand:unhighlight_all()
			return true
		end)
	end,
})

SMODS.Consumable({
	key = "sketch_priestess",
	set = "crv_Skarot",
    cost = 2,
	atlas = "revo_skarots",
	pos = {
		x = 2,
		y = 0,
	},
	discovered = true,
	config = {},
	loc_vars = function(self, info_queue, card)
		return { vars = {} }
	end,
	use = function(self, card, area, copier)
		local stripped_hands = {}
		for k, v in pairs(G.GAME.hands) do
			if v.visible then
				stripped_hands[#stripped_hands + 1] = v.key
			end
		end
		local _hand = pseudorandom_element(stripped_hands, pseudoseed("crv_sketch_priestess"))
		SMODS.smart_level_up_hand(card, _hand)
	end,
	can_use = function(self, card)
		return true
	end,
})

SMODS.Consumable({
	key = "sketch_empress",
	set = "crv_Skarot",
    cost = 2,
	atlas = "revo_skarots",

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
	loc_vars = function(self, info_queue, card)
        local border_effect_table = RevosVault.MISC.Borders.border_crv_mult.config
        info_queue[#info_queue+1] = { set = "crv_Border", key = "border_crv_mult", vars = {
            border_effect_table.effect
        }}
		return { vars = { self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			RVF.cool_enhance(v, function()
				RVF.set_border(v, "border_crv_mult")
				play_sound("tarot1")
				card:juice_up(0.3, 0.5)
			end, true)
		end
		RVF.do_event(function()
			G.hand:unhighlight_all()
			return true
		end)
	end,
})

SMODS.Consumable({
	key = "sketch_emperor",
	set = "crv_Skarot",
    cost = 2,
	atlas = "revo_skarots",

	pos = {
		x = 4,
		y = 0,
	},
	discovered = true,
	config = {
		extra = {
			create = 2,
		},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.create } }
	end,
	use = function(self, card, area, copier)
		for i = 1, math.min(card.ability.extra.create, G.consumeables.config.card_limit - #G.consumeables.cards) do
			RVF.do_event(function()
				if RVF.has_room(G.consumeables) then
					play_sound("timpani")
					SMODS.add_card({ set = "crv_Skarot" })
					card:juice_up(0.3, 0.5)
				end
				return true
			end, nil, "after", 0.4)
		end
		delay(0.6)
	end,
	can_use = function(self, card)
		return RVF.has_room(G.consumeables) or card.area == G.consumeables
	end,
})

SMODS.Consumable({
	key = "sketch_hierophant",
	set = "crv_Skarot",
    cost = 2,
	atlas = "revo_skarots",

	pos = {
		x = 5,
		y = 0,
	},
	discovered = true,
	config = {
		max_highlighted = 2,
		min_highlighted = 1,
		extra = {},
	},
	loc_vars = function(self, info_queue, card)
        local border_effect_table = RevosVault.MISC.Borders.border_crv_bonus.config
        info_queue[#info_queue+1] = { set = "crv_Border", key = "border_crv_bonus", vars = {
            border_effect_table.effect
        }}
		return { vars = { self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			RVF.cool_enhance(v, function()
				RVF.set_border(v, "border_crv_bonus")
				play_sound("tarot1")
				card:juice_up(0.3, 0.5)
			end, true)
		end
		RVF.do_event(function()
			G.hand:unhighlight_all()
			return true
		end)
	end,
})

SMODS.Consumable({
	key = "sketch_lovers",
	set = "crv_Skarot",
    cost = 2,
	atlas = "revo_skarots",
	pos = {
		x = 6,
		y = 0,
	},
	discovered = true,
	config = {
		max_highlighted = 1,
		min_highlighted = 1,
		extra = {},
	},
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = { set = "crv_Border", key = "border_crv_smudged_alt"}
		return { vars = { self.config.max_highlighted } }
	end,
	use = function(self, card, area, copier)
		for _, v in pairs(G.hand.highlighted) do
			RVF.cool_enhance(v, function()
				RVF.set_border(v, "border_crv_smudged")
				play_sound("tarot1")
				card:juice_up(0.3, 0.5)
			end, true)
		end
		RVF.do_event(function()
			G.hand:unhighlight_all()
			return true
		end)
	end,
})