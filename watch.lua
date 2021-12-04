local max_w = 7
local max_h = 4

local cur_x = 1
local cur_y = 1

local function drawText(position, text)
	if position == "right" then
		text = string.rep(" ", max_w - #text ) .. text	
		bigfont.bigPrint(text)
	elseif position == "center" then
		text = string.rep(" ", (max_w - #text)/2 ) .. text
		bigfont.bigPrint(text)
	else
		bigfont.bigPrint(position .. text)
	end
end

local function getTime()
	local time = textutils.formatTime(os.time("local"), true)
	return time
end

local function getDate()
	local date = os.date("%m/%d")
	return date
end

local function main()
	while true do
		--term.clear()
		term.setCursorPos(cur_x, cur_y)
		print(" ")
		drawText("center", getTime())
		drawText("center", " ")
		drawText("center", " ")
		drawText("center", getDate())
		os.sleep(0.5)
	end
end


local function suicide()
	local suicide = false
	while not suicide do
		local _, key = os.pullEvent("key")
		if key == keys.enter then
			suicide = true
		end
	end
end


term.clear()
parallel.waitForAny(main, suicide)