SMODS.Atlas({
	key = "modicon",
	path = "modicon.png",
	px = 34,
	py = 34,
})

SMODS.Atlas({
	key = "revo_jokers",
	path = "jokers.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "wip",
	path = "wip.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "eol",
	path = "eol.png",
	px = 122,
	py = 95,
})

SMODS.Atlas({
	key = "revo_enhancements",
	path = "enhancements.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "revo_seals",
	path = "seals.png",
	px = 71,
	py = 95,
})

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
	py = 34,
})

SMODS.Atlas({
	key = "revo_contracts",
	path = "contracts.png",
	px = 73,
	py = 97,
})

SMODS.Atlas({
	key = "revo_cartridges",
	path = "cartridges.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "revo_mega_printer",
	path = "mega_printer.png",
	px = 128,
	py = 95,
})

SMODS.Atlas({
	key = "revo_runes",
	path = "runes.png",
	px = 65,
	py = 95,
})

SMODS.Atlas({
	key = "revo_tarots",
	path = "tarots.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "revo_spectrals",
	path = "spectrals.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "revo_vouchers",
	path = "vouchers.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "revo_status_effects",
	path = "status_effects.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "revo_borders",
	path = "borders.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "revo_skarots",
	path = "skarots.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "revo_gambler",
	path = "the_gambler.png",
	px = 71,
	py = 95,
	atlas_table = "ANIMATION_ATLAS",
	frames = 12,
})

SMODS.Atlas({
	key = "revo_boosters",
	path = "boosters.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "revo_evils",
	path = "evils.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "revo_planets",
	path = "planets.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "revo_decks",
	path = "decks.png",
	px = 71,
	py = 95
})

SMODS.Atlas({
	key = "revo_scraps",
	path = "scraps.png",
	px = 71,
	py = 95
})

SMODS.Atlas({
    key = "revo_gems",
    path = "gems.png",
    px = 50,
    py = 50
})
-- sounds

SMODS.Sound({
	volume = 0.3,
	key = "swoon",
	path = "crv_swoon.ogg",
})

-- attributes

SMODS.Attribute({
	key = "banana",
	keys = {
		"j_gros_michel",
		"j_cavendish",
	},
})

SMODS.Attribute({
	key = "printer",
})

SMODS.Attribute({
	key = "rune",
})

SMODS.Attribute({
	key = "scrap",
})
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

-- Scoring

SMODS.Scoring_Parameter({
	key = "dollar_parameter",
	default_value = 0,
	colour = G.C.MONEY,
	crv_set = function(self, amount)
		self.current = amount
	end,
	modify = function(self)
		self.current = self.current
		self.default_value = self.current
		G.GAME.current_round.current_hand.crv_dollar_parameter = self.current
		-- update_hand_text({delay = 0}, {[self.key] = self.current})
	end,
})

SMODS.Scoring_Calculation({
	key = "dollar_scoring",
	func = function(self, chips, mult, flames)
		return (chips + mult) * SMODS.Scoring_Parameters.crv_dollar_parameter.current
	end,
	parameters = { "chips", "mult", "crv_dollar_parameter" },
	replace_ui = function(self)
		local scale = 0.3
		return {
			n = G.UIT.R,
			config = { align = "cm", minh = 1, padding = 0.1 },
			nodes = {
				RevosVault.FUNCS.scoring_operator(scale * 0.75, { text = "(", colour = G.C.UI_CHIPS }),
				{
					n = G.UIT.C,
					config = { align = "cm", id = "hand_chips_container" },
					nodes = {
						SMODS.GUI.score_container({
							type = "chips",
							text = "chip_text",
							align = "cm",
							scale = scale,
							w = 1.1,
						}),
					},
				},
				RevosVault.FUNCS.scoring_operator(scale * 0.75, { text = "+", colour = G.C.MULT }),
				{
					n = G.UIT.C,
					config = { align = "cm", id = "hand_mult_container" },
					nodes = {
						SMODS.GUI.score_container({
							type = "mult",
							scale = scale,
							align = "cm",
							w = 1.1,
						}),
					},
				},
				RevosVault.FUNCS.scoring_operator(scale * 0.75, { text = ")", colour = G.C.UI_MULT }),
				RevosVault.FUNCS.scoring_operator(scale * 0.75, { text = "X", colour = G.C.GOLD }),
				{
					n = G.UIT.C,
					config = { align = "cm", id = "hand_crv_dollar_parameter" },
					nodes = {
						SMODS.GUI.score_container({
							type = "crv_dollar_parameter",
							text = "crv_dollar_parameter_text",
							align = "cm",
							w = 1.1,
							scale = scale,
						}),
					},
				},
			},
		}
	end,
})


-- Run Select Pages

SMODS.RunSelectPage({
    key = 'printer_choice',
    type = 'Joker',
	page = 2,
    area_type = 'shop',
    automatic_preview = true,
    random_select = true,
    double_click_advance = true,
    generate_pool = function(self)
		local p = {}
		for k, v in pairs(SMDOS.get_attribute_pool("printer")) do
			p[#p+1] = G.P_CENTERS[v]
		end
        return p
    end,
    stack_size = 1,
    preview_size = 1,
	selected_text = function(self, choice)
        return localize({type = 'name_text', set = 'Joker', key = choice})
    end,
    quick_start_text = function(self, choice)
        return localize({type = 'name_text', set = 'Joker', key = choice})
    end,
    set_default = function(self, choice)
        return G.P_CENTERS[choice] and choice or "j_crv_blueprinter"
    end,
    create_selection_card = function(self, card_key, card_number, area)
        local card = Card(area.T.x, area.T.y, G.CARD_W, G.CARD_H, nil, G.P_CENTERS[card_key] or G.P_CENTERS.j_crv_blueprinter)
		card:add_sticker("eternal", true)
        return card
    end,
	optional = function(self)
		if SMODS.RunSelect and SMODS.RunSelect.Setup.choices.deck_choice and SMODS.RunSelect.Setup.choices.deck_choice  == "b_crv_printer_deck" then
			return true
		end
		return false
	end,
	start_run = function(self, choice)
		local a = SMODS.add_card{key = choice, no_edition = true}
		a:add_sticker("eternal", true)
	end
})
