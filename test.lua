--[[ 
	All functions should be tested against:
	- empty table
	- table with single item
	- table with multiple items
	- primitives
	- plain table
	- array
	- tables with custom metatables (object instances)
	All functions should:
	- return different array (if the function returns an array)
	- modify or not modify self if __mutable == true/false
	- not wrap tables with metatables
	- modify only inner __data table
]]

array = require ""
luaunit = require "luaunit"

Class = setmetatable({}, {
	__index = {
		prop = "string";
		method = function (self)
			return self.prop
		end;
	};
	__call = function (self)
		return setmetatable({}, ClassMt)
	end;
})
ClassMt = {
	__index = Class
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
