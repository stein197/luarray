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
	Testing methods naming convention:
	- "Should ... when the array is empty" when the function is tested against empty arrays
	- "Should ... when the array has only one element" when the function is tested against arrays with single element
	- "Should return a new array" when the function should return a new instance of array
	- "Should [not] modify self" when the function should (not) modify inner __data table
	- "Should return correct result" when the function is tested against ordinary cases
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
