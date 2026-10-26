--[[
SMODS.ConsumableType({
	key = "crv_super_evil_consumables",
	collection_rows = { 5, 6 },
	primary_colour = HEX("000000"),
	secondary_colour = G.C.BLACK,
	text_colour = G.C.RED,
})

local function fah(thing)
	local a = 0
	for k, v in pairs(thing) do
		a = a + 1
	end
	return a
end

local function cart_blacklist(cart, card)
	if card.config.center.crv_cartridge_blacklist and card.config.center.crv_cartridge_blacklist[cart] then
		return true
	end
	return false
end

SMDOS.Consumable({
	key = "super_evil_cartridge",
	cost = 8,
    set = "crv_super_evil_consumables",
	atlas = "revo_evils",
	pos = {
		x = 0,
		y = 0,
	},
	crv_priority = 1,
	can_use = function(self, card)
		if RVF.highlight(G.jokers) then
			local _, cards = RVF.highlight(G.jokers)
			if
				#cards == 1
				and cards[1].config.center.attributes
				and cards[1].config.center.attributes.printer
				and not cart_blacklist(card.config.center.key, cards[1])
				and not RVF.has_cartridge(cards[1], card.config.center.key)
				and (
					not cards[1].ability.crv_cartridges
					or (
						cards[1].ability.crv_cartridges and
						fah(cards[1].ability.crv_cartridges)<G.GAME.crv_cartridge_limit
					)
					or 
					(
						cards[1].ability.crv_cartridges and
						(card.ability.consumeable.crv_ignore_cartridge_limit or cards[1].ability.crv_ignore_cartridge_limit)
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
			self:apply(cards[1])
		end
	end,
    apply = function(self, card)
        card.ability.crv_ignore_cartridge_limit = true

        -- curse shit or somethinfg id
    end
})
--]]