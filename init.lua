-- TODO: Preserve order of addition?
-- TODO: Delete pt and replace with mt.__index:<fn>
-- TODO: Annotate types to help IDE
-- TODO: Make every function accept key first only then value
local mt = {}

--- @class array
--- @field private __data table
local pt = {}
local static = {}

local function isplaintable(t)
	return type(t) == "table" and not getmetatable(t)
end

local function isarray(t)
	return type(t) == "table" and getmetatable(t) == mt
end

--- Creates a new array from passed arguments. Accepts varargs. If there is only one argument and it's a table, then
--- the function wraps it. Otherwise wraps all arguments as if it's a table.
--- @return array array Array.
local function ctor(self, ...)
	local args = {...}
	local array = {
		__data = {} -- TODO: No need in __data? Store directly in array?
	}
	local issinglearg = #args == 1 and type(args[1]) == "table"
	local data = issinglearg and args[1] or args
	if issinglearg and not isplaintable(data) then
		table.insert(array.__data, data)
	else
		for k, v in pairs(data) do
			array.__data[k] = isplaintable(v) and ctor(self, v) or v
		end
	end
	return setmetatable(array, mt)
end

--- Overloads index access to the array. Redirects all calls to the internal `__data` table field if the key is not in
--- the proto table, otherwise returns function from it.
--- @param k any An index key.
--- @return any value The value associated with the key.
function mt:__index(k)
	return pt[k] or self.__data[k]
end

--- Overloads index assigning. Redirects all calls to the internal `__data` table field.
--- @param k any An index key.
--- @param v any A new value associated with the key.
function mt:__newindex(k, v)
	self.__data[k] = isplaintable(v) and ctor(self, v) or v
end

--- Overloads `#` operator.
--- @return number len The length of the table.
function mt:__len()
	return #self.__data
end

--- Overloads calling to `pairs` function. When the array is passed to `pairs` function in for loop it simply iterates
--- inner `__data` plain table.
function mt:__pairs()
	return pairs(self.__data)
end

--- Overloads calling to `ipairs` function. When the array is passed to `ipairs` function in for loop it simply iterates
--- inner `__data` plain table.
function mt:__ipairs()
	return ipairs(self.__data)
end

--- Overloads `==` operator. Deeply compares arrays. Order of keys does not matter.
--- @return boolean rs `true` if two arrays deeply equal.
function mt:__eq(t)
	if #self ~= #t then
		return false
	end
	for k, v in pairs(self) do
		if v ~= t[k] then
			return false
		end
	end
	return true
end

--- Returns length of the table. Same as `#` operator.
--- @return number len The length of the table.
function pt:len()
	return #self.__data
end

--- Check if at least one element in the array satisfies the predicate.
--- @generic K, V
--- @param f fun(v: V, k?: K, t?: table<K, V>): boolean Predicate.
--- @return boolean rs `true` if at least one element satisfies the predicate.
function pt:some(f)
	local rs = false
	for k, v in pairs(self) do
		rs = rs or f(v, k, self)
		if rs then
			break
		end
	end
	return not not rs
end

--- Checks if every element in the array satisfies the passed predicate.
--- ```lua
--- array(1, 2, 3):every(function (v, k, self) return v > 2 and type(k) ~= "string" end)
--- ```
--- @generic K, V
--- @param f fun(v: V, k?: K, t?: table<K, V>): boolean Predicate.
--- @return boolean rs `true` if all elements satisfy the predicate.
function pt:every(f)
	local rs = true
	for k, v in pairs(self) do
		rs = rs and f(v, k, self)
		if not rs then
			break
		end
	end
	return not not rs
end

--- Filters all the elements preserving only those that pass the predicate. Returns new array.
--- @generic K, V
--- @param f fun(v: V, k?: K, t?: table<K, V>): boolean Predicate.
--- @param pk boolean Set to `true` to preserve keys, otherwise keys will be discarded. `true` by default.
--- @return array<K, V> rs New array containing every element that satisfies the predicate. Keys stay preserved.
function pt:filter(f, pk)
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

--- Applies given function to every element in the array and returns the new one with values returned by the function.
--- @generic K, V
--- @param f fun(v: V, k?: K, t?: table<K, V>): V, K Function to apply on each element. Returns new value and key.
--- @return array rs New array.
function pt:map(f)
	local rs = ctor()
	for k, v in pairs(self) do
		local newv, newk = f(v, k, self)
		if newk == nil then
			table.insert(rs.__data, newv)
		else
			rs.__data[newk] = newv
		end
	end
	return rs
