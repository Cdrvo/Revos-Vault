-------------MOD CODE-------------
RevosVault = SMODS.current_mod
RevoConfig = SMODS.current_mod.config
RevosPath = SMODS.current_mod.path
crvps = pseudorandom_element
RevosOther = {}

SMDOS = SMODS

-- yes

SMODS.current_mod.optional_features = function()
	return {
		post_trigger = true,
		retrigger_joker = true,
		cardareas = {
			unscored = true,
		},
	}
end

--Kindly took this from Prism :D

local old_config = copy_table(RevosVault.config)
local function should_restart()
	for k, v in pairs(old_config) do
		if v ~= RevosVault.config[k] then
			SMODS.full_restart = 1
			return
		end
	end
	SMODS.full_restart = 0
end

G.UIDEF.crv_joker_config = function()
	local t = create_UIBox_generic_options({
		back_func = "openModUI_RevosVault",
		colour = RevosVault.ui_config.colour,
		back_colour = RevosVault.ui_config.back_colour,
		contents = {
			{
				n = G.UIT.R,
				config = { align = "cm", r = 0.1, colour = G.C.BLACK, padding = 0.1 },
				nodes = {
					{
						n = G.UIT.O,
						config = {
							object = DynaText({
								string = { "Jokers" },
								colours = { G.C.DARK_EDITION },
								shadow = true,
								float = true,
								spacing = 0,
								rotate = true,
								scale = 1.3,
								pop_in = 0.1,
								maxw = 6.5,
							}),
						},
					},
				},
			},
			{
				n = G.UIT.R,
				config = { align = "cm", r = 0.1, colour = G.C.BLACK },
				nodes = {

					{
						n = G.UIT.C,
						nodes = {
							{
								n = G.UIT.R,
								config = { align = "cm", r = 0.1, colour = G.C.CLEAR, padding = 0.1 },
								nodes = {},
							},
							create_toggle({
								label = localize("crv_enable_chaoscards"),
								ref_table = RevosVault.config,
								ref_value = "7_chaos_enabled",
								--callback = should_restart,
							}),
							create_toggle({
								label = localize("crv_enable_vaulteds"),
								ref_table = RevosVault.config,
								ref_value = "6_vault_enabled",
								--callback = should_restart,
							}),
							create_toggle({
								label = localize("crv_enable_secret"),
								ref_table = RevosVault.config,
								ref_value = "9_secretjokers_enabled",
								--callback = should_restart,
							}),
							{
								n = G.UIT.R,
								config = { align = "cm", minh = 0.6 },
								nodes = {
									{
										n = G.UIT.T,
										config = { text = "Requires restart!", colour = G.C.RED, scale = 0.4 },
									},
								},
							},
							--[[{
								n = G.UIT.R,
								config = { align = "cm", minh = 0.6 },
								nodes = {
									{
										n = G.UIT.T,
										config = { text = "*Incomplete!", colour = G.C.WHITE, scale = 0.4 },
									},
								},
							},]]
						},
					},
				},
			},
		},
	})
	return t
end

G.UIDEF.crv_mechanic_config = function()
	local t = create_UIBox_generic_options({
		back_func = "openModUI_RevosVault",
		colour = RevosVault.ui_config.colour,
		back_colour = RevosVault.ui_config.back_colour,
		contents = {
			{
				n = G.UIT.R,
				config = { align = "cm", r = 0.1, colour = G.C.BLACK, padding = 0.1 },
				nodes = {
					{
						n = G.UIT.O,
						config = {
							object = DynaText({
								string = { "Mechanics" },
								colours = { G.C.DARK_EDITION },
								shadow = true,
								float = true,
								spacing = 0,
								rotate = true,
								scale = 1.3,
								pop_in = 0.1,
								maxw = 6.5,
							}),
						},
					},
				},
			},
			{
				n = G.UIT.R,
				config = { align = "cm", r = 0.1, colour = G.C.BLACK },
				nodes = {
					{
						n = G.UIT.C,
						nodes = {
							create_toggle({
								label = localize("crv_enable_curses"),
								ref_table = RevosVault.config,
								ref_value = "8_curses_enabled",
								--callback = should_restart,
							}),
							create_toggle({
								--[[localize("crv_enable_deathcards")]]
								label = "Enable Deathcards",
								ref_table = RevosVault.config,
								ref_value = "deathcards_enabled",
								--callback = should_restart,
							}),
							{
								n = G.UIT.R,
								config = { align = "cm", minh = 0.6 },
								nodes = {
									{
										n = G.UIT.T,
										config = { text = "Requires restart!", colour = G.C.RED, scale = 0.4 },
									},
								},
							},
						},
					},
				},
			},
		},
	})
	return t
