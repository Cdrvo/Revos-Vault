-- D6

G.FUNCS.can_reroll_cards = function(e)
	local card = e.config.ref_table
	if card.config.center.can_reroll and card:reroll_check() == true then
		e.config.colour = G.C.RED
		e.config.button = "reroll_cards"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

function Card:reroll_check()
	local obj = self.config.center
	if obj.can_reroll and type(obj.can_reroll) == "function" then
		local o, t = obj:can_reroll(self)
		if o or t then
			return o, t
		end
	end
end

G.FUNCS.reroll_cards = function(e)
	local card = e.config.ref_table
	Card:reroll_cards()
end

function Card:reroll_cards()
	SMODS.calculate_context({ reroll_cards = true })
end -- ????????????????????????????

-- The Vault (shop)

G.FUNCS.crv_can_emplace_to_vault = function(e)
	local card = e.config.ref_table
	if G.vault_card and G.vault_card.cards and (#G.vault_card.cards == 0) then
		e.config.colour = G.C.RED
		e.config.button = "crv_emplace_to_vault"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

G.FUNCS.crv_emplace_to_vault = function(e)
	local card = e.config.ref_table
	RevosVault.move_card(card, G.vault_card)
	G.E_MANAGER:add_event(Event({
		func = function()
			save_run()
			return true
		end,
	}))
end

G.FUNCS.crv_remove_from_vault = function(e)
	local card = e.config.ref_table
	if
		(G.jokers and G.jokers.cards and #G.jokers.cards < G.jokers.config.card_limit and card)
		or (card and card.edition and card.edition.negative)
	then
		RevosVault.move_card(card, G.jokers)
		G.E_MANAGER:add_event(Event({
			func = function()
				save_run()
				return true
			end,
		}))
	elseif card and G.jokers then
		alert_no_space(card, G.jokers)
	end
end

-- Holo face

G.FUNCS.crv_can_change = function(e)
	local card = e.config.ref_table
	if not RevosVault.scoring then
		e.config.colour = G.C.RED
		e.config.button = "crv_change"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

G.FUNCS.crv_change = function(e)
	local card = e.config.ref_table
	if card:is_face() then
		local face = pseudorandom_element(RevosVault.facepool(card.base.value)).key
		card:flip()
		G.E_MANAGER:add_event(Event({
			trigger = "before",
			delay = 0.5,
			func = function()
				return true
			end,
		}))
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.5,
			func = function()
				SMODS.change_base(card, nil, face)
				card:flip()
				return true
			end,
		}))
	end
end

-- The Dealer

G.FUNCS.can_change_mode = function(e)
	local card = e.config.ref_table
	if card.ability.extra["turn"] == "Player" then
		e.config.colour = G.C.RED
		e.config.button = "crv_modee"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

G.FUNCS.crv_modee = function(e)
	local card = e.config.ref_table
	if card.ability.extra["turn"] == "Player" then
		if card.ability.extra["mode"] == "Joker" then
			card.ability.extra["mode"] = "Self"
			RevosVault.c_message(card, "Self!")
		elseif card.ability.extra["mode"] == "Self" then
			card.ability.extra["mode"] = "Joker"
			RevosVault.c_message(card, "Joker!")
		end
	end
end

-- Jimbo's Apple

G.FUNCS.crv_eaten = function(e)
	local card = e.config.ref_table
	card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
	if #SMODS.find_card("j_crv_oldjimbo") > 0 then
		for i = 1, #SMODS.find_card("j_crv_oldjimbo") do
			SMODS.find_card("j_crv_oldjimbo")[1]:start_dissolve()
		end
	end
	if G.STATE ~= G.STATES.SELECTING_HAND then
		return
	end
	G.GAME.chips = G.GAME.blind.chips
	G.STATE = G.STATES.HAND_PLAYED
	G.STATE_COMPLETE = true
	end_round()
end

-- Invesment

G.FUNCS.crv_invest = function(e) -- i am way to lazy to fix this right now. I will fix it later.................................................................
	local card = e.config.ref_table
	if card.ability.extra["check"] == false then
		card.ability.extra["check"] = true
		if G.GAME.talisman == 1 then
			card.ability.extra["invested"] = to_number(G.GAME.dollars / 4)
			ease_dollars(-(to_number(G.GAME.dollars / 4)))
		else
			card.ability.extra["invested"] = G.GAME.dollars / 4
			ease_dollars(-(G.GAME.dollars / 4))
		end
	end
end

G.FUNCS.crv_can_invest = function(e)
	local card = e.config.ref_table
	if card.ability.extra["check"] == false then
		e.config.colour = G.C.RED
		e.config.button = "crv_invest"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

-- Roulette

G.FUNCS.crv_changebet = function(e)
	local card = e.config.ref_table
	if card.ability.extra["bet"] == "Black" then
		card.ability.extra["bet"] = "Red"
		RevosVault.c_message(card, "Red!")
	elseif card.ability.extra["bet"] == "Red" then
		card.ability.extra["bet"] = "Green"
		RevosVault.c_message(card, "Green!")
	elseif card.ability.extra["bet"] == "Green" then
		card.ability.extra["bet"] = "Black"
		RevosVault.c_message(card, "Black!")
	end
end

-- Deal Breaker