end

--- Applies passed closure to all elements.
--- @generic K, V
--- @param f fun(v: V, k?: K, t?: table<K, V>) Closure.
function pt:each(f)
	for k, v in pairs(self) do
		f(v, k, self)
	end
end

--- Returns array of keys.
--- @return array rs Keys.
function pt:keys()
	local rs = ctor()
	for k in pairs(self) do
		table.insert(rs.__data, k)
	end
	return rs
end -- TODO: Preserve keys orders

--- Returns array of values discarding keys.
function pt:values()
	local rs = ctor()
	for k, v in pairs(self) do
		table.insert(rs.__data, v)
	end
	return rs
end -- TODO: Preserve keys orders

--- Joins all the elements into a string with specified separator.
--- @return string rs Joined string.
function pt:join(sep)
	local rs = ""
	local k, v
	repeat
		k, v = next(self.__data, k)
		rs = k ~= nil and rs..sep..tostring(v) or rs
	until not k
	return rs:sub(sep:len() + 1)
end

--- Swaps keys with values in the array.
--- @return array rs Array with swaped keys and values.
function pt:swap()
	local rs = ctor()
	for k, v in pairs(self) do
		rs.__data[v] = k
	end
	return rs
end

--- Makes deep clone of the table. If keys' type is reference then they won't be cloned. If values' type isn't primitive
--- nor array then they will be cloned only by reference.
--- @return array rs Cloned array.
function pt:clone()
	local rs = ctor()
	for k, v in pairs(self) do
		rs.__data[k] = isarray(v) and v:clone() or v
	end
	return rs
end

--- Checks if the array has specified key.
--- @return boolean rs `true` if the array has key.
function pt:haskey(item)
	return self[item] ~= nil
end

--- Checks if the array has specified value. Primitive types and arrays are compared by value while other reference
--- types are compared by reference.
--- @return boolean rs `true` if the array has value.
function pt:hasvalue(item)
	for k, v in pairs(self) do
		if v == item then
			return true
		end
	end
	return false
end

--- Checks if the array is empty.
--- @return boolean rs `true` if the array contains no elements.
function pt:isempty()
	return #self.__data == 0
end

--- Converts the array into ordinary Lua table.
--- @return table ts Table.
function pt:totable()
	local t = {}
	for k, v in pairs(self.__data) do
		t[k] = isarray(v) and v:totable() or v
	end
	return t
end

--- Combines two tables into one by using the first one as keys and the second one as values.
--- @param keys table|array Keys.
--- @param values table|array Values.
--- @return array rs Combined array.
function static.combine(keys, values)
	if #keys ~= #values then
		error(string.format("Keys and values tables have different lengths: %s against %s", #keys, #values))
	end
	keys = getmetatable(keys) == mt and keys.__data or keys
	values = getmetatable(values) == mt and values.__data or values
	local rs = ctor()
	for i = 1, #keys do
		rs.__data[keys[i]] = values[i]
	end
	return rs
end

function mt:__add(v) table.insert(self.__data, isplaintable(v) and ctor(self, v) or v) end
function mt:__mul() end -- TODO: Intersection
function mt:__sub() end -- TODO
function mt:__call() end -- TODO
function mt:__concat() end -- TODO
function pt:find(f) end -- TODO
function pt:findindex(f) end -- TODO
function pt:firstindexof(item) end -- TODO
function pt:lastindexof(item) end -- TODO
function pt:reducestart(f, init) end -- TODO
function pt:reduceend(f, init) end -- TODO
function pt:reverse() end -- TODO
function pt:slice(from, to) end -- TODO
function pt:sort(f) end -- TODO
function pt:addend(item) end -- TODO
function pt:delstart(item) end -- TODO
function pt:delend() end -- TODO
function pt:addstart() end -- TODO
function pt:col() end -- TODO
function pt:diff(f) end -- TODO
function pt:intersect(f) end -- TODO
function pt:first() end -- TODO
function pt:last() end -- TODO
function pt:shuffle() end -- TODO
function pt:pad() end -- TODO
function pt:uniq() end -- TODO
function pt:islist() end -- TODO
function pt:truncate() end -- TODO
function static.range(n, f) end; -- TODO

return setmetatable(static, {
	__call = ctor
})
