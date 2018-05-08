--- UTILITIES AND DEBUG

FRAME_DEBUG = ""
DEBUG_LINES = {}

function in_range(n, start, e)
	if(n >= start and n <= e) then return true else return false end
end

function x_visible(world, x)
	if(in_range(x, (0 - CAMERA_X) / SCALE, (0 - CAMERA_X) / SCALE + love.graphics.getWidth() / SCALE)) then
		return true
	else
		return false
	end
end

function fdebug(s)
	FRAME_DEBUG = FRAME_DEBUG .. "\n" .. s
end

function debugline(x1, y1, x2, y2)
	table.insert(DEBUG_LINES, {x1 = x1, y1 = y1, x2 = x2, y2 = y2})
end

function draw_debug_lines()
	love.graphics.setColor(255, 255, 255, 255)
	for k, v in pairs(DEBUG_LINES) do
		love.graphics.line(v.x1, v.y1, v.x2, v.y2)
	end
end

function pad_zeroes(s, length)
	local rs = s
	local nz = length - s:len()
	if(nz >= 1) then
		for i = 1, nz do
			rs = "0" .. rs
		end
	end
	return rs
end
