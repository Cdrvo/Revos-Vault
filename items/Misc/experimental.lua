function RevosVault.back_to_death(load, save, force_save) --dumbass name
	if G.STATE ~= G.STATES.CRV_DEATHCARD then
		G.STATE = G.STATES.CRV_DEATHCARD
		ease_background_colour({ new_colour = HEX("964B00"), special_colour = G.C.BLACK })
	end
	if not G.deathcard or not G.deathcard_chose then
		for k, v in pairs(G) do
			if type(v) == "table" and v.states and v.states.visible and k ~= "SPLASH_BACK" and k ~= "deathcard" and k ~= "deathcard_chose" then
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

			RevosVault.deathcarded = false

			ease_background_colour({ new_colour = HEX("964B00"), special_colour = G.C.BLACK })

			if G.load_deathcard then
				G.deathcard:load(G.load_deathcard)
			end

			G.load_deathcard = nil
			G.load_deathcard_chose = nil
		end

		if #G.deathcard.cards == 0 then
			SMODS.add_card({ key = "j_crv_placeholder_death", area = G.deathcard })
		end

		if G.deathcard.cards and G.deathcard.cards[1] then
			G.deathcard.cards[1].no_ui = true
		end
	end

	if not G.GAME.crv_deathcard_state then
		G.GAME.crv_deathcard_state = "ability"
	end

	if G.GAME.crv_deathcard_state and not RevosVault.deathcarded then
		if #G.jokers.cards<2 then
			for i = 1, (2-#G.jokers.cards)+1 do
				SMODS.add_card{
					key = "j_joker",
					area = G.jokers
				}
			end
		end
		local function quicky()
			local tab = {}
				for k, v in pairs(G.jokers.cards) do
					tab[#tab+1] = v
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

		if (save and not RevosVault.save_not_saved ) or (force_save1) then
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
		a = a  + 1
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
				print(v.occupied_card, k2)
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
			rtab[#rtab+1] = k
		end
	end

	local a = pseudorandom_element(rtab, pseudoseed("fuckyou"))

	return a
end

