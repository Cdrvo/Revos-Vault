SMODS.DrawStep {
	key = 'new_use',
	order = -30,
	func = function(self)
		if self.children.crv_use then
            if self.highlighted then
                self.children.crv_use:draw() 
            else
                self.children.crv_use:remove() 
                self.children.crv_use = nil
            end
        end
       if self.children.crv_use_alt then
            if self.highlighted then
                self.children.crv_use_alt:draw() 
            else
                self.children.crv_use_alt:remove() 
                self.children.crv_use_alt = nil
            end
        end
	end,
}

SMODS.DrawStep({
	key = "joker_shine",
	order = 11,
	func = function(self)
		if
        self.config.center.pools
			and self.config.center.pools.SuperiorSpectral == true
			and self.ability.set == "Superior"
			and self:should_draw_base_shader()
		then
			self.children.center:draw_shader("booster", nil, self.ARGS.send_to_shader)
		end
	end,
	conditions = { vortex = false, facing = "front" },
})

SMODS.DrawStep({
	key = "crv_negative_runes",
	order = 11,
	func = function(self)
		if  
            (self.ability.set == "crv_Rune" or self.config.center.key == "j_crv_runeprinter") or (self.config.center.group_key and self.config.center.group_key == "k_crv_runep") 
			and self:should_draw_base_shader()
		then
			self.children.center:draw_shader("negative", nil, self.ARGS.send_to_shader)
            self.children.center:draw_shader("negative_shine", nil, self.ARGS.send_to_shader)
		end
	end,
	conditions = { vortex = false, facing = "front" },
})

SMODS.DrawStep({
	key = "force_canvas",
	order = 11,
	func = function(self)
		if string.find(self.config.center.key, "j_crv_deathcard") then
            local pd = RevosVault.find_deathcard_profile(self.config.center.key)
            local pdd = G.PROFILES[G.SETTINGS.profile].crv_deathcards
			if not self.crv_canvas_text_1 then
				self.crv_canvas_text_1 = SMODS.CanvasSprite({
					canvasW = 71,
					canvasH = 95,
					text_offset = { x = 36, y = 11 },
					text_width = 45,
					text_height = 11,
					ref_table = pdd[pd],
					ref_value = "given_name",
					text_colour = HEX("351a09"),
				})
			end
			-- print(RevosVault.placeholder_name)
			if not self.crv_canvas_text_2 then
				self.crv_canvas_text_2 = SMODS.CanvasSprite({
					canvasW = 71,
					canvasH = 95,
					text_offset = { x = 36, y = 78 },
					text_width = 45,
                    text_height = 18,
					ref_table = pdd[pd],
					ref_value = "timer",
					text_colour = HEX("351a09"),
				})
			end
		end
	end,
	conditions = { vortex = false, facing = "front" },
})

SMODS.DrawStep {
    key = 'crv_canvas_text_1',
    order = 45,
    func = function(self, layer)
        if self.crv_canvas_text_1 then
            for _, sprite in ipairs(self.crv_canvas_text_1[1] and self.crv_canvas_text_1 or {self.crv_canvas_text_1}) do
                love.graphics.push()
                love.graphics.origin()
                sprite.canvas:renderTo(love.graphics.clear, 0, 0, 0, 0)
                local text = love.graphics.newText(
				SMODS.Fonts["crv_dcard_text"].FONT,
				 {
				 sprite.text_colour or G.C.UI.TEXT_LIGHT,
				 (sprite.prefix or "") .. (sprite.ref_table and sprite.ref_table[sprite.ref_value] or sprite.text)
				})
                local scale_fac = math.min((sprite.text_width or sprite.canvasW)/text:getWidth(), (sprite.text_height or sprite.canvasH)/text:getHeight()) * sprite.canvasScale
                if text then 
                    local x,y,r,sx,sy,ox,oy = unpack(sprite.text_transform or {
                            (0 + sprite.text_offset.x) * sprite.canvasScale,
                            (0 + sprite.text_offset.y) * sprite.canvasScale,
                            0,
                            scale_fac, scale_fac,
                            text:getWidth()/2, text:getHeight()/2
                        })
                    sprite.canvas:renderTo(love.graphics.draw,
                        text,
                        x, y, r, sx, sy, ox, oy
                    )
                end
                love.graphics.pop()
                sprite.role.draw_major = self
                sprite:draw_shader('dissolve', nil, nil, nil, self.children.center)
            end
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}


