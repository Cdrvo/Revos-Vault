RVF = RevosVault.FUNCS

RVF.do_event = function(func, queue, trigger, delay)
	G.E_MANAGER:add_event(Event({
		trigger = trigger or "after",
		delay = delay or 0.1,
		func = func,
	}, queue))
end

RVF.cool_enhance = function(card, stuff, no_flip, no_juice, no_sound, shatter, queue) -- I AM HARDCODING IT AAAAAAAAAAAAAAA
	RVF.do_event(function()
		--[[if not no_juice then
                card:juice_up()
            end]]
		if not no_flip then
			card:flip()
		end
		if not no_sound and not shatter then
			play_sound("card1")
		end
		return true
	end, queue, nil, 0)

	local func
	if type(stuff) == "function" then
		func = stuff
	else
		func = function()
			card:set_ability(G.P_CENTERS[stuff])
		end
	end
	RVF.do_event(function()
		func()
		return true
	end, queue, after, 1)
	RVF.do_event(function()
		if not no_juice then
			card:juice_up()
		end
		if not no_flip then
			card:flip()
		end
		if not no_sound then
			if shatter then
				play_sound("glass" .. math.random(1, 6), math.random() * 0.2 + 0.9, 0.5)
				play_sound("generic1", math.random() * 0.2 + 0.9, 0.5)
			else
				play_sound("card1")
			end
		end
		return true
	end, queue)
end

function RVF.card_position(card, area)
	if not card then
		return
	end
	area = area or card.area

	local ret = {
		pos = nil,
		inbetween = false,
		right = false,
		left = false,
	}
	for i = 1, #area.cards do
		if area.cards[i] == card then
			ret.pos = i
		end
	end

	local rr = ret.pos
	if area.cards[rr + 1] and area.cards[rr - 1] then
		ret.inbetween = true
		ret.right = true
		ret.left = true
	end
	if area.cards[rr + 1] then
		ret.right = true
	end
	if area.cards[rr - 1] then
		ret.left = true
	end
	return ret
end

function RVF.msg(card, message, type, other)
	card_eval_status_text(card, type or "extra", other, nil, nil, { message = message })
end

G.FUNCS.crv_use_joker = function(e)
	local card = e.config.ref_table
	card.config.center.crv_use(card.config.center, card)
end

G.FUNCS.can_crv_use_joker = function(e)
	local card = e.config.ref_table
	if card.config.center.crv_can_use(card.config.center, card) then
		e.config.colour = G.C.RED
		e.config.button = "crv_use_joker"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

RevosVault.FUNCS.swoon = function()
	RVF.do_event(function()
		G.crv_swooned = 60 * G.SETTINGS.GAMESPEED -- maybe a lil inspo from hot potato
		return true
	end)
	RVF.do_event(function()
		play_sound("crv_swoon")
		for k, v in pairs(G.jokers.cards) do
			if not v.debuff then
				SMODS.debuff_card(v, true, "crv_swooned")
			end
		end
		return true
	end)
end

RevosVault.FUNCS.has_room = function(area, extra, num)
	if not num then
		return #area.cards < area.config.card_limit + (extra or 0)
	else
		return (area.config.card_limit + (extra or 0)) - #area.cards
	end
end
--

--[[
RevosVault.FUNCS.nat = function()
	local a = {}
	for k, v in pairs(G.P_CENTER_POOLS.Joker) do
		if v and v.mod and v.mod.id == "RevosVault" and not v.attributes then
			a[v.key] = true
		end
	end
	return a
end
--]]

RevosVault.FUNCS.add_tag = function(tag, silent)
	local ret = Tag(tag)
	add_tag(Tag(tag))
	if not silent then
		play_sound("generic1")
	end
	return ret
end

function RevosVault.FUNCS.find_enhancement(check, compare) --idk
	local ret = false
	if not compare or (compare and type(compare) ~= "table") then
		for k, v in pairs(G.playing_cards) do
			if SMODS.has_enhancement(v, check) then
				ret = true
			end
		end
	else
		local num, op, truenum = compare.number, compare.operation, 0
		for k, v in pairs(G.playing_cards) do
			if SMODS.has_enhancement(v, check) then
				truenum = truenum + 1
			end
		end
		if op == "more" and truenum >= num then
			ret = true
		elseif op == "less" and truenum <= num then
			ret = true
		elseif op == "exact" and truenum == num then
			ret = true
		end
	end
	return ret
end

function RevosVault.FUNCS.highlight(area, amount)
	if not area then
		return
	end
	if area and area.highlighted then
		if #area.highlighted > (amount or 0) then
			return true, area.highlighted
		end
	end
end

function RevosVault.FUNCS.has_cartridge(card, cartridge)
	if card and card.ability and card.ability.crv_cartridges then
		if card.ability.crv_cartridges[cartridge] then
			return true
		end
	end
	return false
end

