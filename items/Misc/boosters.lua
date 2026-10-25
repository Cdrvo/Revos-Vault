for i = 1, 4 do
	SMODS.Booster({
		key = "skarot_pack_" .. i,
		weight = 1,
		kind = "crv_skarot",
		atlas = "revo_boosters",
		cost = 3,
		pos = { x = i - 1, y = 0 },
		config = { extra = 3, choose = 1 },
		group_key = "k_crv_skarot_pack",
		draw_hand = true,
		loc_vars = function(self, info_queue, card)
			local cfg = (card and card.ability) or self.config
			return {
				vars = {
					math.min(
						cfg.choose + (G.GAME.modifiers.booster_choice_mod or 0),
						math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0))
					),
					math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0)),
				},
				key = self.key:sub(1, -3),
			}
		end,
		ease_background_colour = function(self)
			ease_background_colour({ new_colour = G.C.WHITE, special_colour = darken(G.C.BLACK, 0.2), contrast = 1.5 })
			ease_colour(G.C.DYN_UI.MAIN, mix_colours(G.C.WHITE, G.C.BLACK, 0.9))
		end,
		particles = function(self)
			G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
				timer = 0.015,
				scale = 0.2,
				initialize = true,
				lifespan = 1,
				speed = 1.1,
				padding = -1,
				attach = G.ROOM_ATTACH,
				colours = { G.C.WHITE, lighten(G.C.WHITE, 0.4), lighten(G.C.WHITE, 0.2), lighten(G.C.BLACK, 0.2) },
				fill = true,
			})
			G.booster_pack_sparkles.fade_alpha = 1
			G.booster_pack_sparkles:fade(1, 0)
		end,
		create_card = function(self, card, i)
			return {
				set = "crv_Skarot",
				area = G.pack_cards,
				skip_materialize = true,
				soulable = true,
			}
		end,
	})
end

for i = 1, 2 do
	SMODS.Booster({
		key = "skarot_jumbo_" .. i,
		weight = 1,
		kind = "crv_skarot",
		atlas = "revo_boosters",
		cost = 5,
		pos = { x = i - 1, y = 1 },
		config = { extra = 5, choose = 1 },
		group_key = "k_crv_skarot_pack",
		draw_hand = true,
		loc_vars = function(self, info_queue, card)
			local cfg = (card and card.ability) or self.config
			return {
				vars = {
					math.min(
						cfg.choose + (G.GAME.modifiers.booster_choice_mod or 0),
						math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0))
					),
					math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0)),
				},
				key = self.key:sub(1, -3),
			}
		end,
		ease_background_colour = function(self)
			ease_background_colour({ new_colour = G.C.WHITE, special_colour = darken(G.C.BLACK, 0.2), contrast = 1.5 })
			ease_colour(G.C.DYN_UI.MAIN, mix_colours(G.C.WHITE, G.C.BLACK, 0.9))
		end,
		particles = function(self)
			G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
				timer = 0.015,
				scale = 0.2,
				initialize = true,
				lifespan = 1,
				speed = 1.1,
				padding = -1,
				attach = G.ROOM_ATTACH,
				colours = { G.C.WHITE, lighten(G.C.WHITE, 0.4), lighten(G.C.WHITE, 0.2), lighten(G.C.BLACK, 0.2) },
				fill = true,
			})
			G.booster_pack_sparkles.fade_alpha = 1
			G.booster_pack_sparkles:fade(1, 0)
		end,
		create_card = function(self, card, i)
			return {
				set = "crv_Skarot",
				area = G.pack_cards,
				skip_materialize = true,
				soulable = true,
			}
		end,
	})
end

for i = 1, 2 do
	SMODS.Booster({
		key = "skarot_mega_" .. i,
		weight = 1,
		kind = "crv_skarot",
		atlas = "revo_boosters",
		cost = 7,
		pos = { x = 2 + (i - 1), y = 1 },
		config = { extra = 5, choose = 2 },
		group_key = "k_crv_skarot_pack",
		draw_hand = true,
		loc_vars = function(self, info_queue, card)
			local cfg = (card and card.ability) or self.config
			return {
				vars = {
					math.min(
						cfg.choose + (G.GAME.modifiers.booster_choice_mod or 0),
						math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0))
					),
					math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0)),
				},
				key = self.key:sub(1, -3),
			}
		end,
		ease_background_colour = function(self)
			ease_background_colour({ new_colour = G.C.WHITE, special_colour = darken(G.C.BLACK, 0.2), contrast = 1.5 })
			ease_colour(G.C.DYN_UI.MAIN, mix_colours(G.C.WHITE, G.C.BLACK, 0.9))
		end,
		particles = function(self)
			G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
				timer = 0.015,
				scale = 0.2,
				initialize = true,
				lifespan = 1,
				speed = 1.1,
				padding = -1,
				attach = G.ROOM_ATTACH,
				colours = { G.C.WHITE, lighten(G.C.WHITE, 0.4), lighten(G.C.WHITE, 0.2), lighten(G.C.BLACK, 0.2) },
				fill = true,
			})
			G.booster_pack_sparkles.fade_alpha = 1
			G.booster_pack_sparkles:fade(1, 0)
		end,
		create_card = function(self, card, i)
			return {
				set = "crv_Skarot",
				area = G.pack_cards,
				skip_materialize = true,
				soulable = true,
			}
		end,
	})
end
