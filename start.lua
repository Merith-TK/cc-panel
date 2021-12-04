local max_w = 7
local max_h = 4

local cur_x = 1
local cur_y = 1

local taskRunning = false

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
		while taskRunning do
			os.sleep()
		end
	end
end


local function runProgram(program)
	taskRunning = true
	if type(program) == "function" then
		program()
	elseif type(program) == "string" then
		shell.run(program)
	end
	taskRunning = false
end

local function menu()
	local runmenu = false
	while not runmenu do
		local _, key = os.pullEvent("key")
		if key == keys.enter then
			runProgram("menu/start.lua")
		end
		while taskRunning do
			os.sleep()
		end
	end
end


term.clear()
parallel.waitForAny(main, menu)