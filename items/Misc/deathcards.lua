function RevosVault.back_to_death(load, save, force_save) --dumbass name
	if G.STATE ~= G.STATES.CRV_DEATHCARD then
		G.STATE = G.STATES.CRV_DEATHCARD
		ease_background_colour({ new_colour = HEX("964B00"), special_colour = G.C.BLACK })
	end
	if not G.deathcard or not G.deathcard_chose then
		for k, v in pairs(G) do
			if
				type(v) == "table"
				and v.states
				and v.states.visible
				and k ~= "SPLASH_BACK"
				and k ~= "deathcard"
				and k ~= "deathcard_chose"
			then
				v.states.visible = false
			end
		end
		if G.buttons then
			G.buttons:remove()
		end

		G.deathcard = G.deathcard
			or CardArea(
				5.5,
				2,
				4.25 * G.CARD_W,
				0.95 * G.CARD_H,
				{ card_limit = 1e300, type = "shop", highlight_limit = 0, no_card_count = true, colour = G.C.RED }
			)

		G.deathcard_chose = G.deathcard_chose
			or CardArea(
				5.5,
				7,
				(4.25 * G.CARD_W),
				0.95 * G.CARD_H,
				{ card_limit = 1e300, type = "joker", highlight_limit = 1, no_card_count = true, colour = G.C.RED }
			)

		if load then
			RevosVault.reset_dcard_states()
			G.STATE = G.STATES.GAME_OVER
			if not G.GAME.won and not G.GAME.seeded and not G.GAME.challenge then
				G.PROFILES[G.SETTINGS.profile].high_scores.current_streak.amt = 0
			end
			G:save_settings()
			G.FILE_HANDLER.force = true
			G.STATE_COMPLETE = false

			--[[RevosVault.deathcarded = false

			ease_background_colour({ new_colour = HEX("964B00"), special_colour = G.C.BLACK })

			if G.load_deathcard then
				G.deathcard:load(G.load_deathcard)
			end

			G.load_deathcard = nil
			G.load_deathcard_chose = nil]]
		end

		RevosVault.placeholder_name = ""

		if #G.deathcard.cards == 0 then
			local a = SMODS.add_card({ key = "j_crv_placeholder_death", area = G.deathcard })
			RevosVault.placeholder_name = RevosVault.placeholder_name or ""
			a.crv_canvas_text_1 = SMODS.CanvasSprite({
				canvasW = 71,
				canvasH = 95,
				text_offset = { x = 36, y = 11 },
				text_width = 45,
				text_height = 11,
				ref_table = RevosVault,
				ref_value = "placeholder_name",
				text_colour = HEX("351a09"),
			})
			-- print(RevosVault.placeholder_name)
			a.crv_canvas_text_2 = SMODS.CanvasSprite({
				canvasW = 71,
				canvasH = 95,
				text_offset = { x = 36, y = 78 },
				text_width = 45,
				text_height = 18,
				text = (G.GAME.crv_upgraded_timers and 5) or 3,
				text_colour = HEX("351a09"),
			})
		end

		if G.deathcard.cards and G.deathcard.cards[1] then
			G.deathcard.cards[1].no_ui = true
		end
	end

	if not G.GAME.crv_deathcard_state then
		G.GAME.crv_deathcard_state = "ability"
	end

	if G.GAME.crv_deathcard_state and not RevosVault.deathcarded then
		if #G.jokers.cards < 2 then
			for i = 1, (2 - #G.jokers.cards) + 1 do
				SMODS.add_card({
					key = "j_joker",
					area = G.jokers,
				})
			end
		end
		local function quicky()
			if G.GAME.crv_current_attention_text and type(G.GAME.crv_current_attention_text) == "table" then
				G.GAME.crv_current_attention_text:remove()
				G.GAME.crv_current_attention_text = nil
			end
			local tab = {}
			for k, v in pairs(G.jokers.cards) do
				tab[#tab + 1] = v
			end
			local a = (pseudorandom_element(tab, pseudoseed("choosing_ability")))
			local a_real = copy_card(a)

			for k, v in pairs(tab) do
				if v == a then
					table.remove(tab, k)
				end
			end

			local b = pseudorandom_element(tab, pseudoseed("choosing_ability"))
			local b_real = copy_card(b)

			G.deathcard_chose:emplace(a_real)
			G.deathcard_chose:emplace(b_real)

			tab = {}
			RevosVault.deathcarded = true
			G.E_MANAGER:add_event(Event({
				func = function()
					save_run()
					return true
				end,
			}))
		end

		local s = G.GAME.crv_deathcard_state
		if s == "ability" then
			RevosVault.attention_text("Choose your Joker's ability", 30, nil, 0.5, { x = -1, y = -0.6 })
			quicky()
		elseif s == "rarity" then
			-- print("do rarity shit") ?

			RevosVault.attention_text("Choose your Joker's rarity", 30, nil, 0.5, { x = -1, y = -0.6 })
			quicky()
		elseif s == "modif" then
			RevosVault.attention_text("Choose your Joker's edition", 30, nil, 0.5, { x = -1, y = -0.6 })
			quicky()
		elseif s == "name" then
			-- not implemented
		end
	end

	if (save and not RevosVault.save_not_saved) or force_save1 then
		RevosVault.save_not_saved = true
		G.E_MANAGER:add_event(Event({
			func = function()
				save_run()
				return true
			end,
		}))
	end
end

function RevosVault.len(table)
	local a = 0
	for k, v in pairs(table) do
		a = a + 1
	end
	return a
end

function RevosVault.random_deathcard()
	local tab = {
		["j_crv_deathcard1"] = true,
		["j_crv_deathcard2"] = true,
		["j_crv_deathcard3"] = true,
		["j_crv_deathcard4"] = true,
		["j_crv_deathcard5"] = true,
	}
	local rtab = {} --aafgsdhfasgbas
	local PDCARD = G.PROFILES[G.SETTINGS.profile].crv_deathcards
	for k, v in pairs(PDCARD) do
		--print(v.occupied_card)
		if v and v.occupied_card then
			for k2, v2 in pairs(tab) do
				--print(v.occupied_card, k2)
				if k2 == v.occupied_card then
					--print("MATCH!")
					tab[k2] = false
				end
			end
		end
	end
	for k, v in pairs(tab) do
		if v then
			--print(v, k)
			rtab[#rtab + 1] = k
		end
	end

	local a = pseudorandom_element(rtab, pseudoseed("fuckyou"))

	return a
end

function RevosVault.get_deathcards()
	local tab = {}
	for k, v in pairs(G.PROFILES[G.SETTINGS.profile].crv_deathcards) do
		if v.occupied_card and G.P_CENTERS[v.occupied_card] then
			tab[#tab + 1] = G.P_CENTERS[v.occupied_card]
		end
	end
	return tab
end

function RevosVault.dcard_in_pool(dcard)
	for k, v in pairs(G.PROFILES[G.SETTINGS.profile].crv_deathcards) do
		if dcard == v.occupied_card then
			return true
		end
	end
	return false
end

function G.UIDEF.available_deathcards_crv()
	local silent = false
	local keys_used = {}
	local area_count = 0
	local voucher_areas = {}
	local voucher_tables = {}
	local voucher_table_rows = {}
	for k, v in ipairs(RevosVault.get_deathcards() or {}) do
		keys_used[#keys_used + 1] = v
	end
	for k, v in ipairs(keys_used) do
		if next(v) then
			area_count = area_count + 1
		end
	end
	for k, v in ipairs(keys_used) do
		if next(v) then
			if #voucher_areas == 5 or #voucher_areas == 10 then
				table.insert(
					voucher_table_rows,
					{ n = G.UIT.R, config = { align = "cm", padding = 0, no_fill = true }, nodes = voucher_tables }
				)
				voucher_tables = {}
			end
			voucher_areas[#voucher_areas + 1] = CardArea(
				G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2,
				G.ROOM.T.h,
				(#v == 1 and 1 or 1.33) * G.CARD_W,
				(area_count >= 10 and 0.75 or 1.07) * G.CARD_H,
				{ card_limit = 2, type = "voucher", highlight_limit = 0 }
			)

			local center = v
			local card = Card(
				voucher_areas[#voucher_areas].T.x + voucher_areas[#voucher_areas].T.w / 2,
				voucher_areas[#voucher_areas].T.y,
				G.CARD_W,
				G.CARD_H,
				nil,
				center,
				{ bypass_discovery_center = true, bypass_discovery_ui = true, bypass_lock = true }
			)
			card:start_materialize(nil, silent)
			silent = true
			voucher_areas[#voucher_areas]:emplace(card)
			if card.config.center.crv_forced_edition then
				card:set_edition(card.config.center.crv_forced_edition, true, true)
			end

			table.insert(voucher_tables, {
				n = G.UIT.C,
				config = { align = "cm", padding = 0, no_fill = true },
				nodes = {
					{ n = G.UIT.O, config = { object = voucher_areas[#voucher_areas] } },
				},
			})
		end
	end
	table.insert(
		voucher_table_rows,
		{ n = G.UIT.R, config = { align = "cm", padding = 0, no_fill = true }, nodes = voucher_tables }
	)

	local t = silent
			and {
				n = G.UIT.ROOT,
				config = { align = "cm", colour = G.C.CLEAR },
				nodes = {
					{
						n = G.UIT.R,
						config = { align = "cm" },
						nodes = {
							{
								n = G.UIT.O,
								config = {
									object = DynaText({
										string = { localize("ph_available_deathcards") },
										colours = { G.C.UI.TEXT_LIGHT },
										bump = true,
										scale = 0.6,
									}),
								},
							},
						},
					},
					{ n = G.UIT.R, config = { align = "cm", minh = 0.5 }, nodes = {} },
					{
						n = G.UIT.R,
						config = { align = "cm", colour = G.C.BLACK, r = 1, padding = 0.15, emboss = 0.05 },
						nodes = {
							{ n = G.UIT.R, config = { align = "cm" }, nodes = voucher_table_rows },
						},
					},
				},
			}
		or {
			n = G.UIT.ROOT,
			config = { align = "cm", colour = G.C.CLEAR },
			nodes = {
				{
					n = G.UIT.O,
					config = {
						object = DynaText({
							string = { localize("no_deathcards") },
							colours = { G.C.UI.TEXT_LIGHT },
							bump = true,
							scale = 0.6,
						}),
					},
				},
			},
		}
	return t
end

function RevosVault.get_empty_slot()
	local a = {}
	for k, v in pairs({ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }) do
		if not G.PROFILES[G.SETTINGS.profile].crv_deathcards[v] then
			a[#a + 1] = v
		end
	end
	local b = pseudorandom_element(a)
	return b
end

G.FUNCS.crv_death_ability = function(e)
	local card, PDCARD = e.config.ref_table, G.PROFILES[G.SETTINGS.profile].crv_deathcards

	if G.GAME.crv_deathcard_state == "ability" then
		RevosVault.set_ability({
			card = G.deathcard.cards[1],
			sound = "gong",
			custom_func = function()
				-- G.GAME.deathcard_seed_crv = pseudorandom("wo")*pseudorandom("wo2")
				G.GAME.deathcard_seed_crv = RevosVault.get_empty_slot()
				if not PDCARD then
					PDCARD = {}
				end

				PDCARD[G.GAME.deathcard_seed_crv] = {}

				PDCARD[G.GAME.deathcard_seed_crv].given_name = ""
				PDCARD[G.GAME.deathcard_seed_crv].incomplete = true

				PDCARD[G.GAME.deathcard_seed_crv].function_from = card.config.center.key
				PDCARD[G.GAME.deathcard_seed_crv].name = card.config.center.name
				PDCARD[G.GAME.deathcard_seed_crv].ability_table = copy_table(card.ability)

				if card.config.center.mod then
					PDCARD[G.GAME.deathcard_seed_crv].mod = card.config.center.mod.id
				end

				PDCARD[G.GAME.deathcard_seed_crv].sprite_x =
					pseudorandom_element({ 0, 1, 2, 3, 4 }, pseudoseed("j_crv_deathcard" .. "1"))
				PDCARD[G.GAME.deathcard_seed_crv].sprite_y =
					pseudorandom_element({ 0, 1, 2 }, pseudoseed("j_crv_deathcard" .. "2"))

				G.deathcard.cards[1].config.center.pos.x = PDCARD[G.GAME.deathcard_seed_crv].sprite_x
				G.deathcard.cards[1].config.center.pos.y = PDCARD[G.GAME.deathcard_seed_crv].sprite_y

				SMODS.destroy_cards(G.deathcard_chose.cards)
			end,
			second_func = function()
				G.GAME.crv_deathcard_state = "rarity"
				RevosVault.deathcarded = false
			end,
		})
	elseif G.GAME.crv_deathcard_state == "rarity" then
		RevosVault.set_ability({
			card = G.deathcard.cards[1],
			sound = "gong",
			custom_func = function()
				PDCARD[G.GAME.deathcard_seed_crv].rarity = card.config.center.rarity

				G.deathcard.cards[1].rarity = card.config.center.rarity --not needed since no ui

				SMODS.destroy_cards(G.deathcard_chose.cards)
			end,
			second_func = function()
				G.GAME.crv_deathcard_state = "modif"
				RevosVault.deathcarded = false
			end,
		})
	elseif G.GAME.crv_deathcard_state == "modif" then
		RevosVault.set_ability({
			card = G.deathcard.cards[1],
			sound = "gong",
			custom_func = function()
				-- PDCARD[G.GAME.deathcard_seed_crv]["modif"] = {}
				PDCARD[G.GAME.deathcard_seed_crv].timer = (G.GAME.crv_upgraded_timers and 5) or 3

				if card.edition then
					PDCARD[G.GAME.deathcard_seed_crv].edition = card.edition.key

					G.deathcard.cards[1]:set_edition(card.edition.key, true, true)
				end

				SMODS.destroy_cards(G.deathcard_chose.cards)

				PDCARD[G.GAME.deathcard_seed_crv].occupied_card = RevosVault.random_deathcard()

				save_run()
				G:save_settings()
			end,
			second_func = function()
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 3.5,
					func = function()
						G.FUNCS.get_name_box()
						RevosVault.go_nuts = true
						return true
					end,
				}))
			end,
		})
	end
end

G.FUNCS.get_name_box = function(e)
	G.FUNCS.overlay_menu({
		definition = RevosVault.dcard_name(),
	})
end

G.FUNCS.end_game_crv = function()
	local PDCARD = G.PROFILES[G.SETTINGS.profile].crv_deathcards
	PDCARD[G.GAME.deathcard_seed_crv].incomplete = false
	-- RevosVault.reset_dcard_states()
	G.E_MANAGER:add_event(Event({

		trigger = "after",
		delay = 0.1,
		func = function()
			RevosVault.deathcarded = false
			G.GAME.crv_deathcard_state = nil
			G.STATE = G.STATES.GAME_OVER
			if not G.GAME.won and not G.GAME.seeded and not G.GAME.challenge then
				G.PROFILES[G.SETTINGS.profile].high_scores.current_streak.amt = 0
			end
			G:save_settings()
			G.FILE_HANDLER.force = true
			G.STATE_COMPLETE = false
			return true
		end,
	}))
end

function RevosVault.dcard_name()
	G.E_MANAGER:add_event(Event({
		blockable = false,
		func = function()
			G.REFRESH_ALERTS = true
			return true
		end,
	}))
	local t = create_UIBox_generic_options({
		no_back = true,
		colour = HEX("04200c"),
		outline_colour = G.C.BLACK,
		contents = {
			{
				n = G.UIT.R,
				nodes = {
					create_text_input({
						colour = G.C.GREY,
						hooked_colour = G.C.GREY,
						w = 4.5,
						h = 1,
						max_length = 9,
						extended_corpus = true,
						prompt_text = "Name your Joker",
						ref_table = G.PROFILES[G.SETTINGS.profile].crv_deathcards[G.GAME.deathcard_seed_crv],
						ref_value = "given_name",
						keyboard_offset = 1,
					}),
				},
			},
			{
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					UIBox_button({
						colour = G.C.GREY,
						button = "end_game_crv",
						label = { "Enter" },
						minw = 4.5,
						focus_args = { snap_to = true },
					}),
				},
			},
		},
	})
	return t
end

function RevosVault.deathscreen()
	G.E_MANAGER:add_event(Event({
		trigger = "before",
		func = function()
			RevosVault.old_sound = G.SETTINGS.SOUND.music_volume
			G.SETTINGS.SOUND.music_volume = 0
			return true
		end,
	}))
	G.E_MANAGER:add_event(Event({
		trigger = "before",
		delay = 0.1,
		func = function()
			G.GAME.screen_off_crv = true
			play_sound("crv_lights_off")
			return true
		end,
	}))
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 3,
		func = function()
			RevosVault.back_to_death(nil, true)
			G.GAME.screen_off_crv = false
			G.SETTINGS.SOUND.music_volume = RevosVault.old_sound
			play_sound("crv_lights_on")
			if not RevosVault.ui_disbled("crv_deathcards_help") then
				ease_background_colour({ new_colour = HEX("964B00"), special_colour = G.C.BLACK })
				G.FUNCS.RevosVault_info{menu_type = "crv_deathcards_help", pause = true}
			end
			return true
		end,
	}))
end

function RevosVault.reset_dcard_states()
	G.GAME.deathcard_seed_crv = nil
	RevosVault.deathcarded = false
	G.GAME.crv_deathcard_state = nil
	RevosVault.placeholder_name = nil

	if G and G.P_CENTER_POOLS and G.P_CENTER_POOLS.j_crv_placeholder_death then
		G.P_CENTER_POOLS.j_crv_placeholder_death.pos.x = 0
		G.P_CENTER_POOLS.j_crv_placeholder_death.pos.y = 0
	end
end
