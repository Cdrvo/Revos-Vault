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
    changed = false -- idk
}

if not RevoConfig["6_vault_enabled"] then
    TheVault.current_vault_text = "Reroll"
    TheVault.changed = true
    TheVault.vault_cost = 30
    TheVault.vault_cost_default = 30
end

local can_reroll_old = G.FUNCS.can_reroll
function G.FUNCS.can_reroll(e)
	if TheVault.in_vault then
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	else
		can_reroll_old(e)
	end
end

G.FUNCS.can_enter_vault = function(e)
	e.config.colour = G.C.PURPLE
	e.config.button = "enter_vault"
end

G.FUNCS.enter_vault = function(e)
	if G.vault then
		G.vault:remove()
		G.vault = nil
	end
	G.vault = UIBox({
		definition = G.UIDEF.vault(),
		config = { align = "tmi", offset = { x = 0, y = G.ROOM.T.y + 11 }, major = G.hand, bond = "Weak" },
	})

	if G.load_vault_card then
		nosave_vault = true
		G.vault_card:load(G.load_vault_card)
		G.load_vault_card = nil
	end

	RevosVault.s_to_v()

	G.E_MANAGER:add_event(Event({
		func = function()
			save_run()
			return true
		end,
	}))
end

local toggle_shop_old = G.FUNCS.toggle_shop
function G.FUNCS.toggle_shop(e)
	toggle_shop_old(e)
	if G.vault then
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.5,
			func = function()
				G.vault:remove()
				G.vault = nil
				return true
			end,
		}))
	end
end

function Card:is_vaultable()
	for k, v in pairs(G.P_JOKER_RARITY_POOLS["crv_va"]) do
		if type(v.from) == "table" then
			for kk, vv in pairs(v.from) do
				if self.config.center.key == vv then
					return true
				end
			end
		else
			if self.config.center.key == v.from then
				return true
			end
		end
	end
	return false
end

