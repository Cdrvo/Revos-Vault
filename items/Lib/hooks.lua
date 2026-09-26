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
	if self.config.type == "joker" or self.config.type == "title" then
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
