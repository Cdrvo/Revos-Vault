SMODS.Gradient({
	key = "crv_polychrome",
	colours = {
		HEX("e81416"),
		HEX("ffa500"),
		HEX("faeb36"),
		HEX("79c314"),
		HEX("487de7"),
		HEX("4b369d"),
		HEX("70369d"),
	},
	cycle = 5,
})

local loc_old = loc_colour
function loc_colour(_c, _default)
	if not G.ARGS.LOC_COLOURS then
		loc_old()
	end
	local loc = G.ARGS.LOC_COLOURS
	loc.crv_polychrome = SMODS.Gradients["crv_polychrome"]
	return loc_old(_c, _default)
end

-- gradients

SMODS.Gradient({
    key = "spamton_gradient",
	colours = {
		HEX("ffaee5"),
		HEX("fffc87"),
	},
	cycle = 5,
})