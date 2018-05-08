local _M = { STATE_ASLEEP = 0, STATE_ALIVE = 1, STATE_PASSED = 2, STATE_DELETED = 4 }

local _goomba_spawner_think = function(self, world)
	if self.state == _M.STATE_ASLEEP then
		if(x_visible(world, self.x)) then
			self.state = _M.STATE_ALIVE
		end
	elseif(self.state == _M.STATE_ALIVE) then
		if(self.last_spawn == 0.0 and self.next_spawn == 0.0) then
			self.last_spawn = love.timer.getTime()
			self.next_spawn = self.last_spawn + self.interval
		elseif(self.next_spawn < love.timer.getTime()) then
			table.insert(world.entities, Goomba.new(self.x + 1, self.y))
			self.last_spawn = love.timer.getTime()
			self.next_spawn = self.last_spawn + self.interval
		end
		if world.mario_x > self.x then
			self.state = _M.STATE_PASSED
		end
	end
end

local _goomba_spawner_get_phase = function(self)
	if(self.last_spawn == 0.0 or self.next_spawn == 0.0) then return 0, 0 end

	local ix, iy = 0.0, 0.0
	local dt = love.timer.getTime()
	
	local tp = (dt - self.last_spawn) / self.interval
	local res = tp * math.pi * 2
	self.ind_x = math.cos(res)
	self.ind_y = math.sin(res)
end

local _goomba_spawner_draw = function(self, world)
	if(WORLD_STATE == WORLD_PLAY and self.state == _M.STATE_ALIVE) then
		self:assign_phase()
	end
	
	love.graphics.setColor(125, 125, 125, 255)
	love.graphics.circle("fill", (self.x + self.width / 2) * SCALE, (self.y - self.height / 2) * SCALE, (self.width * SCALE) / 2)
	
	if(self.state == _M.STATE_ALIVE) then
		love.graphics.setColor(32, 225, 32, 255)
	elseif(self.state == _M.STATE_PASSED) then
		love.graphics.setColor(200, 64, 32, 255)
	end
	love.graphics.circle("fill", (self.x + (self.width + self.ind_y) / 2) * SCALE, (self.y - (self.height + self.ind_x) / 2) * SCALE, (self.width * SCALE) / 8)
end

_PROTO_GOOMBA_SPAWNER = {think = _goomba_spawner_think, draw = _goomba_spawner_draw, assign_phase = _goomba_spawner_get_phase}

local _new_goomba_spawner = function(x, y)
	local goomba_spawner = {mt = {__index = _PROTO_GOOMBA_SPAWNER}, state = _M.STATE_ASLEEP, x = x - 1, y = y, width = 1.0, height = 1.0, ind_x = 0.0, ind_y = 0.0, interval = GOOMBA_SPAWNER_TIMER, last_spawn = 0.0, next_spawn = 0.0}
	setmetatable(goomba_spawner, goomba_spawner.mt)
	return goomba_spawner
end

_M.new = _new_goomba_spawner

return _M
