SMODS.ConsumableType({
	key = "crv_cartridge",
	collection_rows = { 5, 6 },
	primary_colour = G.C.WHITE,
	secondary_colour = G.C.BLACK,
	text_colour = G.C.WHITE,
})

local function fah(t)
	local a = 0
	for k, v in pairs(t) do
		a = a + 1
	end
	return a
end

RevosVault.Cartridge = SMODS.Consumable:extend({
	set = "crv_cartridge",
	crv_priority = 1,
	can_use = function(self, card)
		if RVF.highlight(G.jokers) then
			local _, cards = RVF.highlight(G.jokers)
			if
				#cards == 1
				and cards[1].config.center.attributes.printer
				and (
					not cards[1].ability.crv_cartridges
					or (
						cards[1].ability.crv_cartridges
						and (
							fah(cards[1].ability.crv_cartridges) > 0
							and not cards[1].ability.crv_cartridges[card.config.center.key]
						)
					)
				)
			then
				return true
			end
		end
		return false
	end,
	use = function(self, card)
		local _, cards = RVF.highlight(G.jokers)
		cards[1].ability.crv_cartridges = cards[1].ability.crv_cartridges or {}
		cards[1].ability.crv_cartridges[card.config.center.key] = true

		if self.apply then
			self:apply(card, cards[1])
		end
	end,
})

RevosVault.Cartridge({
	key = "glitchy",
	cost = 6,
	atlas = "car_holder",
	pos = {
		x = 0,
		y = 0,
	},
	crv_calculate = function(self, printer, made_card)
		if RVF.has_room(G.jokers) then
			SMODS.copy_card(made_card.center)
			RVF.msg(printer, "Another!")
		else
			RVF.msg(printer, localize("k_no_room_ex"))
		end
	end,
})

RevosVault.Cartridge({
	key = "mixed",
	cost = 6,
	atlas = "car_holder",
	pos = {
		x = 0,
		y = 0,
	},
	crv_priority = 0,
	crv_calculate = function(self, printer, made_card)
		if made_card then
			made_card.center:set_edition(SMODS.poll_edition({ guaranteed = true }))
		end
	end,
})

RevosVault.Cartridge({
	key = "ghostly",
	cost = 6,
	atlas = "car_holder",
	pos = {
		x = 0,
		y = 0,
	},
	crv_priority = 0,
	crv_calculate = function(self, printer, made_card)
		if made_card then
			made_card.center.ability.extra_slots_used = -1
		end
	end,
})

RevosVault.Cartridge({
	key = "ghostly",
	cost = 6,
	atlas = "car_holder",
	pos = {
		x = 0,
		y = 0,
	},
	crv_priority = 0,
	crv_calculate = function(self, printer, made_card)
		if made_card then
			made_card.center.ability.extra_slots_used = -1
		end
	end,
})

RevosVault.Cartridge({
	key = "golden",
	cost = 7,
	atlas = "car_holder",
	pos = {
		x = 0,
		y = 0,
	},
	crv_priority = 0,
	crv_calculate = function(self, printer, made_card)
		if made_card then
			made_card.center.extra_value = made_card.center.extra_value or 0
			made_card.center.extra_value = made_card.center.extra_value + made_card.center.sell_cost
		end
	end,
})

RevosVault.Cartridge({
	key = "soul",
	cost = 6,
	atlas = "car_holder",
	pos = {
		x = 0,
		y = 0,
	},
	config = {
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.c_soul
		local num, den = SMODS.get_probability_vars(printer, 1, 30, "cartridge_soul", nil, true)
		return{
			vars={num,den}
		}
	end,
	apply = function(self, printer)

	end,
	crv_calculate = function(self, printer, made_card, card) 
		if SMODS.pseudorandom_probability(printer, "cartridge_soul", 1, 30, nil, true) then
			SMODS.add_card{
				key = "c_soul",
				area = G.consumeables,
				edition = "e_negative"
			}
		end
	end,
})

RevosVault.Cartridge({
	key = "spin",
	cost = 6,
	atlas = "car_holder",
	pos = {
		x = 0,
		y = 0,
	},
	config = {
	},
})

RevosVault.Cartridge({
	key = "anti",
	cost = 8,
	atlas = "car_holder",
	pos = {
		x = 0,
		y = 0,
	},
	config = {
	},
	apply = function(self, printer)
		printer:set_edition({"e_negative"})
	end,
	
})