function RVF.redeem(card, free)
	local old_state = G.STATE
	G.GAME.crv_old_state = G.GAME.crv_old_state or {}
	if not G.GAME.crv_old_state.voucher_redeem then
		G.GAME.crv_old_state.voucher_redeem = G.STATE
	end

	if free then
		card.cost = 0
	end
	card:redeem()
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 1,
		func = function()
			if #G.play.cards <= 1 then
				G.STATE = G.GAME.crv_old_state.voucher_redeem or old_state
				G.GAME.crv_old_state.voucher_redeem = nil
			end
			card:start_dissolve()
			return true
		end,
	}))
end


function RVF.reset_suit_jokers(var)
    local all_suits = {}
    for k, v in pairs(SMODS.Suits) do
        if k ~= G.GAME.current_round[var] then all_suits[#all_suits + 1] = k end
    end
    local select = pseudorandom_element(all_suits, pseudoseed('anc'..G.GAME.round_resets.ante))
    G.GAME.current_round[var] = select
end

function RVF.nope(args)
	if not args.text then
		args.text = "k_nope_ex"
	end
	if args.instant then
		attention_text({
			text = localize(args.text),
			scale = args.scale or 1.3,
			hold = args.hold or 1.4,
			major = args.card,
			backdrop_colour = args.colour or G.C.SECONDARY_SET.Tarot,
			align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and "tm" or "cm",
			offset = {
				x = 0,
				y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0,
			},
			silent = true,
		})
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.06 * G.SETTINGS.GAMESPEED,
			blockable = false,
			blocking = false,
			func = function()
				play_sound("tarot2", 0.76, 0.4)
				return true
			end,
		}))
		play_sound("tarot2", 1, 0.4)
		args.card:juice_up(0.3, 0.5)
	else
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				attention_text({
					text = localize(args.text),
					scale = args.scale or 1.3,
					hold = args.hold or 1.4,
					major = args.card,
					backdrop_colour = args.colour or G.C.SECONDARY_SET.Tarot,
					align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and "tm" or "cm",
					offset = {
						x = 0,
						y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0,
					},
					silent = true,
				})
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.06 * G.SETTINGS.GAMESPEED,
					blockable = false,
					blocking = false,
					func = function()
						play_sound("tarot2", 0.76, 0.4)
						return true
					end,
				}))
				play_sound("tarot2", 1, 0.4)
				args.card:juice_up(0.3, 0.5)
				return true
			end,
		}))
	end
end

RevosVault.FUNCS.owned_enhancements = function(enhancement)
	local a, check = 0, (G.playing_cards or {})
	for k,v in pairs(check) do
		if v and SMODS.has_enhancement(v, enhancement) then
			a = a + 1
		end
	end
	return a
end

-- the special function

RVF.printer_create = function(card, make)
	local the_key, ccard, context = nil, nil, false

	if make.set == "Booster" then
		RVF.do_event(function()
			local key = make.key or pseudorandom_element(SMODS.get_clean_pool("Booster"), pseudoseed("revo_booster")) -- yes
			local _booster = Card(
				G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
				G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
				G.CARD_W * 1.27,
				G.CARD_H * 1.27,
				G.P_CARDS.empty,
				G.P_CENTERS[key],
				{ bypass_discovery_center = true, bypass_discovery_ui = true }
			)
			_booster.cost = 0
			G.FUNCS.use_card({ config = { ref_table = _booster } })
			_booster:start_materialize()
			return true
		end)
	elseif make.set == "Voucher" then
		ccard = SMODS.add_card({
			set = "Voucher",
			key = make.key,
			area = G.play,
		})
		RVF.redeem(ccard, true)
		context = true
	else
		make.area = make.area or G.jokers

		if
			make
			and (
				RVF.has_room(make.area)
				or RVF.has_cartridge(card, "c_crv_ghostly")
				or make.area == G.deck
				or make.area == G.hand
				or (make.edition and make.edition == "e_negative")
			)
		then
			if type(make) ~= "function" then
				ccard = SMODS.add_card({
					set = make.set,
					legendary = make.legendary,
					key = make.key,
					area = make.area,
					edition = make.edition,
					no_edition = not make.edition,
					force_stickers = make.stickers,
					rarity = make.rarity
				})
			else
				make()
			end
			context = true
		else
			RVF.msg(card, localize("k_no_room_ex"))
		end
	end

	if context and not make.no_context then
		SMODS.calculate_context({
			printer_trigger = true,
			printer = card,
			card_made = {
				key = make.key or ccard.config.center.key,
				center = ccard,
				set = make.set or ccard.ability.set,
			},
		})
	end

	return ccard
end

-- UI related functions

RevosVault.FUNCS.UI = {}

RVF.UI.move_area = function(area, move_to, back, reset)
	G.GAME.crv_old_area_locations = G.GAME.crv_old_area_locations or {}
	local ez = G.GAME.crv_old_area_locations

	if back then
		G[area].T.x = ez[area].x
		G[area].T.y = ez[area].y
		ez[area] = nil
	else
		if not ez[area] or reset then
			ez[area] = {
				x = G[area].T.x,
				y = G[area].T.y,
			}
		end

		G[area].T.x = (move_to.x or G[area].T.x)
		G[area].T.y = (move_to.y or G[area].T.y)
	end
end