end

G.UIDEF.crv_other_config = function()
	local t = create_UIBox_generic_options({
		back_func = "openModUI_RevosVault",
		colour = RevosVault.ui_config.colour,
		back_colour = RevosVault.ui_config.back_colour,
		contents = {
			{
				n = G.UIT.R,
				config = { align = "cm", r = 0.1, colour = G.C.BLACK, padding = 0.1 },
				nodes = {
					{
						n = G.UIT.O,
						config = {
							object = DynaText({
								string = { "Other" },
								colours = { G.C.DARK_EDITION },
								shadow = true,
								float = true,
								spacing = 0,
								rotate = true,
								scale = 1.3,
								pop_in = 0.1,
								maxw = 6.5,
							}),
						},
					},
				},
			},
			{
				n = G.UIT.R,
				config = { align = "cr", r = 0.1, colour = G.C.BLACK },
				nodes = {
					{
						n = G.UIT.C,
						config = { align = "cm", r = 0.1, colour = G.C.CLEAR },
						nodes = {
							create_toggle({
								label = localize("crv_enable_gems"),
								ref_table = RevosVault.config,
								ref_value = "gems_enabled",
								--callback = should_restart,
							}),
							create_toggle({
								label = localize("crv_enable_blinds"),
								ref_table = RevosVault.config,
								ref_value = "blinds_enabled",
								--callback = should_restart,
							}),

							create_toggle({
								label = localize("crv_enable_superior"),
								ref_table = RevosVault.config,
								ref_value = "superior_enabled",
								--callback = should_restart,
							}),
							create_toggle({
								label = localize("crv_normalize_megas"),
								ref_table = RevosVault.config,
								ref_value = "normal_mega_cards",
								--callback = should_restart,
							}),
							{
								n = G.UIT.R,
								config = { align = "cm", minh = 0.6 },
								nodes = {
									{
										n = G.UIT.T,
										config = { text = "Requires restart!", colour = G.C.RED, scale = 0.4 },
									},
								},
							},
							--[[{
								n = G.UIT.R,
								config = { align = "cm", minh = 0.6 },
								nodes = {
									{
										n = G.UIT.T,
										config = { text = "*Not recommended!", colour = G.C.WHITE, scale = 0.4 },
									},
								},
							},]]
						},
					},
				},
			},
		},
	})
	return t
end

G.FUNCS.crv_open_jconfig = function()
	RevosVault.easy_overlay(false, G.UIDEF.crv_joker_config())
end
G.FUNCS.crv_open_mconfig = function()
	RevosVault.easy_overlay(false, G.UIDEF.crv_mechanic_config())
end
G.FUNCS.crv_open_oconfig = function()
	RevosVault.easy_overlay(false, G.UIDEF.crv_other_config())
end

