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
			self.config.center.soul_set == "Spectral"
			and self.ability.set == "Superior"
			and self:should_draw_base_shader()
		then
			self.children.center:draw_shader("booster", nil, self.ARGS.send_to_shader)
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