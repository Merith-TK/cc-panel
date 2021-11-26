term.showMouse(false)
--shell.run("shell")
local max_w = 21
local max_h = 14

local cur_x = 1
local cur_y = 1

local function getTime()
	local time = textutils.formatTime(os.time("local"))
	return time
end


local function drawText(position, text)
	if position == "right" then
		text = string.rep(" ", max_w - #text ) .. text	
	elseif position == "center" then
		text = string.rep(" ", (max_w - #text)/2 ) .. text
	end
	term.write(text)
	cur_y = cur_y + 1
	term.setCursorPos(cur_x, cur_y)
end

while true do
	term.clear()
	cur_x = 1
	cur_y = 1
	term.setCursorPos(cur_x, cur_y)
	drawText("center", getTime())
	drawText("center", "#---------#---------#")
	os.sleep(0.15)
end