function Card:crv_is_upgradeable()
	local tab = RevosVault.modify_rarity()
	local match = nil

	for k, v in pairs(tab) do
		if v == self.config.center.rarity then
			match = true
		end
	end

	if self.config.center.rarity == tab[#tab] then
		return false
	end
	
	if match then
		return true
	end
end

function RevosVault.vaultify(card, no_juice, ret)
	for k, v in pairs(G.P_JOKER_RARITY_POOLS["crv_va"]) do
		if type(v.from) == "table" then
			for kk, vv in pairs(v.from) do
				if card.config.center.key == vv then
					if ret then
						return v.key
					end
					card:set_ability(v.key)
					if not no_juice then
						card:juice_up()
					end
					return true
				end
			end
		else
			if card.config.center.key == v.from then
				if ret then
					return v.key
				end
				card:set_ability(v.key)
				if not no_juice then
					card:juice_up()
				end
				return true
			end
		end
	end
end

G.FUNCS.take_me_back = function(e)
	if G.vault_card and G.vault_card.cards then
		local vcard = nil
		local turn_back = true

		if G.vault_card.cards[1] then
			vcard = G.vault_card.cards[1]
		end

		if
			(G.jokers and G.jokers.cards and #G.jokers.cards < G.jokers.config.card_limit and vcard)
			or (vcard and vcard.edition and vcard.edition.negative)
		then
			RevosVault.move_card(vcard, G.jokers)
		elseif vcard and G.jokers then
			alert_no_space(vcard, G.jokers)
			turn_back = false
		end

		if turn_back then
			RevosVault.v_to_s()
			G.E_MANAGER:add_event(Event({
				func = function()
					save_run()
					return true
				end,
			}))
		else
			turn_back = true
		end
	end
end

G.FUNCS.crv_vault_help = function(e)
	G.PROFILES[G.SETTINGS.profile].crv_no_vault_help = true
	if TheVault.changed then
		G.FUNCS.RevosVault_info{menu_type = "crv_thevault_alt", no_first_time = true}
	else
		G.FUNCS.RevosVault_info{menu_type = "crv_thevault", no_first_time = true}
	end
end

G.FUNCS.crv_vault_help_can = function(e)
	if not (not TheVault.vault_lock) then
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	else
		e.config.colour = ( not G.PROFILES[G.SETTINGS.profile].crv_no_vault_help and SMODS.Gradients["crv_important"] ) or G.C.L_BLACK
		e.config.button = "crv_vault_help"
	end
end

G.FUNCS.crv_vault_vault_can = function(e)
    if not TheVault.changed then
        if
            not (
                G.vault_card
                and G.vault_card.cards
                and G.vault_card.cards[1]
                and G.vault_card.cards[1]:is_vaultable()
                and G.GAME.crv_souls
                and (G.GAME.crv_souls >= TheVault.vault_cost)	
    			and not TheVault.vault_lock
				and not G.CONTROLLER.locked
				and not G.vault_card.cards[1].crv_harvested
            )
        then
            e.config.colour = G.C.UI.BACKGROUND_INACTIVE
            e.config.button = nil
        else
            e.config.colour = G.C.PURPLE
            e.config.button = "crv_vault_vault"
        end
    else
        if
            not (
                G.vault_card
                and G.vault_card.cards
                and G.vault_card.cards[1]
                and G.GAME.crv_souls
                and (G.GAME.crv_souls >= TheVault.vault_cost)
            )
        then
            e.config.colour = G.C.UI.BACKGROUND_INACTIVE
            e.config.button = nil
        else
            e.config.colour = G.C.PURPLE
            e.config.button = "crv_vault_vault"
        end
    end
end

G.FUNCS.crv_vault_vault = function(e)

	G.E_MANAGER:add_event(Event({
		trigger = "before",
		delay = 0,
		func = function()
			TheVault.vault_lock = true
			G.CONTROLLER.locks["vault_lock"] = true
			return true
		end
	}))

    if not TheVault.changed then
		
        RevosVault.ease_souls(-TheVault.vault_cost)

        local vault_ver = RevosVault.vaultify(G.vault_card.cards[1], true, true)
		RevosVault.set_ability({card = G.vault_card.cards[1], sound = "gong", effect_table = {center = vault_ver}, second_func = function()
			TheVault.vault_lock = false
			G.CONTROLLER.locks["vault_lock"] = false
		end})
        play_sound("coin1")
    else
		
       	RevosVault.ease_souls(-TheVault.vault_cost)
        play_sound("coin1")

        RevosVault.replace_joker(G.vault_card.cards[1].area["cards"], nil, G.vault_card.cards[1].config.center.rarity, G.vault_card.cards[1].ability.set, nil)

		G.E_MANAGER:add_event(Event({
			trigger = "before",
			delay = 0,
			func = function()
				TheVault.vault_lock = false
				G.CONTROLLER.locks["vault_lock"] = false
				return true
			end
		}))
    end
end

G.FUNCS.crv_vault_enhance_can = function(e)
	if
		not (
			G.vault_card
			and G.vault_card.cards
			and G.vault_card.cards[1]
			and G.GAME.crv_souls
			and (G.GAME.crv_souls >= TheVault.enhance_cost)
			and not TheVault.vault_lock
			and not G.CONTROLLER.locked
			and not G.vault_card.cards[1].crv_harvested
		)
	then
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	else
		e.config.colour = G.C.DARK_EDITION
		e.config.button = "crv_vault_enhance"
	end
end

G.FUNCS.crv_vault_enhance = function(e)
	G.E_MANAGER:add_event(Event({
		trigger = "before",
		delay = 0,
		func = function()
			TheVault.vault_lock = true
			return true
		end
	}))
	RevosVault.ease_souls(-TheVault.enhance_cost)

	local edition = poll_edition(nil, nil, true, true)
	G.vault_card.cards[1]:set_edition(edition)
	play_sound("coin1")
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 0,
		func = function()
			TheVault.vault_lock = false
			save_run()
			return true
		end,
	}))
end

