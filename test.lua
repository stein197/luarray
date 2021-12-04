--[[ 
	All functions should be tested at least against:
	- empty table
	- table with single item
	- table with multiple items
	- passing a plain table
	- passing an array
	- passing tables with custom metatables (object instances)
	- tables with numeric indeces
	- tables with non-numeric indeces
	All functions should at least:
	- return different array (if the function returns an array)
	- modify or not modify self if __mutable == true/false
	- not wrap tables with metatables
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
		return setmetatable({}, {
			__index = Class
		})
	end;
})
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
