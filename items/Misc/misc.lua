SMODS.Font({
	key = "dcard_text",
	path = "Feli5x8Mono-Regular.ttf",
})
SMODS.Font({
	key = "dcard_num",
	path = "Feli6x12Numbers-Regular.ttf",
})

SMODS.Sound({
	volume = 5,
	key = "flicker_music",
	path = "crv_flicker.ogg",
	select_music_track = function(self)
		return G.STATE == G.STATES.CRV_DEATHCARD
	end,
})

SMODS.Sound({
	volume = 3,
	key = "flicker_music",
	path = "crv_flicker.ogg",
	select_music_track = function(self)
		return G.STATE == G.STATES.CRV_DEATHCARD
	end,
})

SMODS.Sound({
	volume = 1,
	key = "lights_on",
	path = "crv_lights2.ogg",
})

SMODS.Sound({
	volume = 1,
	key = "lights_off",
	path = "crv_lights1.ogg",
})

SMODS.ScreenShader({
	key = "pitchblack",
	path = "pitchblack.fs",
	should_apply = function()
		return G.GAME.screen_off_crv == true
	end,
})

RevosVault.C = {
	SUP = HEX("f7baff"),
	Continuity = HEX("96a0ff"),
	Mystery = HEX("8a8a8a"),
	REVO = HEX("7E7AFF"),
	--[[BOONS = {
		DEFAULT = HEX("e8b867"),
		HAVE_BOONS = HEX("88beb0"),
		CURRENT = HEX("e8b867"),
		EPIC = HEX("b472ca"),
		HEROIC = HEX("fd5f55")
	},
	BOONRARITY = {}]]
}

SMODS.Gradient({
	key = "crv_mythical",
	colours = {
		HEX("c80000"),
		HEX("bb008e"),
	},
	cycle = 3,
})

SMODS.Gradient({
	key = "crv_banana",
	colours = {
		HEX("b5dc54"),
		HEX("ffed81"),
	},
	cycle = 5,
})

SMODS.Gradient({
	key = "crv_polychrome",
	colours = {
		HEX("e81416"),
		HEX("ffa500"),
		HEX("faeb36"),
		HEX("79c314"),
		HEX("487de7"),
		HEX("4b369d"),
		HEX("70369d"),
	},
	cycle = 5,
})

SMODS.Gradient({
	key = "crv_gem",
	colours = {
		HEX("60ff68"),
		HEX("60fff3"),
		HEX("60a2ff"),
		HEX("aa60ff"),
		HEX("ff60e0"),
		HEX("e4fa63"),
		HEX("b0ff8c"),
	},
	cycle = 5,
})

SMODS.Gradient({
	key = "crv_sunwashed",
	colours = {
		HEX("fff760"),
		HEX("ffd09f"),
	},
})

SMODS.Gradient({
	key = "crv_wip",
	colours = {
		HEX("000000"),
		HEX("343434"),
	},
})

SMODS.Gradient({
	key = "crv_temp",
	colours = {
		HEX("000000"),
		HEX("ff0000"),
		cycle = 3,
	},
})

SMODS.Gradient({
	key = "crv_crv", -- double prefix
	colours = {
		HEX("000000"),
		HEX("ff0000"),
		cycle = 3,
	},
})

SMODS.Gradient({
	key = "crv_deathcard",
	colours = {
		HEX("f0c590"),
		HEX("ddb482"),
	},
	cycle = 5,
})

SMODS.Gradient({
	key = "crv_important",
	colours = {
		G.C.RED,
		G.C.IMPORTANT,
	},
	cycle = 0.5,
})

SMODS.Gradient({
	key = "revosvault",
	colours = {
		HEX("7E7AFF"),
		HEX("40093A")
	},
	cycle = 5
})

local loc_old = loc_colour
function loc_colour(_c, _default)
	if not G.ARGS.LOC_COLOURS then
		loc_old()
	end
	local loc = G.ARGS.LOC_COLOURS
	G.ARGS.LOC_COLOURS.crv_sup = RevosVault.C.SUP
	G.ARGS.LOC_COLOURS.crv_continuity = RevosVault.C.Continuity
	G.ARGS.LOC_COLOURS.crv_polychrome = SMODS.Gradients["crv_polychrome"]
	G.ARGS.LOC_COLOURS.crv_gem = SMODS.Gradients["crv_gem"]
	G.ARGS.LOC_COLOURS.crv_wip = SMODS.Gradients["crv_wip"]
	G.ARGS.LOC_COLOURS.crv_temp = SMODS.Gradients["crv_temp"]
	G.ARGS.LOC_COLOURS.crv_banana = SMODS.Gradients["crv_banana"]
	G.ARGS.LOC_COLOURS.crv_mystery = RevosVault.C.Mystery
	loc.crv_deathcard = SMODS.Gradients["crv_deathcard"]
	loc.crv_mythical = SMODS.Gradients["crv_mythical"]
	loc.crv_clear = G.C.CLEAR
	loc.crv_revo = RevosVault.C.REVO

	return loc_old(_c, _default)
end

-- SCORING

SMODS.Scoring_Parameter({
	key = "dollars_mult",
	default_value = 0,
	colour = G.C.MONEY,
	crv_set = function(self, amount)
		self.current = amount
	end,
	modify = function(self, amount)
    	self.current = self.current
    	self.default_value = self.current 
		 G.GAME.current_round.current_hand.crv_dollars_mult = self.current
    	-- update_hand_text({delay = 0}, {[self.key] = self.current}) 
	end
})

SMODS.Scoring_Calculation({
	key = "dollars_mult_scoring",
	func = function(self, chips, mult, flames)
		return (chips + mult) * SMODS.Scoring_Parameters.crv_dollars_mult.current
	end,
	parameters = { "chips", "mult","crv_dollars_mult"},
	replace_ui = function(self)
		local scale = 0.3
			return {
				n = G.UIT.R,
				config = { align = "cm", minh = 1, padding = 0.1 },
				nodes = {
					RevosVault.GUI.operator(scale * 0.75, { text = "(", colour = G.C.UI_CHIPS }),
					{
						n = G.UIT.C,
						config = { align = "cm", id = "hand_chips" },
						nodes = {
							SMODS.GUI.score_container({
								type = "chips",
								text = "chip_text",
								align = "cm",
								w = 1.1,
								scale = scale,
							}),
						},
					},
					RevosVault.GUI.operator(scale * 0.75, { text = "+" }),
					{
						n = G.UIT.C,
						config = { align = "cm", id = "hand_mult" },
						nodes = {
							SMODS.GUI.score_container({
								type = "mult",
								align = "cm",
								w = 1.1,
								scale = scale,
							}),
						},
					},
					RevosVault.GUI.operator(scale * 0.75, { text = ")" }),
					RevosVault.GUI.operator(scale * 0.75, { text = "X", colour = G.C.MONEY }),
					{
						n = G.UIT.C,
						config = { align = "cm", id = "hand_crv_dollars_mult" },
						nodes = {
							SMODS.GUI.score_container({
								type = "crv_dollars_mult",
								text = "crv_dollars_mult_text",
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
