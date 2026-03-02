for i = 1, 10 do
	SMODS.Joker({
		key = "deathcard" .. i,
		atlas = "dcards",
		rarity = 1,
		cost = 4,
		pos = {
			x = 0,
			y = 0,
		},
		pools = {
			["Inscryption"] = true,
			["Beast"] = true,
			["Human"] = true, 
			["Deathcard"] = true
		},
		no_collection = true,
		in_pool = function(self)
			if self and self.key then
				return RevosVault.dcard_in_pool(self.key)
			else
				return RevosVault.dcard_in_pool("j_crv_deathcard" .. i)
			end
		end,
	})
end

SMODS.Joker({
	key = "placeholder_death",
	atlas = "dcards",
	rarity = 1,
	cost = 4,
	pos = {
		x = 0,
		y = 0,
	},
	no_collection = true,
	in_pool = function(self)
		return false
	end,
})
