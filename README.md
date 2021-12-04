### How to use
The program is meant to be ran on a piZero using [this hat](https://www.amazon.com/dp/B077Z7DWW1) and the periphery lua plugin

* for pi
	1. you need to install craftos, which involves compiling from source code.
		* following the directions from repo works
	2. install lua 5.1 and luarocks
	3. using luarocks, install the periphery library
	4. run `mkdir /usr/local/share/craftos/plugins/`
		* run `ln -s /usr/local/lib/lua/5.1/periphery.so /usr/local/share/craftos/plugins/periphery.so`
	5. fill `/home/pi/.local/share/craftos-pc/computers/0/startup.lua` with the following
		```lua
		shell.run("cd /cc-panel/") -- change this to where you have this repo located
		shell.run("raspberrypi.lua")
		shell.run("cd /")
		```

* for ComputerCraft
	1. run start.lua
