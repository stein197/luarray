local proto = {
	len = function (self) end; -- TODO
	every = function (self, f) end; -- TODO
	filter = function (self, f) end; -- TODO
	fill = function (self, f) end; -- TODO
	find = function (self, f) end; -- TODO
	findindex = function (self, f) end; -- TODO
	flat = function (self, depth) end; -- TODO
	foreach = function (self, f) end; -- TODO
	contains = function (self, item) end; -- TODO
	indexof = function (self, item) end; -- TODO
	lastindexof = function (self, item) end; -- TODO
	join = function (self, sep) end; -- TODO
	map = function (self, f) end; -- TODO
	reduce = function (self, f, init) end; -- TODO
	reduceend = function (self, f, init) end; -- TODO
	reverse = function (self) end; -- TODO
	slice = function (self, from, to) end; -- TODO
	some = function (self, f) end; -- TODO
	sort = function (self, f) end; -- TODO
	clone = function (self) end; -- TODO
	push = function (self, item) end; -- TODO
	unshift = function (self, item) end; -- TODO
	pop = function (self) end; -- TODO
	shift = function (self) end; -- TODO
	column = function (self) end; -- TODO
	keys = function (self) end; -- TODO
	values = function (self) end; -- TODO
	diff = function (self, f) end; -- TODO
	intersect = function (self, f) end; -- TODO
	first = function (self) end; -- TODO
	last = function (self) end; -- TODO
	shuffle = function (self) end; -- TODO
	pad = function (self) end; -- TODO
	unique = function (self) end; -- TODO
	islist = function (self) end; -- TODO
	isempty = function (self) end; -- TODO
	truncate = function (self) end; -- TODO

	totable = function (self)
		-- local t = {}
		-- for k, v in pairs(self.__data) do
		-- 	t[k] = type(v) == "table" and v:totable() or v
		-- end
		-- return t
	end;
}

-- TODO: Metamethods: http://lua-users.org/wiki/MetatableEvents
local metatable = {}

--- Creates a new array from passed arguments. Accepts varargs. If there is only one argument and it's a table, then
--- the function wraps it. Otherwise wraps all arguments as if it's a table.
--- @return table array Array
local function ctor(self, ...)
	local args = {...}
	local array = {
		__data = {} -- TODO: No need in __data? Store directly in array?
	}
	local issinglearg = #args == 1 and type(args[1]) == "table"
	local data = issinglearg and args[1] or args
	if issinglearg and getmetatable(data) == metatable then
		table.insert(array.__data, data)
	else
		for k, v in pairs(data) do
			array.__data[k] = type(v) == "table" and getmetatable(v) ~= metatable and ctor(self, v) or v
		end
	end
	return setmetatable(array, metatable)
end

--- Overloads index access to the array. Redirects all calls to the internal `__data` table field if the key is not in
--- the proto table, otherwise returns function from it.
--- @param k any An index key
--- @return any value The value associated with the key
function metatable:__index(k)
	local m = proto[k]
	return m and m or self.__data[k]
end

--- Overloads index assigning. Redirects all calls to the internal `__data` table field.
--- @param k any An index key
--- @param v any A new value associated with the key
function metatable:__newindex(k, v)
	self.__data[k] = type(v) == "table" and getmetatable(v) ~= metatable and ctor(self, v) or v
end

function metatable:__call() end -- TODO
function metatable:__len() end -- TODO
function metatable:__pairs() end -- TODO
function metatable:__ipairs() end -- TODO
function metatable:__add() end -- TODO
function metatable:__sub() end -- TODO
function metatable:__concat() end -- TODO
function metatable:__eq() end -- TODO

return setmetatable({
	combine = function (keys, values) end; -- TODO
}, {
	__call = ctor
})