SMODS.DrawStep {
    key = 'crv_canvas_text_2',
    order = 45,
    func = function(self, layer)
        if self.crv_canvas_text_2 then
            for _, sprite in ipairs(self.crv_canvas_text_2[1] and self.crv_canvas_text_2 or {self.crv_canvas_text_2}) do
                love.graphics.push()
                love.graphics.origin()
                sprite.canvas:renderTo(love.graphics.clear, 0, 0, 0, 0)
                local text = love.graphics.newText(
				SMODS.Fonts["crv_dcard_num"].FONT,
				 {
				 sprite.text_colour or G.C.UI.TEXT_LIGHT,
				 (sprite.prefix or "") .. (sprite.ref_table and sprite.ref_table[sprite.ref_value] or sprite.text)
				})
                local scale_fac = math.min((sprite.text_width or sprite.canvasW)/text:getWidth(), (sprite.text_height or sprite.canvasH)/text:getHeight()) * sprite.canvasScale
                if text then 
                    local x,y,r,sx,sy,ox,oy = unpack(sprite.text_transform or {
                            (0 + sprite.text_offset.x) * sprite.canvasScale,
                            (0 + sprite.text_offset.y) * sprite.canvasScale,
                            0,
                            scale_fac, scale_fac,
                            text:getWidth()/2, text:getHeight()/2
                        })
                    sprite.canvas:renderTo(love.graphics.draw,
                        text,
                        x, y, r, sx, sy, ox, oy
                    )
                end
                love.graphics.pop()
                sprite.role.draw_major = self
                sprite:draw_shader('dissolve', nil, nil, nil, self.children.center)
            end
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}

SMODS.DrawStep {
    key = 'crv_tilting_sprite',
    order = 60,
    func = function(self)
        if self.config.center.crv_soul_pos and (self.config.center.discovered or self.bypass_discovery_center) then
            local scale_mod = 0.05 + 0.05*math.sin(1.8*G.TIMERS.REAL) + 0.07*math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
            local rotate_mod = 0.1*math.sin(1.219*G.TIMERS.REAL) + 0.07*math.sin((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2

            if self.children.crv_floating_sprite then
                self.children.crv_floating_sprite:draw_shader('dissolve',0, nil, nil, self.children.center,scale_mod, rotate_mod,nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL),nil, 0.6)
                self.children.crv_floating_sprite:draw_shader('dissolve', nil, nil, nil, self.children.center, scale_mod, rotate_mod)
            end
            if self.edition then 
                local edition = G.P_CENTERS[self.edition.key]
                if edition.apply_to_float and self.children.crv_floating_sprite then
                    self.children.crv_floating_sprite:draw_shader(edition.shader, nil, nil, nil, self.children.center, scale_mod, rotate_mod)                    
                end
            end
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}

SMODS.DrawStep { 
    key = 'all_card_no_card',
    order = 9999999,
    func = function(self, layer)
        G.crv_nocards = G.crv_nocards or {}
        if self.ability.set == "Joker" and next(SMODS.find_card("j_crv_the_nameless_creature_that_shouldnotbe_spoken_of"))  then 
            local ccard = G.P_CENTERS.j_crv_the_nameless_creature_that_shouldnotbe_spoken_of
            if not G.crv_nocards[ccard.key] then 
                G.crv_nocards[ccard.key] = SMODS.create_sprite(0, 0, G.CARD_W, G.CARD_H, ccard.atlas, {x = ccard.pos.x, y = ccard.pos.y})
            end
            G.crv_nocards[ccard.key].role.draw_major = self
            G.crv_nocards[ccard.key]:draw_shader('dissolve', nil, nil, nil, self.children.center) 
            if self.edition then G.crv_nocards[ccard.key]:draw_shader(SMODS.Edition.obj_table[self.edition.key].shader, nil, self.ARGS.send_to_shader, nil, self.children.center) end 
            
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}