--shell.run("pastebin get B1N0C6Ua menu")
os.loadAPI("/workspace/cc-panel/menu/menu.lua")
--local menu = require("./menu")


local m = menu.new()


m:addScreen("main",
[[
 
    MAIN MENU
                   
 
Play some games @games
 
]])

m:addScreen("games",
[[
Play worm @worm    
]])

m:addFunc("worm", shell.run, "worm")

function hello()
  term.clear()
  term.setCursorPos(1,1)
  print("Hello World!")
end

m:addFunc("hello", hello)

local f = m:displayScreen("main")
if f ~= nil then
  f()
end