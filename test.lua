--[[
	Functions should at least be tested against:
	- empty array
	- array with single item
	- array with multiple items
	- array
	- object
	- nil
	Testing methods naming convention:
	- Basic syntax for method name is: "Should[n't] <expectation> [after <action>] [when <condition>]" 
	- Shorthand negation is preferable (not "does not" but "doesn't")
	Common names are:
	- Should <expectation> when the array is empty
	- Should <expectation> when the array has only one element [and <condition>]
	- Should return a new array
	- Shouldn't modify itself
	- Should return correct result [when <condition>]
	- Should return an array equal to the original one when <condition>
]]

array = require ""
luaunit = require "luaunit"

Object = setmetatable({}, {
	__call = function (self)
		return setmetatable({}, ObjectMt)
	end;
})
ObjectMt = {
	__index = Object
}
local command
if package.config:sub(1, 1) == "/" then
	command = "ls tests | grep \"\\.lua$\""
else
	command = "dir tests /a:-d /b | findstr \"\\.lua$\""
end
for file in io.popen(command):lines() do
	dofile("tests/"..file)
end

os.exit(luaunit.run())
