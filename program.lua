--shell.run("shell")
local max_w = 21
local max_h = 14

local cur_x = 1
local cur_y = 1

local taskRunning = false

local function getTime()
	local time = textutils.formatTime(os.time("local"))
	local date = os.date("%b-%d-%y")
	local output = " " .. date .. string.rep(" ", (max_w - #date - #time - 2)) .. time
	return output
end


local function drawText(position, text)
	if position == "right" then
		text = string.rep(" ", max_w - #text ) .. text	
		term.write(text)
	elseif position == "center" then
		text = string.rep(" ", (max_w - #text)/2 ) .. text
		term.write(text)
	else
		term.write(position .. text)
	end
	cur_y = cur_y + 1
	term.setCursorPos(cur_x, cur_y)
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
	while true do
		local ev, key = os.pullEvent("key")
		if key == keys.numPad1 then
			runProgram("worm")
		elseif key == keys.numPad2 then
			runProgram("watch.lua")
		elseif key == keys.numPad3 then
			runProgram("menu/start.lua")
		end
	end
end

local function main()
	while true do
		term.clear()
		cur_x = 1
		cur_y = 1
		term.setCursorPos(cur_x, cur_y)
		drawText("", getTime())
		drawText("center", "#---------#---------#")
		drawText("", "[1] worm")
		drawText("", "[2] clock")
		drawText("", "[3] menu-test")
		os.sleep(0.15)
		while taskRunning do
			os.sleep()
		end
	end
end

parallel.waitForAny(main, menu)
