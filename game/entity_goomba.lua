local _M = { STATE_ASLEEP = 0, STATE_ALIVE = 1, STATE_DYING = 2, STATE_DELETED = 4}

AUDIO_GOOMBA_STOMP = love.audio.newSource("goomba_stomp.ogg", "static")

local _goomba_check_mario = function(self, world)
	if(world.mario_av.y > 0 and in_range(world.mario_x, self.x - MARIO_WIDTH, self.x + self.width) and in_range(world.mario_y, self.y - self.height, self.y - self.height + 0.3)) then
		AUDIO_GOOMBA_STOMP:stop()
		AUDIO_GOOMBA_STOMP:play()
		world.mario_av.y = -0.6
		self.state = _M.STATE_DYING
		MARIO_SCORE = MARIO_SCORE + SCORE_GOOMBA_KILL
	elseif(in_range(world.mario_x, self.x - MARIO_WIDTH, self.x + MARIO_WIDTH) and in_range(world.mario_y, self.y - self.height + 0.1, self.y + MARIO_HEIGHT)) then
		mario_death()
	end
end

local _goomba_think = function(self, world)
	if self.state == _M.STATE_ASLEEP then
		if(x_visible(world, self.x)) then
			self.state = _M.STATE_ALIVE
		end
	elseif self.state == _M.STATE_ALIVE then
		simulate_physics(world, self)
		if(self.left_wall)  then self.direction = "right" end
		if(self.right_wall) then self.direction = "left"  end
		if(self.on_ground) then
			if(self.direction == "left") then self.av.x = -0.05
			else self.av.x = 0.05 end
		end
		_goomba_check_mario(self, world)
		if(self.y > (world.height + 10)) then
			self:delete()
		end
	elseif self.state == _M.STATE_DYING then
		if(not self.death_end_timer_set) then
			self.death_end_timer = love.timer.getTime() + 0.6
			self.death_end_timer_set = true
		elseif self.death_end_timer < love.timer.getTime() then
			self:delete()
		end
	end
end

local _goomba_draw  = function(self)
	love.graphics.setColor(0, 0, 0, 255)
	if(self.state == _M.STATE_ALIVE) then
		love.graphics.rectangle("fill", self.x * SCALE, (self.y - self.height) * SCALE, self.width * SCALE, self.height * SCALE)
	elseif self.state == _M.STATE_DYING then
		love.graphics.rectangle("fill", self.x * SCALE, (self.y - self.height) * SCALE + SCALE / 2, self.width * SCALE, (self.height * SCALE) / 2)
	end
end

local _goomba_delete = function(self)
	self.state = _M.STATE_DELETED
end

local _PROTO_GOOMBA = {think = _goomba_think, draw = _goomba_draw, delete = _goomba_delete}

local _new_goomba = function(x, y)
	local goomba = {mt = {__index = _PROTO_GOOMBA}, state = _M.STATE_ASLEEP, death_end_timer = 0, death_end_timer_set = false, x = x - 1, y = y, av = {x = 0.0, y = 0.0}, width = 1.0, height = 1.0, on_ground = false, direction = "left"}
	setmetatable(goomba, goomba.mt)
	return goomba
end

_M.new = _new_goomba

return _M
