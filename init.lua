--[[
	Closures that accept key and value should accept them in that order only
	Naming conventions:
	- k: key (for ordinary tables)
	- i: index
	- v: value
	- f: function
	- t: table
	- o: object
	- a: array
	- s: string
	- n: number
	- rs: result
	- len: length
]]
-- TODO: Annotate types to help IDE
-- TODO: Restrict array keys to numbers only
-- TODO: Make direct call to clone() deep, indirect calls inside methods make shallow
-- TODO: Add deep flag to totable() function
-- TODO: Make generic docblocks
local mt = {}

--- @class array
--- @field private __data table
--- @field private __len number
local pt = {}

--- Creates a new array from passed arguments. Does not wrap nested tables into arrays.
--- @vararg any Elements from which to create an array.
--- @return array a Array.
local function array(...)
	return setmetatable({__data = {...}, __len = select("#", ...)}, mt)
end

--- @generic T
--- @param cond boolean
--- @param iftrue T
--- @param iffalse T
--- @return T rs
local function ternary(cond, iftrue, iffalse)
	if cond then
		return iftrue
	else
		return iffalse
	end
end

local function alloc(len)
	return setmetatable({__data = {}, __len = len}, mt)
end

local function normalizeidx(len, i)
	return i ~= 0 and type(i) == "number" and (i < 0 and len + i + 1 or i) or nil
end

local function isplaintable(t)
	return type(t) == "table" and not getmetatable(t)
end

local function isarray(t)
	return type(t) == "table" and getmetatable(t) == mt
end

