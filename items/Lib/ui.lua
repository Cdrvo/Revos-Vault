-- Thank you JoyousSpring
RevosVault.custom_ui = function(modNodes)
	modNodes[1].nodes[1].config.colour = G.C.PURPLE
	G.printer_info = CardArea(
		G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2,
		G.ROOM.T.h,
		4.25 * G.CARD_W,
		0.95 * G.CARD_H,
		{ card_limit = 5, type = "title", highlight_limit = 0, collection = true }
	)
	local random_random = { "crv_printer" }
	--[[if RevoConfig["7_chaos_enabled"] then -- until i get 5 mythicals	
		random_random[#random_random+1] = "crv_chaos"
	end]]
	local random_rarity = pseudorandom_element(random_random)

	local random_cards2 = {}
	local random_cards = {}

	if G.P_CENTER_POOLS[random_rarity] then
		for k, card in pairs(G.P_CENTER_POOLS[random_rarity]) do
			random_cards2[#random_cards2 + 1] = card.key
		end
	elseif G.P_JOKER_RARITY_POOLS[random_rarity] then
		for k, card in pairs(G.P_JOKER_RARITY_POOLS[random_rarity]) do
			random_cards2[#random_cards2 + 1] = card.key
		end
	end

	pseudoshuffle(random_cards2, pseudoseed("revo_sucks_at_ui"))
	for i = 1, 5 do
		random_cards[#random_cards + 1] = random_cards2[1]
		table.remove(random_cards2, 1)
	end

	if not random_cards then
		random_cards = {
			"j_crv_printer",
			"j_crv_grossprinter",
			"j_crv_rustyprinter",
			"j_crv_jimboprinter",
			"j_crv_obeliskprinter",
		}
	end
	local a = 0

	for i, key in pairs(random_cards) do
		local card = Card(
			G.printer_info.T.x + G.printer_info.T.w / 2,
			G.printer_info.T.y,
			G.CARD_W,
			G.CARD_H,
			G.P_CARDS.empty,
			G.P_CENTERS[key]
		)
		card.dissolve = 1
		G.printer_info:emplace(card)
		card:flip()

		G.E_MANAGER:add_event(Event({
			blocking = false,
			trigger = "after",
			delay = 0.2 * i,
			func = function()
				if card and G.printer_info and G.printer_info.cards and #G.printer_info.cards then
					card:start_materialize()
					a = a + 1
					if a >= 3 then
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0,
							func = function()
								if G.printer_info and G.printer_info.cards and #G.printer_info.cards then
									for i = 1, #G.printer_info.cards do
										local card = G.printer_info.cards[i]
										G.E_MANAGER:add_event(Event({
											blocking = false,
											trigger = "after",
											delay = 0.1 * i,
											func = function()
												if card and card.facing == "back" then
													play_sound("card1")
													card:flip()
													card:juice_up()
												end
												return true
											end,
										}))
									end
								end
								return true
							end,
						}))
					end
				end
				return true
			end,
		}))
	end

	modNodes[1] = {
		n = G.UIT.R,
		config = { align = "cm", padding = 0.07, no_fill = true },
		nodes = {
			{
				n = G.UIT.O,
				config = {
					object = DynaText({
						string = { "Revo's Vault" },
						colours = { G.C.REVO },
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
	}

	modNodes[#modNodes + 1] = {
		n = G.UIT.R,
		config = { align = "cm", padding = 0.07, no_fill = true },
		nodes = {
			{ n = G.UIT.O, config = { object = G.printer_info } },
		},
	}

	modNodes[#modNodes + 1] = {
		n = G.UIT.R,
		config = { align = "cm", padding = 0.07, no_fill = true },
		nodes = {
			{ n = G.UIT.T, config = { text = "by: CodeRevo", scale = 0.4, colour = G.C.PURPLE, shadow = true } },
		},
	}
end

RevosVault.ui_config = {
	colour = darken(G.C.PURPLE, 0.6),
	bg_colour = { G.C.PURPLE[1], G.C.BLACK[2], G.C.PURPLE[2], 0.3 },
	back_colour = darken(G.C.PURPLE, 0.3),
	tab_button_colour = darken(HEX("7E7AFF"), 0.2),
	collection_option_cycle_colour = darken(HEX("7E7AFF"), 0.2),
}

RevosVault.custom_collection_tabs = function()
	local t = {}
	t[#t + 1] = UIBox_button({
		button = "your_collection_crv_status_effects",
		id = "your_collection_crv_status_effects",
		label = { localize("b_status_effects") },
		minw = 5,
		minh = 1,
		--[[count = {
			tally = RVF.get_collection(RevosVault.MISC.StatusEffects),
			of = RVF.get_total(RevosVault.MISC.StatusEffects),
		},]]
	})
	t[#t + 1] = UIBox_button({
		button = "your_collection_crv_borders",
		id = "your_collection_crv_borders",
		label = { "Borders" },
		minw = 5,
		minh = 1,
		--[[count = {
			tally = RVF.get_collection(RevosVault.MISC.StatusEffects),
			of = RVF.get_total(RevosVault.MISC.StatusEffects),
		},]]
	})

	return t
end

-- UI related stuff for Status Effects

local function create_ui_for_pool(pool, sticker_like)
	local objects = {}

	for k, v in pairs(pool) do
		objects[#objects + 1] = v
	end

	return SMODS.card_collection_UIBox(objects, { 5, 5 }, {
		snap_back = true,
		hide_single_page = true,
		collapse_single_page = true,
		h_mod = 1.18,
		back_func = "your_collection_other_gameobjects",
		center = (sticker_like and "c_base") or nil,
		modify_card = function(card, center)
			if sticker_like then
				center:apply(card, true)
			end
		end,
	})
end

G.FUNCS.your_collection_crv_status_effects = function()
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu({
		definition = create_ui_for_pool(RevosVault.MISC.StatusEffects, true),
	})
end

G.FUNCS.your_collection_crv_borders = function()
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu({
		definition = create_ui_for_pool(RevosVault.MISC.Borders, true),
	})
end

--

-- Printer Deck UI

G.UIDEF.crv_printer_selection = function()
	G.current_printer =
		CardArea(0, 0, 1.15 * G.CARD_W, 1.05 * G.CARD_H, { card_limit = 1, type = "shop", highlight_limit = 0 })
	local t = create_UIBox_generic_options({
		no_back = true,
		contents = {
			{
				n = G.UIT.R,
				config = { align = "cm", r = 0.1, colour = G.C.BLACK, padding = 0.1 },
				nodes = {

					{
						n = G.UIT.R,
						config = { align = "cm", r = 0.3, colour = G.C.CLEAR, padding = 0 },
						nodes = {

							{
								n = G.UIT.O,
								config = {
									object = DynaText({
										string = { localize("d_select_printer") },
										colours = { G.C.EDITION },
										shadow = true,
										float = true,
										spacing = 0.3,
										scale = 1,
										rotate = true,
										pop_in = 0.1,
									}),
								},
							},
						},
					},
				},
			},

			{
				n = G.UIT.R,
				config = { align = "cm", r = 0.1, colour = G.C.BLACK, padding = 0.1 },
				nodes = {
					{
						n = G.UIT.C,
						config = { align = "cm", r = 0.3, colour = G.C.UI.BACKGROUND_DARK, padding = 0.1 },
						nodes = {
							{
								n = G.UIT.R,
								config = { align = "cm", r = 0.3, colour = G.C.BLACK, padding = 0.1 },
								nodes = {
									{
										n = G.UIT.R,
										config = { align = "cm", r = 0.3, colour = G.C.BLACK, padding = 0.1 },
										nodes = {
											{ n = G.UIT.O, config = { object = G.current_printer } },
										},
									},
								},
							},
						},
					},
					{
						n = G.UIT.C,
						config = { align = "cm", r = 0.3, colour = G.C.CLEAR, padding = 0.1 },
						nodes = {
							{
								n = G.UIT.R,
								config = { align = "cm", r = 0.10, colour = G.C.BLACK, padding = 0.15 },
								nodes = {
									UIBox_button({
										colour = G.C.IMPORTANT,
										button = "crv_printer_list",
										label = { localize("b_printer_list") },
										minw = 4,
										focus_args = { snap_to = true },
									}),
									UIBox_button({
										colour = G.C.ATTENTION,
										button = "crv_find_random_printer",
										label = { localize("b_random_printer") },
										minw = 4,
										focus_args = { snap_to = true },
									}),
									UIBox_button({
										colour = RevosVault.ui_config.tab_button_colour,
										button = "crv_leave_printer_select",
										label = { localize("b_enter") },
										minw = 4,
										focus_args = { snap_to = true },
									}),
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

function RVF.printer_list()
	local deck_tables = {}

	local printers = {}

	for k, v in pairs(SMODS.get_attribute_pool("printer")) do
		local center = G.P_CENTERS[v]
		if not center.no_collection and not center.no_printer_list then
			printers[#printers + 1] = center
		end
	end

	G.your_collection = {}
	for j = 1, 3 do
		G.your_collection[j] = CardArea(
			G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2,
			G.ROOM.T.h,
			5 * G.CARD_W,
			0.95 * G.CARD_H,
			{ card_limit = 5, type = "title", highlight_limit = 0, collection = true }
		)
		table.insert(deck_tables, {
			n = G.UIT.R,
			config = { align = "cm", padding = 0.07, no_fill = true },
			nodes = {
				{ n = G.UIT.O, config = { object = G.your_collection[j] } },
			},
		})
	end

	local joker_options = {}
	for i = 1, math.ceil(#printers / (5 * #G.your_collection)) do
		table.insert(
			joker_options,
			localize("k_page") .. " " .. tostring(i) .. "/" .. tostring(math.ceil(#printers / (5 * #G.your_collection)))
		)
	end

	for i = 1, 5 do
		for j = 1, #G.your_collection do
			local center = printers[i + (j - 1) * 5]
			local card = Card(
				G.your_collection[j].T.x + G.your_collection[j].T.w / 2,
				G.your_collection[j].T.y,
				G.CARD_W,
				G.CARD_H,
				nil,
				center
			)
			card.bypass_discovery_center = true
			card.sticker = get_joker_win_sticker(center)
			G.your_collection[j]:emplace(card)
			card:add_sticker("eternal", true)
		end
	end

	INIT_COLLECTION_CARD_ALERTS()

	local t = create_UIBox_generic_options({
		back_func = "crv_open_printer_selection",
		contents = {
			{ n = G.UIT.R, config = { align = "cm", r = 0.1, colour = G.C.BLACK, emboss = 0.05 }, nodes = deck_tables },
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					create_option_cycle({
						options = joker_options,
						w = 4.5,
						cycle_shoulders = true,
						opt_callback = "your_collecion_printer_list",
						current_option = 1,
						colour = G.C.RED,
						no_pips = true,
						focus_args = { snap_to = true, nav = "wide" },
					}),
				},
			},
		},
	})
	return t
end
G.FUNCS.your_collecion_printer_list = function(args)
	local printers = {}
	for k, v in pairs(SMODS.get_attribute_pool("printer")) do
		local center = G.P_CENTERS[v]
		if not center.no_collection and not center.no_printer_list then
			printers[#printers + 1] = center
		end
	end

	if not args or not args.cycle_config then
		return
	end
	for j = 1, #G.your_collection do
		for i = #G.your_collection[j].cards, 1, -1 do
			local c = G.your_collection[j]:remove_card(G.your_collection[j].cards[i])
			c:remove()
			c = nil
		end
	end
	for i = 1, 5 do
		for j = 1, #G.your_collection do
			local center = printers[i + (j - 1) * 5 + (5 * #G.your_collection * (args.cycle_config.current_option - 1))]
			if not center then
				break
			end
			local card = Card(
				G.your_collection[j].T.x + G.your_collection[j].T.w / 2,
				G.your_collection[j].T.y,
				G.CARD_W,
				G.CARD_H,
				G.P_CARDS.empty,
				center
			)

			G.your_collection[j]:emplace(card)
			card:add_sticker("eternal", true)
		end
	end
end

-- FUNCS related to UI

-- printer deck funcs

G.FUNCS.crv_leave_printer_select = function()
	G.FUNCS.exit_overlay_menu()
	G.GAME.crv_selected_printer = nil
end

G.FUNCS.crv_open_printer_selection = function()
	RVF.easy_overlay(nil, G.UIDEF.crv_printer_selection())
	if G.GAME.crv_selected_printer then
		local a = SMODS.add_card({
			key = G.GAME.crv_selected_printer,
			area = G.current_printer,
		})
		a:add_sticker("eternal", true)
	else
		local a = SMODS.add_card({
			key = "j_crv_blueprinter",
			area = G.current_printer,
		})
		a:add_sticker("eternal", true)
	end
end

G.FUNCS.crv_printer_list = function()
	G.GAME.crv_printer_list = true
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu({
		definition = RVF.printer_list(),
	})
end

G.FUNCS.crv_find_random_printer = function()
	if G.current_printer and #G.current_printer.cards > 0 then
		SMODS.destroy_cards(
			G.current_printer.cards,
			{ bypass_eternal = true, immediate = true, silent = true, dissolve_time_fac = 0 }
		)
	end
	local pool = SMDOS.get_attribute_pool("printer")
	local random_printer = pseudorandom_element(pool, pseudoseed("printer_deck"))

	local a = SMODS.add_card({
		key = random_printer,
		area = G.current_printer,
		no_edition = true,
	})
	a:add_sticker("eternal", true)
	play_sound("card1")
end
