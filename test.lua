--[[ 
	Functions should at least be tested against:
	- empty array
	- array with single item
	- array with multiple items
	- plain table
	- table with non-numeric keys
	- primitive
	- array
	- object
	- nil
	- table with nil
	When function should return an array, make sure it really does (Should return a new array)
	When function should (not) modify inner __data table, make sure it really does (not) (Should [not] modify self)
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