G.FUNCS.crv_vault_upgrade_can = function(e)
	if
		not (
			G.vault_card
			and G.vault_card.cards
			and G.vault_card.cards[1]
			and G.vault_card.cards[1]:crv_is_upgradeable()
			and G.GAME.crv_souls
			and (G.GAME.crv_souls >= TheVault.upgrade_cost)
			and not TheVault.vault_lock
			and not G.CONTROLLER.locked
			and not G.vault_card.cards[1].crv_harvested
		)
	then
		TheVault.upgrade_cost = TheVault.upgrade_cost_default
		if G.vault_card.cards[1] then
			if G.vault_card.cards[1].config.center.rarity == 4 then
				TheVault.upgrade_cost = TheVault.upgrade_cost+((RevosVault.modify_rarity(G.vault_card.cards[1], 1, true)/4)+15) -- FUCK EXOTICS, LEGENDARIES 'TILL THE END!
			else
				TheVault.upgrade_cost = TheVault.upgrade_cost+((RevosVault.modify_rarity(G.vault_card.cards[1], 1, true)/4)-5)
			end
		end
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	else

		TheVault.upgrade_cost = TheVault.upgrade_cost_default
		if G.vault_card.cards[1].config.center.rarity == 4 then
			TheVault.upgrade_cost = TheVault.upgrade_cost+((RevosVault.modify_rarity(G.vault_card.cards[1], 1, true)/4)+15) -- lazy 
		else
			TheVault.upgrade_cost = TheVault.upgrade_cost+((RevosVault.modify_rarity(G.vault_card.cards[1], 1, true)/4)-5)	
		end

		e.config.colour = G.C.RED
		e.config.button = "crv_vault_upgrade"
	end
end

G.FUNCS.crv_vault_upgrade = function(e)
	G.E_MANAGER:add_event(Event({
		trigger = "before",
		delay = 0,
		func = function()
			TheVault.vault_lock = true
			G.CONTROLLER.locks["vault_lock"] = true
			return true
		end
	}))

	RevosVault.ease_souls(-TheVault.upgrade_cost)

	local new_key = RevosVault.modify_rarity(G.vault_card.cards[1], 1, nil, nil, true)
	RevosVault.set_ability({card = G.vault_card.cards[1], sound = nil, effect_table = {center = new_key}, second_func = function()
			TheVault.vault_lock = false
			G.CONTROLLER.locks["vault_lock"] = false
			save_run()
		end})
	play_sound("coin1")
end

G.FUNCS.crv_vault_harvest_can = function(e)
	if
		not (
			G.vault_card
			and G.vault_card.cards
			and G.vault_card.cards[1]
			and G.GAME.crv_souls
			and G.vault_card.cards[1].sell_cost
			and not SMODS.is_eternal(G.vault_card.cards[1])
			and not TheVault.vault_lock
			and not G.CONTROLLER.locked
			and not G.vault_card.cards[1].crv_harvested
		)
	then
		TheVault.harvest_cost = TheVault.harvest_cost_default
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	else
		if G.GAME.modifiers.fifty_soul_increase then
			TheVault.harvest_cost_extra = TheVault.harvest_cost_extra_default
			TheVault.harvest_cost_extra = TheVault.harvest_cost_extra + RevosVault.perc(G.vault_card.cards[1].sell_cost, 50)
		end
		TheVault.harvest_cost = (G.vault_card.cards[1].sell_cost + TheVault.harvest_cost_extra )
		e.config.colour = G.C.BLUE
		e.config.button = "crv_vault_harvest"
	end
end

G.FUNCS.crv_vault_harvest = function(e)
	G.E_MANAGER:add_event(Event({
		trigger = "before",
		delay = 0,
		func = function()
			TheVault.vault_lock = true
			return true
		end
	}))

	RevosVault.ease_souls((G.vault_card.cards[1].sell_cost + TheVault.harvest_cost_extra ))
	
	SMODS.calculate_context({crv_harvest = true, other_card = G.vault_card.cards[1], harvested_for = (G.vault_card.cards[1].sell_cost + TheVault.harvest_cost_extra)})

	if next(SMODS.find_card("j_crv_keymaster")) and pseudorandom("yesyeyes")<1/4 then
		RevosVault.c_message(G.vault_card.cards[1], "Kept!")
	else
		G.vault_card.cards[1].crv_harvested = true
		SMODS.destroy_cards(G.vault_card.cards[1])
	end

	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 0,
		func = function()
			TheVault.vault_lock = false
			save_run()
			return true
		end,
	}))
end

function RevosVault.v_to_s(no_shop)
    ease_background_colour_blind(G.STATES.SHOP)
	if not no_shop then
		TheVault.in_vault = false
	end

	if G.shop and G.shop.alignment.offset.py and not no_shop then
		G.shop.alignment.offset.y = G.shop.alignment.offset.py
		G.shop.alignment.offset.py = nil
	end
	if G.vault then
		G.vault.alignment.offset.y = G.ROOM.T.y + 29
	end
