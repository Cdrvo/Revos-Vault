local get_id_old = Card.get_id
function Card:get_id(...)
	if next(SMODS.find_card("j_crv_the_ace")) then
		return 14
	else
		return get_id_old(self, ...)
	end
end

local click_old = Card.click
function Card:click()
	local ret = click_old(self)
	if self.config.center.crv_clicked then
		self.config.center:crv_clicked(self)
	end
	return ret
end

local init_game_object_old = Game.init_game_object
Game.init_game_object = function(self)
	local igo = init_game_object_old(self)
	igo.crv_minispamton = {}
	igo.crv_spamton_help = true
	igo.crv_jimfinity = 0
	igo.crv_old_area_locations = {}

	igo.crv_fun = math.random(1, 500)
	return igo
end

local G_UIDEF_use_and_sell_buttons_old = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
	if card.area == G.jokers and card.config.center.crv_use then
		local sell = {
			n = G.UIT.C,
			config = { align = "cr" },
			nodes = {
				{
					n = G.UIT.C,
					config = {
						ref_table = card,
						align = "cr",
						padding = 0.1,
						r = 0.08,
						minw = 1.25,
						hover = true,
						shadow = true,
						colour = G.C.UI.BACKGROUND_INACTIVE,
						one_press = true,
						button = "sell_card",
						func = "can_sell_card",
						handy_insta_action = "sell",
					},
					nodes = {
						{ n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
						{
							n = G.UIT.C,
							config = { align = "tm" },
							nodes = {
								{
									n = G.UIT.R,
									config = { align = "cm", maxw = 1.25 },
									nodes = {
										{
											n = G.UIT.T,
											config = {
												text = localize("b_sell"),
												colour = G.C.UI.TEXT_LIGHT,
												scale = 0.4,
												shadow = true,
											},
										},
									},
								},
								{
									n = G.UIT.R,
									config = { align = "cm" },
									nodes = {
										{
											n = G.UIT.T,
											config = {
												text = localize("$"),
												colour = G.C.WHITE,
												scale = 0.4,
												shadow = true,
											},
										},
										{
											n = G.UIT.T,
											config = {
												ref_table = card,
												ref_value = "sell_cost_label",
												colour = G.C.WHITE,
												scale = 0.55,
												shadow = true,
											},
										},
									},
								},
							},
						},
					},
				},
			},
		}
		local use = {
			n = G.UIT.C,
			config = { align = "cr" },
			nodes = {
				{
					n = G.UIT.C,
					config = {
						ref_table = card,
						align = "cm",
						padding = 0.1,
						r = 0.08,
						minw = 1.25,
						minh = 0.8,
						hover = true,
						shadow = true,
						colour = G.C.UI.BACKGROUND_INACTIVE,
						button = "crv_use_joker",
						func = "can_crv_use_joker",
					},
					nodes = {
						{ n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
						{
							n = G.UIT.C,
							config = { align = "cm" },
							nodes = {
								{
									n = G.UIT.R,
									config = { align = "cm", maxw = 1.25 },
									nodes = {
										{
											n = G.UIT.T,
											config = {
												text = card.config.center.crv_use_button_text or localize("b_use"),
												colour = G.C.UI.TEXT_LIGHT,
												scale = 0.55,
												shadow = true,
											},
										},
									},
								},
							},
						},
					},
				},
			},
		}
		return {
			n = G.UIT.ROOT,
			config = { padding = 0, colour = G.C.CLEAR },
			nodes = {
				{
					n = G.UIT.C,
					config = { padding = 0.15, align = "cl" },
					nodes = {
						{ n = G.UIT.R, config = { align = "cl" }, nodes = {
							sell,
						} },
						{ n = G.UIT.R, config = { align = "cl" }, nodes = {
							use,
						} },
					},
				},
			},
		}
	end
	return G_UIDEF_use_and_sell_buttons_old(card)
end

local function newAnimation(image, width, height) --hmm
	local animation = {}
	animation.spriteSheet = image
	animation.quads = {}
	animation.width = width
	animation.height = height

	for y = 0, image:getHeight() - height, height do
		for x = 0, image:getWidth() - width, width do
			table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
		end
	end

	return animation
end
local love_draw_old = love.draw
function love.draw()
	love_draw_old()
	local _xscale = love.graphics.getWidth() / 1920
	local _yscale = love.graphics.getHeight() / 1080
	if G.crv_swooned and G.crv_swooned > 0 then
		local imgdata = NFS.newFileData(RevosVault.path .. "assets/Other/swoon.png")
		local img = love.image.newImageData(imgdata)
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.draw(
			assert(love.graphics.newImage(img)),
			0 * _xscale * 2,
			0 * _yscale * 2,
			0,
			_xscale * 2 * 2,
			_yscale * 2 * 2
		)
	end

	if MiniSpamton_table.active and MiniSpamton_table.the_thing then
		local mst, mx, my = MiniSpamton_table.the_thing, MiniSpamton_table.mouse_x, MiniSpamton_table.mouse_y
		mst.state = mst.state or 1

		local imgdata = NFS.newFileData(RevosVault.path .. "assets/Other/mini_spamton.png")
		local img = love.image.newImageData(imgdata)
		local real_img = love.graphics.newImage(img)

		local anim = newAnimation(real_img, 50, 50)

		if mst then
			love.graphics.setColor(1, 1, 1, 1)
			love.graphics.draw(
				anim.spriteSheet,
				anim.quads[mst.state],
				RVF.convert_pixels(mst.x, true),
				RVF.convert_pixels(mst.y, true),
				mst.scale_r,
				mst.scale_x,
				mst.scale_y
			)
		end
	end
end

local love_update_old = love.update
function love.update(dt)
	love_update_old(dt)
	if MiniSpamton_table.active and not G.SETTINGS.paused then
		if not next(SMODS.find_card("j_crv_spamton")) then
			RVF.spamton_setup()
		end

		G.GAME.crv_minispamton = MiniSpamton_table
		MiniSpamton_table.window_width, MiniSpamton_table.window_height = love.window.getMode()
		MiniSpamton_table.window_width = RVF.convert_pixels(MiniSpamton_table.window_width)
		MiniSpamton_table.window_height = RVF.convert_pixels(MiniSpamton_table.window_height)

		MiniSpamton_table.the_thing = MiniSpamton_table.the_thing or MiniSpamton()

		local thex, they = MiniSpamton_table.window_width, MiniSpamton_table.window_height
		local mst = MiniSpamton_table.the_thing

		if RevosVault.config.miniton_wander then --idk
			if mst.going_x == 0 then
				mst.going_x = math.random(1, thex)
			end
			if mst.going_y == 0 then
				mst.going_y = math.random(1, they)
			end
		else
			if not mst.starting_pos_set then
				mst.y = -4
				mst.x = G.deck.children.view_deck.T.x
				mst.going_x = mst.x
				mst.going_y = mst.y

				mst.starting_pos_set = true
			end
		end

		if math.ceil(mst.x) == mst.going_x and math.ceil(mst.y) == mst.going_y then
			mst.standing_still = true
		else
			mst.standing_still = false
		end

		if not MiniSpamton_table.manual_control then
			if mst.x < mst.going_x then
				mst.x = mst.x + (mst.speed * 2.5 * dt)
				if not mst.standing_still then
					mst.scale_x = -1
				end
			end
			if mst.x > mst.going_x then
				mst.x = mst.x - (mst.speed * 2.5 * dt)
				if not mst.standing_still then
					mst.scale_x = 1
				end
			end
			if mst.y < mst.going_y then
				mst.y = mst.y + (mst.speed * 2.5 * dt)
			end
			if mst.y > mst.going_y then
				mst.y = mst.y - (mst.speed * 2.5 * dt)
			end
		end

		if mst.state ~= 3 then
			mst.time_left = mst.time_left - 1
			if mst.time_left <= 0 then
				mst.time_left = 15
				if mst.state == 2 then
					mst.state = 1
				else
					mst.state = 2
				end
			end
		end

		if RevosVault.config.miniton_wander then
			if G.GAME.crv_spamton_help then
				mst.time_left_other = mst.time_left_other or 5
				mst.time_left_other = mst.time_left_other - dt
				if mst.time_left_other <= 0 then
					mst.time_left_other = 5
					mst.going_x = math.random(1, thex)
					mst.going_y = math.random(1, they)
				end

				local half = thex / 2
				if mst.standing_still then
					if mst.going_x > half then
						mst.scale_x = 1
					else
						mst.scale_x = -1
					end
				end
			end
		end
		if not G.GAME.crv_spamton_help then
			local ggg = G.deck.children.view_deck or { T = { x = 0, y = 0 } }
			local middle = { x = ggg.T.x, y = ggg.T.y }

			if not mst.leaving then
				mst.going_x = middle.x
				mst.going_y = middle.y
				mst.leaving = true
			end

			if
				((math.ceil(mst.x) == math.ceil(middle.x)) or (math.ceil(mst.x) == math.floor(middle.x)))
				and ((math.ceil(mst.y) == math.ceil(middle.y)) or (math.ceil(mst.y) == math.ceil(middle.y)))
				and mst.true_leaving
			then
				mst.state = 1
				mst.going_y = -5
			elseif
				(math.ceil(mst.x) == math.ceil(middle.x))
				and (math.ceil(mst.y) == math.ceil(middle.y))
				and not mst.timer_begun
			then
				mst.state = 3
				mst.timer_begun = 1.5
			end

			if mst.timer_begun then
				mst.timer_begun = mst.timer_begun - dt
				if mst.timer_begun <= 0 then
					mst.true_leaving = true
					play_sound("holo1")
					RVF.msg(G.deck.cards[1] or G.deck, localize("k_upgrade_ex"))
					for k, v in pairs(G.playing_cards) do
						SMODS.Stickers["crv_spamton_buff"]:apply(v, true)
					end
					mst.timer_begun = nil
				end
			end
		end

		if math.ceil(mst.y) == -5 then
			RevosVault.FUNCS.spamton_setup()
		end
	end
end

local update_old = Game.update
function Game:update(dt)
	update_old(self, dt)
	if G.crv_swooned and G.crv_swooned > 0 then
		G.crv_swooned = G.crv_swooned - 1
		if G.crv_swooned == 1 then
			SMODS.calculate_context({ crv_swoon_shake = true })
		end
	end
end

local start_run_old = Game.start_run
function Game:start_run(args)
	start_run_old(self, args)
	if G.jokers and G.jokers.cards then
		if next(SMODS.find_card("j_crv_spamton")) and G.GAME.crv_spamton_help then
			RVF.summon_mini_spamton()
		end
	end
end

local go_to_menu_old = G.FUNCS.go_to_menu
G.FUNCS.go_to_menu = function(e)
	go_to_menu_old(e)
	RevosVault.FUNCS.spamton_setup()
end

local sort_hand_value_old = G.FUNCS.sort_hand_value
function G.FUNCS.sort_hand_value(e)
	sort_hand_value_old(e)
	SMODS.calculate_context({ crv_sort_hand = true, crv_ranks = true })
end

local sort_hand_suit_old = G.FUNCS.sort_hand_suit
function G.FUNCS.sort_hand_suit(e)
	sort_hand_suit_old(e)
	SMODS.calculate_context({ crv_sort_hand = true, crv_suits = true })
end

local cardarea_align_cards_ref = CardArea.align_cards
function CardArea:align_cards()
	cardarea_align_cards_ref(self)
	if self.config.type == "joker" then
		local spin_value = 0.01
		for k, card in ipairs(self.cards) do
			if
				card
				and card.ability
				and (
					(RVF.has_cartridge(card, "c_crv_spin"))
					or card.ability.crv_force_spin
				)
			then
				if card.states.hover.is then
					spin_value = 0.05
				end
				if card.states.drag.is then
					spin_value = 0.05
				end
				card.T.r = card.T.r + spin_value*(G.GAME and G.GAME.crv_spin_mult or 1)
			end
		end
	end
end
