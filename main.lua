RevosVault = SMODS.current_mod
SMDOS = SMODS
RevosVault.FUNCS = {}
RevosVault.PATHS = {}
RevosVault.MISC = {}

SMODS.current_mod.optional_features = function()
	return {
		post_trigger = true,
		retrigger_joker = true,
		cardareas = {
			unscored = true,
		},
	}
end

RevosVault.PATHS.Jokers = NFS.getDirectoryItems(RevosVault.path .. "items/Jokers")
RevosVault.PATHS.Consumables = NFS.getDirectoryItems(RevosVault.path .. "items/Consumables")
RevosVault.PATHS.Misc = NFS.getDirectoryItems(RevosVault.path .. "items/Misc")
RevosVault.PATHS.Lib = NFS.getDirectoryItems(RevosVault.path .. "items/Lib")

--

for k, file in ipairs(RevosVault.PATHS.Jokers) do
	local file_no_lua = string.gsub(file, ".lua", "")
	if RevosVault.config[file_no_lua .. "_enabled"] ~= nil then
		if RevosVault.config[file_no_lua .. "_enabled"] ~= false then
			SMODS.load_file("items/Jokers/" .. file)()
		end
	else
		SMODS.load_file("items/Jokers/" .. file)()
	end
end

for k, file in ipairs(RevosVault.PATHS.Consumables) do
	local file_no_lua = string.gsub(file, ".lua", "")
	if RevosVault.config[file_no_lua .. "_enabled"] ~= nil then
		if RevosVault.config[file_no_lua .. "_enabled"] ~= false then
			SMODS.load_file("items/Consumables/" .. file)()
		end
	else
		SMODS.load_file("items/Consumables/" .. file)()
	end
end

for k, file in ipairs(RevosVault.PATHS.Misc) do
	local file_no_lua = string.gsub(file, ".lua", "")
	if RevosVault.config[file_no_lua .. "_enabled"] ~= nil then
		if RevosVault.config[file_no_lua .. "_enabled"] ~= false then
			SMODS.load_file("items/Misc/" .. file)()
		end
	else
		SMODS.load_file("items/Misc/" .. file)()
	end
end

for k, file in ipairs(RevosVault.PATHS.Lib) do
	SMODS.load_file("items/Lib/" .. file)()
end

-- Calculate

RevosVault.calculate = function(mod, context)
	if context.end_of_round and context.main_eval then
		for k, v in pairs(G.jokers.cards) do
			if v.ability.crv_copycat then
				RVF.cool_enhance(v, "j_crv_copycat")
				v.ability.crv_copycat = nil
			end
		end
		for k, v in pairs(G.playing_cards) do
			if v.ability.crv_spamton_buff then
				SMODS.Stickers["crv_spamton_buff"]:apply(v, false)
			end
		end
	end
	if context.crv_swoon_shake then
		G.ROOM.jiggle = 50
		for k, v in pairs(G.jokers.cards) do
			v:juice_up()
		end
	end
	if context.printer_trigger and context.printer and context.printer.ability.crv_cartridges then
		local p, card = context.printer, context.card_made.center
		local extra = false

		local to_sort = {}

		for k, v in pairs(p.ability.crv_cartridges) do
			to_sort[#to_sort + 1] = k
		end

		table.sort(to_sort, function(a, b)
			return G.P_CENTERS[a].crv_priority < G.P_CENTERS[b].crv_priority
		end)

		for k, v in pairs(to_sort) do
			if G.P_CENTERS[v].crv_calculate then
				G.P_CENTERS[v]:crv_calculate(context.printer, context.card_made)
				extra = true
			end
		end

		if not extra then
			--[[if p.ability.crv_cartridges["c_crv_glitchy"] then
				if RVF.has_room(G.jokers) then
					SMODS.copy_card(card)
					RVF.msg(p, "Another!")
				else
					RVF.msg(p, localize("k_no_room_ex"))
				end
			end]]
		end
	end
end

SMODS.current_mod.menu_cards = function()
	return {
		{ key = "j_crv_blueprinter" },
		{ key = "j_crv_gros_printer" },
		remove_original = true,
	}
end

-- Credits system from Hot Potato // fixed
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
				if badges[i].nodes[1].config.id == "badge_RevosVault" then
					-- badges[i].nodes[1].nodes[2].config.object:remove()
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