G.FUNCS.crv_half = function(e)
	local card = e.config.ref_table
	card.ability.extra["uses"] = card.ability.extra["uses"] - 1
	G.GAME.blind.chips = G.GAME.blind.chips / 2
	G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
	RevosVault.c_message(card, "Halved!")
end

-- Curse area

G.FUNCS.crv_curse_area = function(e) -- fuck you
	if G.crv_curses.T.y == 0 then
		G.crv_curses.T.y = -5
		G.jokers.T.y = 0
	else
		G.crv_curses.T.y = 0
		G.jokers.T.y = -5
	end
end

G.FUNCS.crv_can_curse_area = function(e)
	if G.crv_curses then
		e.config.button = "crv_curse_area"
		if G.crv_curses.T.y == 0 then
			RevosVault.curse_text = localize("crv_jokers_button")
			e.config.colour = G.C.RED
		else
			RevosVault.curse_text = localize("crv_curses_button")
			e.config.colour = G.C.L_BLACK
		end
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

-- First time check for the ifno menu thingy
function RevosVault.ui_disbled(menu_type)
	if
		G.PROFILES[G.SETTINGS.profile]
		and G.PROFILES[G.SETTINGS.profile].first_time_disable
		and G.PROFILES[G.SETTINGS.profile].first_time_disable[menu_type]
	then
		return true
	end
	return false
end

-- collection ui for superiors

--TODO: steal smods consumable ui and allow this to have shit like pages / add tallies
G.FUNCS.general_superior_ui = function()
	RevosVault.av = {}
	G.FUNCS.crv_superior_custom_collection()

local t = create_UIBox_generic_options({
		back_func = "your_collection_consumables",
		colour = RevosVault.ui_config.colour,
		back_colour = RevosVault.ui_config.back_colour,
		contents = {
			{
				n = G.UIT.R,
				config = { align = "cm", r = 0.1, colour = G.C.BLACK },
				nodes = {
					{
						n = G.UIT.C,
						nodes = {
							
						},
					},
				},
			},
		},
	})
	local tablins = (t.nodes[1].nodes[1].nodes[1].nodes[1].nodes)

	for i = 1, #RevosVault.av do
		local lab = string.gsub(tostring(RevosVault.av[i]), "collection_button_", "")
		table.insert(
			tablins,
			UIBox_button({
				colour = RevosVault.C.SUP,
				button = RevosVault.av[i],
				label = { lab },
				minw = 4.5,
				focus_args = { snap_to = true },
			})
		)
		table.insert(
			tablins,
			{ n = G.UIT.R, config = { colour = G.C.CLEAR, scale = 0.1, padding = 0.1 } }
		)
	end
	return t
end

G.FUNCS.superior_crv_menu = function(e)
	RevosVault.easy_overlay(true, G.FUNCS.general_superior_ui())
end

G.FUNCS.crv_superior_custom_collection = function(e)
	for k, v in pairs(G.unique_superiors) do
		G.UIDEF["collection_ui_" .. k] = function()
			local deck_tables = {}
			local jokas = {}

			for kk, vv in pairs(G.P_CENTER_POOLS["Superior" .. k]) do
				if kk then
					jokas[#jokas + 1] = vv
				end
			end

			G.your_collection = {}
			for j = 1, 2 do
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
			for i = 1, math.ceil(#jokas / (5 * #G.your_collection)) do
				table.insert(
					joker_options,
					localize("k_page")
						.. " "
						.. tostring(i)
						.. "/"
						.. tostring(math.ceil(#jokas / (5 * #G.your_collection)))
				)
			end

			for i = 1, 5 do
				for j = 1, #G.your_collection do
					if jokas[i + (j - 1) * 5] then
						local center = jokas[i + (j - 1) * 5]
						local card = Card(
							G.your_collection[j].T.x + G.your_collection[j].T.w / 2,
							G.your_collection[j].T.y,
							G.CARD_W,
							G.CARD_H,
							nil,
							center
						)
						if RevosVault.negative_pdeck then
							-- yes
						end
						G.your_collection[j]:emplace(card)
					end
				end
			end

			local t = create_UIBox_generic_options({
				back_func = "superior_crv_menu",
				contents = {
					{
						n = G.UIT.R,
						config = { align = "cm", r = 0.1, colour = G.C.BLACK, emboss = 0.05 },
						nodes = deck_tables,
					},
					{
						n = G.UIT.R,
						config = { align = "cm" },
						nodes = {
							create_option_cycle({
								options = joker_options,
								w = 4.5,
								cycle_shoulders = true,
								opt_callback = "page_ui_" .. k,
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

		
		G.FUNCS["page_ui_" .. k]  = function(args)
			local jokas = {}

			for kk, vv in pairs(G.P_CENTER_POOLS["Superior" .. k]) do
				if kk then
					jokas[#jokas + 1] = vv
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
					local center =
						jokas[i + (j - 1) * 5 + (5 * #G.your_collection * (args.cycle_config.current_option - 1))]
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
				end
			end
		end

		G.FUNCS["collection_button_" .. k] = function()
			RevosVault.easy_overlay(false, G.UIDEF["collection_ui_" .. k]())
		end

		RevosVault.av = RevosVault.av or {}

		RevosVault.av[#RevosVault.av+1] = "collection_button_" .. k
	end
end
