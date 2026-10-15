RevosVault.custom_collection_tabs = function()
	local t = {}
	t[#t + 1] = UIBox_button({
		button = "your_collection_crv_status_effects",
		id = "your_collection_crv_status_effects",
		label = { localize("b_status_effects") },
		minw = 5,
		minh = 1,
		--[[count = {
			tally = RVF.get_collection(RevosVault.MISC.StatusEffects),
			of = RVF.get_total(RevosVault.MISC.StatusEffects),
		},]]
	})

	return t
end


-- UI related stuff for Status Effects

local function create_ui_for_pool(pool, sticker_like)
	local objects = {}

	for k, v in pairs(pool) do
		objects[#objects + 1] = v
	end

	return SMODS.card_collection_UIBox(objects, { 5, 5 }, {
		snap_back = true,
		hide_single_page = true,
		collapse_single_page = true,
		h_mod = 1.18,
		back_func = "your_collection_other_gameobjects",
        center = (sticker_like and "c_base") or nil,
        modify_card = function(card, center)
            if sticker_like then
			    center:apply(card, true)
            end
		end,
	})
end


G.FUNCS.your_collection_crv_status_effects = function()
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu({
		definition = create_ui_for_pool(RevosVault.MISC.StatusEffects, true),
	})
end

-- 