local function reduce(self, f, init, isstart)
	local rs = ternary(init == nil, ternary(isstart, self[1], self[#self]), init)
	for i = init == nil and (isstart and 2 or #self - 1) or (isstart and 1 or #self), isstart and #self or 1, isstart and 1 or -1 do
		rs = f(rs, i, self[i])
	end
	return rs
end

local function indexof(self, v, i, isstart)
	for j = i and i or (isstart and 1 or self.__len), isstart and self.__len or 1, isstart and 1 or -1 do
		if v == self[j] then
			return j
		end
	end
	return -1
end

local function pad(self, len, v, isstart)
	local rs, oldlen = self:clone(), #self
	local diff = len - oldlen
	if diff <= 0 then
		return rs
	end
	if isstart then
		for i = oldlen, 1, -1 do
			rs.__data[i + diff] = rs.__data[i]
		end
	end
	local from = isstart and 1 or #self + 1
	local to = isstart and diff or len
	for i = from, to do
		rs.__data[i] = isplaintable(v) and array(v) or v
	end
	return rs
end

--- Overloads index access to the array. Works the same way as an accessing an arbitrary table but in addition to that
--- it's also possible to access elements with negative indices. In such cases the counting starts from the end of the
--- array.
--- @param i number An index.
--- @return any v The value associated with the index.
function mt:__index(i)
	return pt[i] or self.__data[normalizeidx(#self.__data, i)]
end

--- Overloads index assigning. Works the same way as an accessing an arbitrary table but in addition to that it's also
--- possible to assign elements at negative indices. In such cases the counting starts from the end of the array. Does
--- nothing if there's an attempt to assign at non numeric index.
--- @param i number Index at which assign the value.
--- @param v any Value to assign.
function mt:__newindex(i, v)
	local oldlen = self.__len
	i = normalizeidx(oldlen, i)
	if not i then
		return
	elseif i <= 0 then
		local offset = -i + 1
		i = 1
		self.__len = oldlen + offset
		for j = oldlen, 1, -1 do
			self.__data[j + offset], self.__data[j] = self.__data[j], nil
		end
	end
	self.__data[i] = v
	self.__len = i > self.__len and i or self.__len
end

--- Overloads `#` operator. Same as `len()` method.
--- @return number len The length of the table.
function mt:__len()
	return self.__len
end

--- Concatenates the array with another one returning a new one. Passing another types will raise an error.
--- @param a array Array to concatenate.
--- @return array rs New array which is a result of concatenating the current array with another one.
function mt:__concat(a)
	if not isarray(a) then
		error(string.format("Cannot concatenate array with %s", type(a)))
	end
	local rs = alloc(self.__len + a.__len)
	rs:each(function (i, v) rs.__data[i] = ternary(i <= #self, self.__data[i], a.__data[i - #self]) end)
	return rs
end

--- Overloads `==` operator. Deeply compares arrays.
--- @param t array An array to compare with.
--- @return boolean rs `true` if two arrays are deeply equal.
function mt:__eq(t)
	return isarray(t) and self.__len == t.__len and self:every(function (i, v) return v == t.__data[i] end)
end

--- Returns length of the table. Same as `#` operator.
--- @return number len The length of the table.
function pt:len()
	return self.__len
end

--- Returns the first entry that satisfies a predicate.
--- @param f fun(i: number, v: any): boolean Predicate.
--- @return number i Index of the value that satisfies predicate.
--- @return any v Value that satisfies predicate.
function pt:find(f)
	for i = 1, self.__len do
		if f(i, self.__data[i]) then
			return i, self.__data[i]
		end
	end
	return -1
end

--- Check if at least one element in the array satisfies the predicate.
--- @param f fun(i: number, v: any): boolean Predicate.
--- @return boolean rs `true` if at least one element satisfies the predicate.
function pt:some(f)
	for i = 1, self.__len do
		if f(i, self.__data[i]) then
			return true
		end
	end
	return false
end

--- Checks if every element in the array satisfies the passed predicate.
--- @param f fun(i: number, v: any): boolean Predicate.
--- @return boolean rs `true` if all elements satisfy the predicate.
function pt:every(f)
	for i = 1, self.__len do
		if not f(i, self.__data[i]) then
			return false
		end
	end
	return true
end

--- Filters all the elements preserving only those that pass the predicate. Returns new array.
--- @param f fun(i: number, v: any): boolean Predicate.
--- @return array rs New array containing every element that satisfies the predicate. Keys stay preserved.
function pt:filter(f)
	local rs = array()
	for i = 1, self.__len do
		if f(i, self.__data[i]) then
			rs.__len = rs.__len + 1
			rs.__data[rs.__len] = self.__data[i]
		end
	end
	return rs
end

--- Applies given function to every element in the array and returns the new one with values returned by the function.
--- @generic T Type of value the array contains.
--- @param f fun(i: number, v: T): T Function to apply on each element. Returns new value.
--- @return array rs New array.
function pt:map(f)
	local rs = alloc(self.__len)
	self:each(function (i, v) rs.__data[i] = f(i, v) end)
	return rs
end

--- Applies passed closure to all elements.
--- @generic T Type of value the array contains.
--- @param f fun(i: number, v: T) Closure.
function pt:each(f)
	for i = 1, self.__len do
		f(i, self.__data[i])
	end
end

--- Makes a clone of the table.
--- @param deep boolean Nested arrays will be deeply cloned if this value is set to `true`. By default `false`. Other
---                     methods that use cloning method performs a shallow one.
--- @return array rs Cloned array.
function pt:clone(deep)
	deep = ternary(deep == nil, false, deep)
	return self:map(function (i, v) return deep and isarray(v) and v:clone() or v end)
end

--- Sorts the array.
--- @generic T Type of values the array contains.
--- @param f? fun(a: T, b: T): boolean Closure that should return true if `a` should come before `b`.
--- @return array rs Sorted array.
--- @see table.sort
function pt:sort(f)
	local rs = self:clone()
	table.sort(rs.__data, f)
	return rs
end

--- Shuffles the array. Works only with arrays with numeric keys.
--- @return array rs Suffled array.
function pt:shuffle()
	local rs = self:clone()
	for i = 1, rs.__len do
		local j = math.random(i, rs.__len)
		rs.__data[i], rs.__data[j] = rs.__data[j], rs.__data[i]
	end
	return rs
end

--- Returns the first index and value of the array.
--- @generic T Type of values the array contains.
--- @return number i The first index of the array. Usually 1 but it could be -1 if the array is empty.
--- @return T v The first value of the array.
function pt:first()
	return self:empty() and -1 or 1, self.__data[1]
end

--- Returns the last index and value of the array.
--- @generic T Type of values the array contains.
--- @return number i The last index of the array. Usually equals to the length of the array but it could be -1 if the
---                  array is empty.
--- @return T v The last value of the array.
function pt:last()
	return self:empty() and -1 or self.__len, self.__data[self.__len]
end

--- Joins all the elements into a string with specified separator.
--- @return string s Joined string.
function pt:join(sep)
	return self:reducestart(function (rs, i, v) return v == nil and rs or (i == 1 and tostring(v) or rs..sep..tostring(v)) end, "")
end

--- Applies the given function to each element from the start to the end in the array returning an accumulate value.
--- @generic T Type of value the array contains.
--- @generic V Type of an accumulated value.
--- @param f fun(rs: V, i: number, v: T): V Function to apply.
--- @param init? V A value to start with.
--- @return V rs Accumulated value.
function pt:reducestart(f, init)
	return reduce(self, f, init, true)
end

--- Applies the given function to each element from the end to the start in the array returning an accumulate value.
--- @generic T Type of value the array contains.
--- @generic V Type of an accumulated value.
--- @param f fun(rs: V, i: number, v: T): V Function to apply.
--- @param init? V A value to start with.
--- @return V rs Accumulated value.
function pt:reduceend(f, init)
	return reduce(self, f, init, false)
end

--- Checks if the array has specified value. Primitive types and arrays are compared by value while other reference
--- types are compared by reference.
--- @return boolean rs `true` if the array has value.
function pt:contains(v)
	return self:some(function (i, val) return val == v end)
end

-- TODO: BOUNDARY BETWEEN NEW AND OLD IMPLEMENTATION --

--- Removes duplicates from the array.
--- @return array rs Array with no duplicates.
function pt:uniq()
	local rs = array()
	for k, v in pairs(self) do
		if not rs:contains(v) then
			if type(k) == "number" then
				table.insert(rs.__data, v) -- TODO: Add check for nils, add an ability to preserve gaps by nil
			end
		end
	end
	return rs
end

--- Reverses the order of values in the array. Works correctly only with numeric keys.
--- @return array rs Reversed array.
function pt:reverse()
	local rs = array()
	local len = self:len()
	for i = 1, len do
		local v = self.__data[#self - i + 1]
		rs.__data[i] = isarray(v) and v:clone() or v
	end
	return rs
end

--- Slices the part of the array. Works only with arrays with numeric keys.
--- @param from number Start index of the sliced array. If negative index is supplied then the real index is calculated
---                    relative to the end of the array.
--- @param to number End index of the sliced array. If negative index is supplied then the real index is calculated
---                    relative to the end of the array.
--- @return array rs Slice of the array.
function pt:slice(from, to)
	local len = #self.__data
	from = from == nil and 0 or from < 0 and len + from + 1 or from
	to = to == nil and len or to < 0 and len + to + 1 or to
	if to < from then
		error(string.format("Cannot slice the array from %d to %d index. %d is lesser than %d", from, to, to, from))
	end
	local rs = array()
	for i = from, to do
		table.insert(rs.__data, isarray(self.__data[i]) and self.__data[i]:clone() or self.__data[i])
	end
	return rs
end

--- Pads the array at the start with the given value to the given length.
--- @param len number To which length pad the array.
--- @param v any What item to add.
--- @return array rs Padded array.
function pt:padstart(len, v)
	return pad(self, len, v, true)
end

--- Pads the array at the end with the given value to the given length.
--- @param len number To which length pad the array.
--- @param v any What item to add.
--- @return array rs Padded array.
function pt:padend(len, v)
	return pad(self, len, v, false)
end

--- Checks if the array is empty.
--- @return boolean rs `true` if the array contains no elements.
function pt:empty()
	return self.__len == 0
end

--- Converts the array into ordinary Lua table.
--- @return table ts Table.
function pt:totable(deep)
	deep = ternary(deep == nil, false, deep)
	local t = {}
	self:each(function (i, v) t[i] = deep and isarray(v) and v:totable() or v end)
	return t
end

--- Returns the first index at which the given value can be found.
--- @generic V
--- @param v V Value to find.
--- @param i number At which index to start searching.
--- @return number i First index at which the value found, otherwise -1.
function pt:firstindexof(v, i)
	return indexof(self, v, i, true)
end

--- Returns the last index at which the given value can be found.
--- @generic V
--- @param v V Value to find.
--- @param i number At which index to start searching.
--- @return number i Last index at which the value found, otherwise -1.
function pt:lastindexof(v, i)
	return indexof(self, v, i)
end

function mt:__band() end -- TODO: Intersection
function mt:__bor() end -- TODO: Union
function mt:__call() end -- TODO: for v in array
function pt:addbefore(item) end -- TODO
function pt:addafter(item) end -- TODO
function pt:delat(i) end -- TODO
function pt:addstart(item) end -- TODO
function pt:delstart(item) end -- TODO
function pt:addend(item) end -- TODO
function pt:delend(item) end -- TODO
function pt:diff(f) end -- TODO
function pt:intersect(f) end -- TODO
function pt:union(f) end -- TODO

return array
