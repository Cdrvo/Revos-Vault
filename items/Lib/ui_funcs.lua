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


-- idk if everything here is needed or not :(

G.FUNCS.crv_superior_custom_collection = function(e)
	for k, v in pairs(G.unique_superiors) do
		G.UIDEF["collection_ui_" .. k] = function()
			local deck_tables = {}
			local real_sup_table = {}
			for k, v in pairs(G.P_CENTER_POOLS["Superior"..k]) do
				if G.ACTIVE_MOD_UI and G.ACTIVE_MOD_UI.id then
					if v.mod.id == G.ACTIVE_MOD_UI.id then
						real_sup_table[#real_sup_table+1] = v
					end
				else
					real_sup_table[#real_sup_table+1] = v
				end
			end

			G.your_collection = {}
			for j = 1, 2 do
				G.your_collection[j] = CardArea(
					G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2,
					G.ROOM.T.h,
					(3.25 + j) * G.CARD_W,
					1 * G.CARD_H,
					{ card_limit = 3 + j, type = "title", highlight_limit = 0, collection = true }
				)
				table.insert(
					deck_tables,
					{
						n = G.UIT.R,
						config = { align = "cm", padding = 0, no_fill = true },
						nodes = {
							{ n = G.UIT.O, config = { object = G.your_collection[j] } },
						},
					}
				)
			end

			for j = 1, #G.your_collection do
				for i = 1, 3 + j do
					if real_sup_table[i + (j - 1) * 3 + j - 1] then
						local center = real_sup_table[i + (j - 1) * 3 + j - 1]

						local card = Card(
							G.your_collection[j].T.x + G.your_collection[j].T.w / 2,
							G.your_collection[j].T.y,
							G.CARD_W,
							G.CARD_H,
							nil,
							center
						)
						card:start_materialize(nil, i > 1 or j > 1)
						G.your_collection[j]:emplace(card)
					end
				end
			end

			local superior_options = {}
			for i = 1, math.ceil(#real_sup_table / 9) do
				table.insert(
					superior_options,
					localize("k_page")
						.. " "
						.. tostring(i)
						.. "/"
						.. tostring(math.ceil(#real_sup_table / 9))
				)
			end

			INIT_COLLECTION_CARD_ALERTS()

			local t = create_UIBox_generic_options({
				colour = G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_colour or (
					G.ACTIVE_MOD_UI.ui_config or {}
				).colour),
				bg_colour = G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_bg_colour or (
					G.ACTIVE_MOD_UI.ui_config or {}
				).bg_colour),
				back_colour = G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_back_colour or (
					G.ACTIVE_MOD_UI.ui_config or {}
				).back_colour),
				outline_colour = G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_outline_colour or (
					G.ACTIVE_MOD_UI.ui_config or {}
				).outline_colour),
				back_func = "your_collection_SUPERIORSCRV",
				contents = {
					{
						n = G.UIT.R,
						config = { align = "cm", minw = 2.5, padding = 0.1, r = 0.1, colour = G.C.BLACK, emboss = 0.05 },
						nodes = deck_tables,
					},
					{
						n = G.UIT.R,
						config = { align = "cm", padding = 0 },
						nodes = {
							create_option_cycle({
								options = superior_options,
								w = 4.5,
								cycle_shoulders = true,
								opt_callback = "page_ui_" .. k,
								focus_args = { snap_to = true, nav = "wide" },
								current_option = 1,
								colour = G.C.RED,
								no_pips = true,
							}),
						},
					},
				},
			})
			return t
		end

		
		G.FUNCS["page_ui_" .. k]  = function(args)
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

			local real_sup_table = {}
			for k, v in pairs(G.P_CENTER_POOLS["Superior"..k]) do
				if G.ACTIVE_MOD_UI and G.ACTIVE_MOD_UI.id then
					if v.mod.id == G.ACTIVE_MOD_UI.id then
						real_sup_table[#real_sup_table+1] = v
					end
				else
					real_sup_table[#real_sup_table+1] = v
				end
			end

			for j = 1, #G.your_collection do
				for i = 1, 3 + j do
					local center =
						real_sup_table[i + (j - 1) * 4 + (9 * (args.cycle_config.current_option - 1))]
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
					card:start_materialize(nil, i > 1 or j > 1)
					G.your_collection[j]:emplace(card)
				end
			end
			INIT_COLLECTION_CARD_ALERTS()
		end

		G.FUNCS["collection_button_" .. k] = function()
			RevosVault.easy_overlay(false, G.UIDEF["collection_ui_" .. k]())
		end

		RevosVault.av = RevosVault.av or {}

		RevosVault.av[#RevosVault.av+1] = "collection_button_" .. k
	end
end

G.FUNCS.your_collection_SUPERIORSCRV = function(e)
    G.SETTINGS.paused = true
    G.FUNCS.overlay_menu{
      definition = create_UIBox_your_collection_SUPERIORSCRV(),
    }
end


function create_UIBox_your_collection_SUPERIORSCRV()
    local t = create_UIBox_generic_options({
		colour = G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_colour or (
			G.ACTIVE_MOD_UI.ui_config or {}
		).colour),
		bg_colour = G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_bg_colour or (
			G.ACTIVE_MOD_UI.ui_config or {}
		).bg_colour),
		back_colour = G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_back_colour or (
			G.ACTIVE_MOD_UI.ui_config or {}
		).back_colour),
		outline_colour = G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_outline_colour or (
			G.ACTIVE_MOD_UI.ui_config or {}
		).outline_colour),
        --outline_colour = darken(G.C.WHITE, 0.2),
        back_func = 'your_collection_consumables', 
        contents = {
        { n = G.UIT.C, config = { align = 'cm', minw = 11.5, minh = 6 }, nodes = {
            { n = G.UIT.O, config = { id = 'SUPERIORCRV_collection', object = Moveable() },}
        }},
    }})
    G.E_MANAGER:add_event(Event({func = function()
        G.FUNCS.your_collection_SUPERIORSCRV_page({ cycle_config = { current_option = 1 }})
        return true
    end}))
    return t
end

G.FUNCS.your_collection_SUPERIORSCRV_page = function(args)
    if not args or not args.cycle_config then return end
  if G.OVERLAY_MENU then
    local uie = G.OVERLAY_MENU:get_UIE_by_ID('SUPERIORCRV_collection')
    if uie then
      if uie.config.object then
        uie.config.object:remove()
      end
      uie.config.object = UIBox{
        definition =  G.UIDEF.SUPERIORCRV_collection_page(args.cycle_config.current_option),
        config = { align = 'cm', parent = uie}
      }
    end
  end
end

G.UIDEF.SUPERIORCRV_collection_page = function(page)
    G.FUNCS.crv_superior_custom_collection()
    local nodes_per_page = 10
    local page_offset = nodes_per_page * ((page or 1) - 1)
    local type_buf = {}
    if G.ACTIVE_MOD_UI then
        for _, v in pairs(G.unique_superiors) do
            if modsCollectionTally(G.P_CENTER_POOLS["Superior" .. _]).of > 0 then type_buf[#type_buf + 1] = "Superior" .. _ end
        end
    else
		for _, v in pairs(G.unique_superiors) do
			type_buf[#type_buf + 1] = "Superior" .. _
		end
	end
    local center_options = {}
    for i = 1, math.ceil(#type_buf / nodes_per_page) do
        table.insert(center_options,
            localize('k_page') ..
            ' ' .. tostring(i) .. '/' .. tostring(math.ceil(#type_buf / nodes_per_page)))
    end
    local option_nodes = { create_option_cycle({
        options = center_options,
        w = 4.5,
        cycle_shoulders = true,
        opt_callback = 'your_collection_SUPERIORSCRV_page',
        focus_args = { snap_to = true, nav = 'wide' },
        current_option = page or 1,
        colour =  G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_option_cycle_colour or (
			G.ACTIVE_MOD_UI.ui_config or {}
		).collection_option_cycle_colour),
        no_pips = true
    }) }
    local function create_SUPERIORCRV_nodes(_start, _end)
        local t = {}
        for i = _start, _end do
            local key = type_buf[i]
            if not key then
                if i == _start then break end
                t[#t+1] = { n = G.UIT.R, config = { align ='cm', minh = 0.81 }, nodes = {}}
            else
                local id = 'collection_button_'.. string.gsub(key, "Superior", "")
                t[#t+1] = UIBox_button({button = id, label = {localize('b_'..key:lower()..'_cards')}, count = G.ACTIVE_MOD_UI and modsCollectionTally(G.P_CENTER_POOLS[key]) or RevosVault.get_discover_tally(key), minw = 4, id = id, colour = RevosVault.C.SUP, text_colour = G.C.WHITE})
            end
        end
        return t
    end

    local t = { n = G.UIT.C, config = { align = 'cm' }, nodes = {
        {n=G.UIT.R, config = {align="cm"}, nodes = {
            {n=G.UIT.C, config={align = "tm", padding = 0.15}, nodes= create_SUPERIORCRV_nodes(page_offset + 1, page_offset + math.ceil(nodes_per_page/2))},
            {n=G.UIT.C, config={align = "tm", padding = 0.15}, nodes= create_SUPERIORCRV_nodes(page_offset+1+math.ceil(nodes_per_page/2), page_offset + nodes_per_page)},
        }},
        {n=G.UIT.R, config = {align="cm"}, nodes = option_nodes},
    }}
    return t
end

function RevosVault.get_discover_tally(pool)
	local count = {
		of = 0,
		tally = 0
	}
	for k, v in pairs(G.P_CENTER_POOLS[pool]) do
		if not v.no_collection then
			count.of = count.of + 1
			if v.discovered then
				count.tally = count.tally + 1
			end
		end
	end
	return count
end

G.UIDEF.crv_blessing_overlay = function()
		G.boon_shop = CardArea(
      0,
      0,
      math.min((G.GAME.crv_boon_limit or 3)*1.02*G.CARD_W,4.08*G.CARD_W),
      1.05*G.CARD_H, 
      {card_limit = G.GAME.crv_boon_limit or 3, type = 'shop', highlight_limit = 1, negative_info = true})
	local t = create_UIBox_generic_options({
		back_func = "exit_crv_boons",
		contents = {
			{
				n = G.UIT.R,
				config = { align = "cm", r = 0.1, colour = G.C.CLEAR, padding = 0.1 },
				nodes = {
					{
						n = G.UIT.O,
						config = {
							object = DynaText({
								string = {  "BOONS" },
								colours = { G.C.EDITION },
								shadow = true,
								float = true,
								spacing = 0.3,
								rotate = true,
								scale = 1.4,
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
					{ n = G.UIT.O, config = { object = G.boon_shop} },
				},
			},
		},
	})
	return t
end

G.FUNCS.crv_boon_menu = function(e)
	RevosVault.easy_overlay(false, G.UIDEF.crv_blessing_overlay())
	for i = 1, (G.GAME.crv_boon_limit or 3) do
		local boon = SMODS.create_card{
			set = "crv_boons",
			area = G.boon_shop
		}
		G.boon_shop:emplace(boon)
	end
end

G.FUNCS.exit_crv_boons = function(e)
	G.boon_shop:remove()
	G.boon_shop = nil
	G.FUNCS.exit_overlay_menu()
	save_run()
	G.GAME.crv_boon_was_picked = true
end

G.FUNCS.crv_boon_menu_func = function(e)
	if not G.GAME.crv_boon_was_picked then
		e.config.colour = G.C.IMPORTANT
		e.config.button = "crv_boon_menu"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
	end
end


G.FUNCS.crv_accept_blessing = function(e)
	local boon = e.config.ref_table
	SMODS.add_card{
		key = boon.config.center.key,
		area = G.consumeables
	}
	G.FUNCS.exit_crv_boons()

	--if 
end