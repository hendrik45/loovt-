local _M = { STATE_UP = 0, STATE_TAKEN = 1 }

local _coin_think = function(self, world)
	if(self.state == _M.STATE_UP and (world.mario_x + MARIO_WIDTH) > self.x and (world.mario_x - MARIO_WIDTH) < self.x and world.mario_y > (self.y - self.height) and (world.mario_y - MARIO_HEIGHT) < self.y) then
		self.state = _M.STATE_TAKEN
		AUDIO_COIN:stop()
		AUDIO_COIN:play()
		MARIO_COINS = MARIO_COINS + 1
		MARIO_SCORE = MARIO_SCORE + SCORE_COIN
	end
end

local _coin_draw = function(self, world)
	if(self.state == _M.STATE_UP) then
		love.graphics.setColor(255, 255, 255, 255)
		if(self.next_frame < love.timer.getTime()) then
			self.animation_id = ((self.animation_id + 1) % 2)
			self.next_frame   = love.timer.getTime() + 0.6
		end

		local tex = TEX_COIN_F1
		if(self.animation_id == 1) then
			tex = TEX_COIN_F2
		end
		love.graphics.draw(tex, self.x * SCALE, (self.y - self.height) * SCALE, 0, SCALE / 128, SCALE / 128)
	end
end

_PROTO_COIN = {think = _coin_think, draw = _coin_draw}

local _new_coin = function(x, y)
	local coin = {mt = {__index = _PROTO_COIN}, state = _M.STATE_UP, x = x - 1, y = y, width = 1.0, height = 1.0, animation_id = 0, next_frame = 0}
	setmetatable(coin, coin.mt)
	return coin
end

_M.new = _new_coin

return _M
