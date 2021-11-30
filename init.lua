-- TODO: Metamethods: http://lua-users.org/wiki/MetatableEvents
local metatable = {}
local proto = {}

local function isplaintable(t)
	return type(t) == "table" and getmetatable(t) ~= metatable
end

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
			array.__data[k] = isplaintable(v) and ctor(self, v) or v
		end
	end
	return setmetatable(array, metatable)
end

--- Overloads index access to the array. Redirects all calls to the internal `__data` table field if the key is not in
--- the proto table, otherwise returns function from it.
--- @param k any An index key.
--- @return any value The value associated with the key.
function metatable:__index(k)
	local m = proto[k]
	return m and m or self.__data[k]
end

--- Overloads index assigning. Redirects all calls to the internal `__data` table field.
--- @param k any An index key
--- @param v any A new value associated with the key.
function metatable:__newindex(k, v)
	self.__data[k] = isplaintable(v) and ctor(self, v) or v
end

--- Overloads `#` operator.
--- @return number len The length of the table.
function metatable:__len()
	return #self.__data
end

-- function metatable:__add(v) table.insert(self.__data, isplaintable(v) and ctor(self, v) or v) end
-- function metatable:__call() end -- TODO
-- function metatable:__pairs() return pairs(self.__data) end -- TODO
-- function metatable:__ipairs() return ipairs(self.__data) end -- TODO
function metatable:__sub() end -- TODO
function metatable:__concat() end -- TODO
function metatable:__eq() end -- TODO
function proto:len(self) end; -- TODO
function proto:every(self, f) end; -- TODO
function proto:filter(self, f) end; -- TODO
function proto:fill(self, f) end; -- TODO
function proto:find(self, f) end; -- TODO
function proto:findindex(self, f) end; -- TODO
function proto:flat(self, depth) end; -- TODO
function proto:foreach(self, f) end; -- TODO
function proto:contains(self, item) end; -- TODO
function proto:indexof(self, item) end; -- TODO
function proto:lastindexof(self, item) end; -- TODO
function proto:join(self, sep) end; -- TODO
function proto:map(self, f) end; -- TODO
function proto:reduce(self, f, init) end; -- TODO
function proto:reduceend(self, f, init) end; -- TODO
function proto:reverse(self) end; -- TODO
function proto:slice(self, from, to) end; -- TODO
function proto:some(self, f) end; -- TODO
function proto:sort(self, f) end; -- TODO
function proto:clone(self) end; -- TODO
function proto:push(self, item) end; -- TODO
function proto:unshift(self, item) end; -- TODO
function proto:pop(self) end; -- TODO
function proto:shift(self) end; -- TODO
function proto:column(self) end; -- TODO
function proto:keys(self) end; -- TODO
function proto:values(self) end; -- TODO
function proto:diff(self, f) end; -- TODO
function proto:intersect(self, f) end; -- TODO
function proto:first(self) end; -- TODO
function proto:last(self) end; -- TODO
function proto:shuffle(self) end; -- TODO
function proto:pad(self) end; -- TODO
function proto:unique(self) end; -- TODO
function proto:islist(self) end; -- TODO
function proto:isempty(self) end; -- TODO
function proto:truncate(self) end; -- TODO
function proto:totable(self) local t = {};for k, v in pairs(self.__data) do t[k] = type(v) == "table" and v:totable() or v;end return t; end; -- TODO

return setmetatable({
	combine = function (keys, values) end; -- TODO
}, {
	__call = ctor
})