RevosVault.config_tab = function()
	return {
		n = G.UIT.ROOT,
		config = { align = "cm", padding = 0.3, emboss = 0.05, r = 0.1, colour = G.C.BLACK, minh = 4.5, minw = 7 },
		nodes = {
			{
				n = G.UIT.C,
				nodes = {
					{
						n = G.UIT.R,
						config = { align = "cm", r = 0.1, colour = G.C.BLACK, padding = 0.1 },
						nodes = {
							{
								n = G.UIT.O,
								config = {
									object = DynaText({
										string = { "Configuration" },
										colours = { G.C.DARK_EDITION },
										shadow = true,
										float = true,
										spacing = 0,
										rotate = true,
										scale = 1.3,
										pop_in = 0.1,
										maxw = 6.5,
									}),
								},
							},
						},
					},

					{n = G.UIT.R,
					config = { align = "cm", padding = 0.07, emboss = 0.05, r = 0.1, colour = G.C.CLEAR,minh = 0.3 },
				},

					UIBox_button({
						colour = RevosVault.ui_config.tab_button_colour,
						button = "crv_open_jconfig",
						label = { "Jokers" },
						minw = 4.5,
						focus_args = { snap_to = true },
					}),
					{ n = G.UIT.R, config = { colour = G.C.CLEAR, scale = 0.1, padding = 0.1 } },
					UIBox_button({
						colour = RevosVault.ui_config.tab_button_colour,
						button = "crv_open_mconfig",
						label = { "Mechanics" },
						minw = 4.5,
						focus_args = { snap_to = true },
					}),
					{ n = G.UIT.R, config = { colour = G.C.CLEAR, scale = 0.1, padding = 0.1 } },
					UIBox_button({
						colour = RevosVault.ui_config.tab_button_colour,
						button = "crv_open_oconfig",
						label = { "Other" },
						minw = 4.5,
						focus_args = { snap_to = true },
					}),
				},
			},
		},
	}
end

