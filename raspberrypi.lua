--[[
	Make Sure that `/dev/gpiochip0` is mounted
]]
local GPIO = periphery.GPIO
local gpiochip = "/dev/gpiochip0"

-- Define GPIO INPUT gpio pins and pull their state up
local	KEY_BTN1   = GPIO{path=gpiochip, line=21,	direction="in", edge="falling", bias="pull_up"}
local	KEY_BTN2   = GPIO{path=gpiochip, line=20,	direction="in", edge="falling", bias="pull_up"}
local	KEY_BTN3   = GPIO{path=gpiochip, line=16,	direction="in", edge="falling", bias="pull_up"}
local	KEY_UP     = GPIO{path=gpiochip, line=6,	direction="in", edge="falling", bias="pull_up"}
local	KEY_DOWN   = GPIO{path=gpiochip, line=19,	direction="in", edge="falling", bias="pull_up"}
local	KEY_LEFT   = GPIO{path=gpiochip, line=5,	direction="in", edge="falling", bias="pull_up"}
local	KEY_RIGHT  = GPIO{path=gpiochip, line=26,	direction="in", edge="falling", bias="pull_up"}
local	KEY_PRESS  = GPIO{path=gpiochip, line=13,	direction="in", edge="falling", bias="pull_up"}

-- Close GPIO Pins at runtime exit
local function closeGpio()
	print("Closing GPIO")
	KEY_BTN1.gpio:close()
	KEY_BTN2.gpio:close()
	KEY_BTN3.gpio:close()
	KEY_UP.gpio:close()
	KEY_DOWN.gpio:close()
	KEY_LEFT.gpio:close()
	KEY_RIGHT.gpio:close()
	KEY_PRESS.gpio:close()
	print("Exiting Watch")
	error("", 0)
end


-- init shit
term.showMouse(false)
term.clear()
term.write("loading bigfont")
_G.bigfont = loadfile("bigfont",_ENV)()

-- Thhis makes sure that the key is not repeated when pressed,
-- dont want a single click to send fifty events
-- Not My Code, someone in the computercraft discord wrote this for me
local function stater(gpio, keyEvent, charEvent)
	return {
	  gpio = gpio,
	  state = false,
	  keyEvent = keyEvent,
	  charEvent = charEvent,
	  check = function(self)
		if not self.state and not self.gpio:read() then -- if button at last check wasn't pressed, but is now pressed...
		  self.state = true -- set our data to show it is now pressed.
		  if self.keyEvent then -- queue a key event if one was provided
			os.queueEvent("key", self.keyEvent, false)
		  end
		  if self.charEvent then -- queue a char event if one was provided
			os.queueEvent("char", self.charEvent)
		  end
		elseif self.state and self.gpio:read() then -- if button at last check *was* pressed, but now it is *not* pressed...
		  self.state = false -- set our data to show that it is not pressed.
		  if self.keyEvent then
			os.queueEvent("key_up", self.keyEvent)
		  end
		end
	  end
	}
end

-- map the buttons to events	key pressed	  char
KEY_BTN1	= stater(KEY_BTN1,	keys.numPad1, "1")
KEY_BTN2	= stater(KEY_BTN2,	keys.numPad2, "2")
KEY_BTN3	= stater(KEY_BTN3,	keys.numPad3, "3")
KEY_UP		= stater(KEY_UP,	keys.up)
KEY_DOWN	= stater(KEY_DOWN,	keys.down)
KEY_LEFT	= stater(KEY_LEFT,	keys.left)
KEY_RIGHT	= stater(KEY_RIGHT,	keys.right)
KEY_PRESS	= stater(KEY_PRESS,	keys.enter)

-- Read buttons, looking for a better way to do this
local function keyEvent()
	while true do
		KEY_BTN1:check()
		KEY_BTN2:check()
		KEY_BTN3:check()
		KEY_UP:check()
		KEY_DOWN:check()
		KEY_LEFT:check()
		KEY_RIGHT:check()
		KEY_PRESS:check()
		os.sleep(0.1)
	end
end

local function suicide()
	local suicide = false
	while not suicide do
		local _, key = os.pullEvent("key")
		if key == keys.space then
			suicide = true
		end
	end
end

-- main function where the main program will be running
local function main()
	if fs.exists(shell.resolve("debug.lua"))then
		shell.run("debug.lua")
	else
		shell.run("start.lua")
	end
end

-- Async execution, waitForAny() takes "function", NOT "function()"
-- as arguements and runs them, waiting for any of them to exit before
-- exiting itself, allowing it to finnish an continue the code.
-- waitForAll is the same thing, but it waits for all functions
parallel.waitForAny(main, keyEvent, suicide)
--parallel.waitForAny(debugmain, keyEvent, suicide)
closeGpio()
