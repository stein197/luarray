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
	When possible, functions should:
	- not wrap tables with metatables
]]
-- TODO: Add test cases list

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
