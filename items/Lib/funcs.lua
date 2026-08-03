RVF = RevosVault.FUNCS

RVF.do_event = function(func, queue, trigger, delay)
	G.E_MANAGER:add_event(Event({
		trigger = trigger or "after",
		delay = delay or 0.1,
		func = func,
	}, queue))
end

RVF.cool_enhance = function(card, stuff, no_flip, no_juice, no_sound, queue)
	RVF.do_event(function()
		--[[if not no_juice then
                card:juice_up()
            end]]
		if not no_flip then
			card:flip()
		end
		if not no_sound then
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
			play_sound("card1")
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

function RVF.msg(card, message)
    card_eval_status_text(card, "extra", nil, nil, nil, { message = message })
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
	RVF.spamton_setup()
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


-- referenced from Spiked Ball from Smallpox

function RevosVault.FUNCS.spamton_setup()
	MiniSpamton_table = {}
	MiniSpamton_table.window_width, MiniSpamton_table.window_height = love.window.getMode()
	MiniSpamton_table.active = false
	RevosVault.FUNCS.convert_pixels = function(val, reverse)
		if reverse then
			return val * (G.TILESCALE*G.TILESIZE)
		end
		return val / (G.TILESCALE*G.TILESIZE)
	end
	MiniSpamton_table.window_width = RevosVault.FUNCS.convert_pixels(MiniSpamton_table.window_width)
	MiniSpamton_table.window_height = RevosVault.FUNCS.convert_pixels(MiniSpamton_table.window_height)
end
RevosVault.FUNCS.spamton_setup()

RevosVault.FUNCS.summon_mini_spamton = function()
	G.GAME.crv_spamton_help = true
	MiniSpamton_table.active = true
end

RevosVault.FUNCS.leave_mini_spamton = function()
	G.GAME.crv_spamton_help = false
end
--


RevosVault.FUNCS.has_room = function(area, extra, num)
	if not num then
    	return #area.cards < area.config.card_limit+(extra or 0)
	else
		return (area.config.card_limit+(extra or 0) ) - #area.cards
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
	add_tag(Tag(tag))
	if not silent then play_sound('generic1') end
end