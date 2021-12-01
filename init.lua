-- TODO: Metamethods: http://lua-users.org/wiki/MetatableEvents
local metatable = {}
local proto = {}

local function isplaintable(t)
	return type(t) == "table" and getmetatable(t) ~= metatable
end

--- Creates a new array from passed arguments. Accepts varargs. If there is only one argument and it's a table, then
--- the function wraps it. Otherwise wraps all arguments as if it's a table.
--- @return Array array Array
--- @class Array
--- @field private __data table
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

function metatable:__add(v) table.insert(self.__data, isplaintable(v) and ctor(self, v) or v) end
function metatable:__call() end -- TODO

--- Overloads calling to `pairs` function. When the array is passed to `pairs` function in for loop it simply iterates
--- inner `__data` plain table
function metatable:__pairs()
	return pairs(self.__data)
end

--- Overloads calling to `ipairs` function. When the array is passed to `ipairs` function in for loop it simply iterates
--- inner `__data` plain table
function metatable:__ipairs()
	return ipairs(self.__data)
end

function metatable:__sub() end -- TODO
function metatable:__concat() end -- TODO
function metatable:__eq() end -- TODO

--- Returns length of the table. Same as `#` operator.
--- @return number len The length of the table.
function proto:len()
	return #self.__data
end

--- Checks if every element in the array satisfies the passed predicate.
--- ```lua
--- array(1, 2, 3):every(function (v, k, self) return v > 2 and type(k) ~= "string" end)
--- ```
--- @generic K, V
--- @param f fun(v: V, k?: K, t?: table<K, V>): boolean Predicate
--- @return boolean rs `true` if all elements satisfy the predicate.
function proto:every(f)
	local rs = true
	for k, v in pairs(self) do
		rs = rs and f(v, k, self)
		if not rs then
			break
		end
	end
	return not not rs -- Explicit casting to boolean
end

--- Filters all the elements preserving only those that pass the predicate. Returns new array.
--- @generic K, V
--- @param f fun(v: V, k?: K, t?: table<K, V>) Predicate
--- @param pk boolean Set to `true` to preserve keys, otherwise keys will be discarded. `true` by default
--- @return Array<K, V> rs New array containing every element that satisfies the predicate. Keys stay preserved
function proto:filter(f, pk)
	local rs = ctor()
	if pk == nil then
		pk = true
	end
	for k, v in pairs(self) do
		if f(v, k, self) then
			if pk then
				rs.__data[k] = v
			else
				table.insert(rs.__data, v)
			end
		end
	end
	return rs
end

function proto:fill(f) end -- TODO
function proto:find(f) end -- TODO
function proto:findindex(f) end -- TODO
function proto:flat(depth) end -- TODO
function proto:foreach(f) end -- TODO
function proto:contains(item) end -- TODO
function proto:indexof(item) end -- TODO
function proto:lastindexof(item) end -- TODO
function proto:join(sep) end -- TODO
function proto:map(f) end -- TODO
function proto:reduce(f, init) end -- TODO
function proto:reduceend(f, init) end -- TODO
function proto:reverse() end -- TODO
function proto:slice(from, to) end -- TODO
function proto:some(f) end -- TODO
function proto:sort(f) end -- TODO
function proto:clone() end -- TODO
function proto:push(item) end -- TODO
function proto:unshift(item) end -- TODO
function proto:pop() end -- TODO
function proto:shift() end -- TODO
function proto:column() end -- TODO
function proto:keys() end -- TODO
function proto:values() end -- TODO
function proto:diff(f) end -- TODO
function proto:intersect(f) end -- TODO
function proto:first() end -- TODO
function proto:last() end -- TODO
function proto:shuffle() end -- TODO
function proto:pad() end -- TODO
function proto:unique() end -- TODO
function proto:islist() end -- TODO
function proto:isempty() end -- TODO
function proto:truncate() end -- TODO
function proto:totable() local t = {};for k, v in pairs(self.__data) do t[k] = type(v) == "table" and v:totable() or v;end return t; end -- TODO

return setmetatable({
	combine = function (keys, values) end; -- TODO
}, {
	__call = ctor
})
