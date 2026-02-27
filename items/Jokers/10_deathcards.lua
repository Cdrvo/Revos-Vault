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
		no_collection = true,
		in_pool = function(self)
			return RevosVault.dcard_in_pool(self.key)
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