end

function RevosVault.s_to_v(no_shop)
    ease_background_colour({new_colour = darken(G.C.PURPLE, 0.3), special_colour = G.C.BLACK})
	if not no_shop then
		TheVault.in_vault = true
	end

	if G.shop and not G.shop.alignment.offset.py then
		G.shop.alignment.offset.py = G.shop.alignment.offset.y
		if not no_shop then
			G.shop.alignment.offset.y = G.ROOM.T.y + 29
		end
	end
	if G.vault and G.shop.alignment.offset.py then
		G.vault.alignment.offset.y = G.shop.alignment.offset.py
	end
end

function RevosVault.resetv()
	G.vault:remove()
	G.vault = nil
	G.vault = G.vault
		or UIBox({
			definition = G.UIDEF.vault(),
			config = { align = "tmi", offset = { x = 0, y = G.ROOM.T.y + 11 }, major = G.hand, bond = "Weak" },
		})
end

G.FUNCS.get_vaultable_list = function(e)
	G.FUNCS.overlay_menu({
		definition = G.UIDEF.vaultable_jokers(),
	})
end

G.UIDEF.vaultable_jokers = function(e)

  local deck_tables = {}
  local jokas = {}

  for k, v in pairs(RevosVault.get_unvaulted_vaultables()) do
	jokas[#jokas+1] = G.P_CENTERS[v]
  end

  G.your_collection = {}
  for j = 1, 3 do
    G.your_collection[j] = CardArea(
      G.ROOM.T.x + 0.2*G.ROOM.T.w/2,G.ROOM.T.h,
      5*G.CARD_W,
      0.95*G.CARD_H, 
      {card_limit = 5, type = 'title', highlight_limit = 0, collection = true})
    table.insert(deck_tables, 
    {n=G.UIT.R, config={align = "cm", padding = 0.07, no_fill = true}, nodes={
      {n=G.UIT.O, config={object = G.your_collection[j]}}
    }}
    )
  end

  local joker_options = {}
  for i = 1, math.ceil(#jokas/(5*#G.your_collection)) do
    table.insert(joker_options, localize('k_page')..' '..tostring(i)..'/'..tostring(math.ceil(#jokas/(5*#G.your_collection))))
  end

  for i = 1, 5 do
    for j = 1, #G.your_collection do
      local center = jokas[i+(j-1)*5]
      local card = Card(G.your_collection[j].T.x + G.your_collection[j].T.w/2, G.your_collection[j].T.y, G.CARD_W, G.CARD_H, nil, center)
	  if RevosVault.negative_pdeck then
		-- yes
	  end
      G.your_collection[j]:emplace(card)
    end
  end

  INIT_COLLECTION_CARD_ALERTS()
  
  local t =  create_UIBox_generic_options({ back_func = 'leave_deck_menu', contents = {
        {n=G.UIT.R, config={align = "cm", r = 0.1, colour = G.C.BLACK, emboss = 0.05}, nodes=deck_tables}, 
        {n=G.UIT.R, config={align = "cm"}, nodes={
          create_option_cycle({options = joker_options, w = 4.5, cycle_shoulders = true, opt_callback = 'your_collecion_vaultable_list', current_option = 1, colour = G.C.RED, no_pips = true, focus_args = {snap_to = true, nav = 'wide'}})
        }},
    }})
  return t
end

G.FUNCS.your_collecion_vaultable_list = function(args)
  local jokas = {}

  for k, v in pairs(RevosVault.get_unvaulted_vaultables()) do
	jokas[#jokas+1] = G.P_CENTERS[v]
  end



  if not args or not args.cycle_config then return end
  for j = 1, #G.your_collection do
    for i = #G.your_collection[j].cards,1, -1 do
      local c = G.your_collection[j]:remove_card(G.your_collection[j].cards[i])
      c:remove()
      c = nil
    end
  end
  for i = 1, 5 do
    for j = 1, #G.your_collection do
      local center = jokas[i+(j-1)*5 + (5*#G.your_collection*(args.cycle_config.current_option - 1))]
      if not center then break end
      local card = Card(G.your_collection[j].T.x + G.your_collection[j].T.w/2, G.your_collection[j].T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, center)
      
      G.your_collection[j]:emplace(card)

    end
  end
end