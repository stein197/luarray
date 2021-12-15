--[[
	Functions should at least be tested against:
	- empty array
	- array with single item
	- array with multiple items
	- array with nil
	Functions should at least be tested against arrays with:
	- primitive
	- plain table
	- array
	- object
	- nil
	When possible, functions should:
	- return different array
	- not wrap tables with metatables
]]
-- TODO: Add test cases list

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