-- Credits system from Hot Potato
local smcmb = SMODS.create_mod_badges
function SMODS.create_mod_badges(obj, badges)
	smcmb(obj, badges)
	if not SMODS.config.no_mod_badges and obj and obj.crv_credits then
		local function calc_scale_fac(text)
			local size = 0.9
			local font = G.LANG.font
			local max_text_width = 2 - 2 * 0.05 - 4 * 0.03 * size - 2 * 0.03
			local calced_text_width = 0
			-- Math reproduced from DynaText:update_text
			for _, c in utf8.chars(text) do
				local tx = font.FONT:getWidth(c) * (0.33 * size) * G.TILESCALE * font.FONTSCALE
					+ 2.7 * 1 * G.TILESCALE * font.FONTSCALE
				calced_text_width = calced_text_width + tx / (G.TILESIZE * G.TILESCALE)
			end
			local scale_fac = calced_text_width > max_text_width and max_text_width / calced_text_width or 1
			return scale_fac
		end
		if obj.crv_credits.art or obj.crv_credits.code or obj.crv_credits.idea or obj.crv_credits.shader then
			local scale_fac = {}
			local min_scale_fac = 1
			local strings = { RevosVault.display_name }
			for _, v in ipairs({ "idea", "art", "code", "shader" }) do
				if obj.crv_credits[v] then
					if type(obj.crv_credits[v]) == "string" then
						obj.crv_credits[v] = { obj.crv_credits[v] }
					end
					for i = 1, #obj.crv_credits[v] do
						strings[#strings + 1] =
							localize({ type = "variable", key = "crv_" .. v, vars = { obj.crv_credits[v][i] } })[1]
					end
				end
			end
			if obj.crv_credits.custom then
				strings[#strings + 1] = localize({
					type = "variable",
					key = obj.crv_credits.custom.key,
					vars = { obj.crv_credits.custom.text },
				})
			end
			for i = 1, #strings do
				scale_fac[i] = calc_scale_fac(strings[i])
				min_scale_fac = math.min(min_scale_fac, scale_fac[i])
			end
			local ct = {}
			for i = 1, #strings do
				ct[i] = {
					string = strings[i],
				}
			end
			for i = 1, #badges do
				if badges[i].nodes[1].nodes[2].config.object.string == RevosVault.display_name then --this was meant to be a hex code but it just doesnt work for like no reason so its hardcoded
					badges[i].nodes[1].nodes[2].config.object:remove()
					badges[i] = {
						n = G.UIT.R,
						config = { align = "cm" },
						nodes = {
							{
								n = G.UIT.R,
								config = {
									align = "cm",
									colour = RevosVault.badge_colour,
									r = 0.1,
									minw = 2 / min_scale_fac,
									minh = 0.36,
									emboss = 0.05,
									padding = 0.03 * 0.9,
								},
								nodes = {
									{ n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
									{
										n = G.UIT.O,
										config = {
											object = DynaText({
												string = ct or "ERROR",
												colours = {
													obj.crv_credits and obj.crv_credits.text_colour or HEX("40093A"),
												},
												silent = true,
												float = true,
												shadow = true,
												offset_y = -0.03,
												spacing = 1,
												scale = 0.33 * 0.9,
											}),
										},
									},
									{ n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
								},
							},
						},
					}
					break
				end
			end
		end
	end
end

RevosVault.Lib = NFS.getDirectoryItems(RevosPath .. "items/Lib")
RevosVault.Misc = NFS.getDirectoryItems(RevosPath .. "items/Misc")
RevosVault.Consumables = NFS.getDirectoryItems(RevosPath .. "items/Consumables")
RevosVault.Jokers = NFS.getDirectoryItems(RevosPath .. "items/Jokers")
RevosVault.CrossMod = NFS.getDirectoryItems(RevosPath .. "items/Cross-Mod")

--
for k, file in ipairs(RevosVault.Lib) do
	SMODS.load_file("items/Lib/" .. file)()
end

for k, file in ipairs(RevosVault.Misc) do
	local file_no_lua = string.gsub(file, ".lua", "")
	if RevoConfig[file_no_lua .. "_enabled"] ~= nil then
		if RevoConfig[file_no_lua .. "_enabled"] ~= false then
			SMODS.load_file("items/Misc/" .. file)()
		end
	else
		SMODS.load_file("items/Misc/" .. file)()
	end
end

for k, file in ipairs(RevosVault.Consumables) do
	local file_no_lua = string.gsub(file, ".lua", "")
	if file == file_no_lua then
		local temp = NFS.getDirectoryItems(RevosPath .. "items/Consumables/" .. file) -- worst way possible
		for _, ffile in ipairs(temp) do
			if RevoConfig[string.lower(file) .. "_enabled"] ~= false then
				assert(SMODS.load_file("items/Consumables/" .. file .. "/" .. ffile))()
			end
		end
	else
		if RevoConfig[file_no_lua .. "_enabled"] ~= nil then
			if RevoConfig[file_no_lua .. "_enabled"] ~= false then
				SMODS.load_file("items/Consumables/" .. file)()
			end
		else
			SMODS.load_file("items/Consumables/" .. file)()
		end
	end
end

for k, file in ipairs(RevosVault.Jokers) do
	local file_no_lua = string.gsub(file, ".lua", "")
	if RevoConfig[file_no_lua .. "_enabled"] ~= nil then
		if RevoConfig[file_no_lua .. "_enabled"] ~= false then
			SMODS.load_file("items/Jokers/" .. file)()
		end
	else
		SMODS.load_file("items/Jokers/" .. file)()
	end
end

for k, file in ipairs(RevosVault.CrossMod) do
	local file_no_lua = string.gsub(file, ".lua", "")
	if next(SMODS.find_mod(file_no_lua)) then
		if file_no_lua == file then
			local temp = NFS.getDirectoryItems(RevosPath .. "items/Cross-Mod/" .. file) -- worst way possible
			for _, ffile in ipairs(temp) do
				if RevoConfig[ffile .. "_enabled"] ~= false then
					assert(SMODS.load_file("items/Cross-Mod/" .. file .. "/" .. ffile))()
				end
			end
		else
			SMODS.load_file("items/Cross-Mod/" .. file)()
		end
		if not RevosVault.crossed_mods then
			RevosVault.crossed_mods = 0
		end
		RevosVault.crossed_mods = RevosVault.crossed_mods + 1
	end
end

--Adds Gross Printer to the main menu. Code from Cryptid

--[[local oldfunc = Game.main_menu --ily cryptid x2
Game.main_menu = function(change_context)
	local ret = oldfunc(change_context)

	local newcard = Card(
		G.title_top.T.x,
		G.title_top.T.y,
		G.CARD_W,
		G.CARD_H,
		G.P_CARDS.empty,
		G.P_CENTERS.j_crv_grossprinter,
		{ bypass_discovery_center = true }
	)

	G.title_top.T.w = G.title_top.T.w * 1.7675
	G.title_top.T.x = G.title_top.T.x - 0.8
	G.title_top:emplace(newcard)

	newcard.T.w = newcard.T.w * 1.1 * 1.25
	newcard.T.h = newcard.T.h * 1.1 * 1.25
	newcard.no_ui = true
	newcard.states.visible = true
	return ret
end]]

SMODS.current_mod.menu_cards = function()
	return {
		{ key = "j_crv_printer" },
		{ key = "j_crv_grossprinter" },
		remove_original = true,
	}
end

SMODS.current_mod.reset_game_globals = function(run_start)
	if run_start then
		RevosVault.reset_whiteboard()
		RevosVault.reset_octopus()
		calculate_modded_printer()
		G.GAME.current_round.crv_drawn_hands = 0

		TheVault = {
			vault_cost = 70,
			vault_cost_default = 70,

			enhance_cost = 15,
			enhance_cost_default = 15,

			upgrade_cost = 40,
			upgrade_cost_default = 40,

			harvest_cost = 0,
			harvest_cost_default = 0,
			harvest_cost_extra = 0,
			harvest_cost_extra_default = 0,

			in_vault = false,

			current_vault_text = "Vault",
			changed = false, -- idk
		}

		if not RevoConfig["6_vault_enabled"] then
			TheVault.current_vault_text = "Reroll"
			TheVault.changed = true
			TheVault.vault_cost = 30
			TheVault.vault_cost_default = 30
		end
	end

	G.GAME.current_round.crv_drawn_hands = 0
	calculate_modded_printer()
	RevosVault.reset_whiteboard()
	RevosVault.reset_octopus()
end

-- err
if next(SMODS.find_mod("JoJoMod")) then
	RevosVault.crv_jojo = true
else
	RevosVault.crv_jojo = false
end

--ily cryptid
SMODS.ObjectType({
	key = "Food",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
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

SMODS.ObjectType({
	key = "BananaPool",
	cards = {
		["j_crv_ghostbanana"] = true,
		["j_crv_plantain"] = true,
		["j_crv_reban"] = true,
		["j_crv_tundan"] = true,
		["j_crv_bluj"] = true,
		["j_crv_bananavine"] = true,
		["j_crv_plainb"] = true,
		["j_crv_tickingb"] = true,
		["j_crv_uneasyb"] = true,
	},
	inject = function(self)
		SMODS.ObjectType.inject(self)
		self:inject_card(G.P_CENTERS.j_gros_michel)
		self:inject_card(G.P_CENTERS.j_cavendish)
	end,
})

SMODS.ObjectType({ -- not the best way but not the worst either i hope
	key = "crv_GeneralScrap",
	cards = {
		["c_crv_horn"] = true,
	},
	inject_card = function(self, center)
		local gpc = G.P_CENTER_POOLS
		self.cards = {}
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.1,
			func = function()
				for i = 1, #gpc.scrap do
					gpc.scrap[i].crv_is_scrap = true
					SMODS.insert_pool(gpc[self.key], gpc.scrap[i])
				end
				if RevosVault.crv_jojo then
					for i = 1, #gpc.jojo_Scraps do
						gpc.jojo_Scraps[i].crv_is_scrap = true
						SMODS.insert_pool(gpc[self.key], gpc.jojo_Scraps[i])
					end
				end
				return true
			end,
		}))
	end,
})

local vanilla = {
	"j_joker",
	"j_greedy_joker",
	"j_lusty_joker",
	"j_wrathful_joker",
	"j_gluttenous_joker",
	"j_zany",
	"j_mad",
	"j_crazy",
	"j_droll",
	"j_sly",
	"j_wily",
	"j_clever",
	"j_devious",
	"j_crafty",
	"j_half",
	"j_stencil",
	"j_four_fingers",
	"j_mime",
	"j_credit_card",
	"j_ceremonial",
	"j_banner",
	"j_mystic_summit",
	"j_marble",
	"j_loyalty_card",
	"j_8_ball",
	"j_misprint",
	"j_dusk",
	"j_raised_fist",
	"j_chaos",
	"j_fibonacci",
	"j_steel_joker",
	"j_scary_face",
	"j_abstract",
	"j_delayed_grat",
	"j_hack",
	"j_pareidolia",
	"j_gros_michel",
	"j_even_steven",
	"j_odd_todd",
	"j_scholar",
	"j_business",
	"j_supernova",
	"j_ride_the_bus",
	"j_space",
	"j_egg",
	"j_burglar",
	"j_blackboard",
	"j_runner",
	"j_ice_cream",
	"j_dna",
	"j_splash",
	"j_blue_joker",
	"j_sixth_sense",
	"j_constellation",
	"j_hiker",
	"j_faceless",
	"j_green_joker",
	"j_superposition",
	"j_todo_list",
	"j_cavendish",
	"j_card_sharp",
	"j_red_card",
	"j_madness",
	"j_square",
	"j_seance",
	"j_riff_raff",
	"j_vampire",
	"j_shortcut",
	"j_hologram",
	"j_vagabond",
	"j_baron",
	"j_cloud_9",
	"j_rocket",
	"j_obelisk",
	"j_midas_mask",
	"j_luchador",
	"j_photograph",
	"j_gift",
	"j_turtle_bean",
	"j_erosion",
	"j_reserved_parking",
	"j_mail",
	"j_to_the_moon",
	"j_hallucination",
	"j_fortune_teller",
	"j_juggler",
	"j_drunkard",
	"j_stone",
	"j_golden",
	"j_lucky_cat",
	"j_baseball",
	"j_bull",
	"j_diet_cola",
	"j_trading",
	"j_flash",
	"j_popcorn",
	"j_trousers",
	"j_ancient",
	"j_ramen",
	"j_walkie_talkie",
	"j_selzer",
	"j_castle",
	"j_smiley",
	"j_campfire",
	"j_ticket",
	"j_mr_bones",
	"j_acrobat",
	"j_sock_and_buskin",
	"j_swashbuckler",
	"j_troubadour",
	"j_certificate",
	"j_smeared",
	"j_throwback",
	"j_hanging_chad",
	"j_rough_gem",
	"j_bloodstone",
	"j_arrowhead",
	"j_onyx_agate",
	"j_glass",
	"j_ring_master",
	"j_flower_pot",
	"j_blueprint",
	"j_wee",
	"j_merry_andy",
	"j_oops",
	"j_idol",
	"j_seeing_double",
	"j_matador",
	"j_hit_the_road",
	"j_duo",
	"j_trio",
	"j_family",
	"j_order",
	"j_tribe",
	"j_stuntman",
	"j_invisible",
	"j_brainstorm",
	"j_satellite",
	"j_shoot_the_moon",
	"j_drivers_license",
	"j_cartomancer",
	"j_astronomer",
	"j_burnt",
	"j_bootstraps",
	"j_caino",
	"j_triboulet",
	"j_yorick",
	"j_chicot",
	"j_perkeo",
}
