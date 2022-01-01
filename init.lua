-- TODO: Generalize use of zero indices
-- TODO: Restrict out of bounds indices and raise an error?
local mt = {}

--- @generic T
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

local function isarray(t)
	return type(t) == "table" and getmetatable(t) == mt
end

local function shift(self, offset)
	for i = offset < 0 and -offset + 1 or self.__len, offset < 0 and self.__len + 1 or 1, offset < 0 and 1 or -1 do
		self.__data[i + offset], self.__data[i] = self.__data[i], nil
	end
	self.__len = self.__len + offset
end

local function collapseat(self, i)
	i = normalizeidx(self.__len, i)
	if i == nil or i < 0 or self.__len < i then
		return
	elseif i == 1 then
		shift(self, -1)
	else
		-- if i < 0
		if i ~= self.__len then
			for j = i, self.__len do
				self.__data[j] = self.__data[j + 1]
			end
		end
		self.__data[self.__len] = nil
		self.__len = self.__len - 1
	end
end

local function reduce(self, f, init, isstart)
	local rs = ternary(init == nil, ternary(isstart, self[1], self[#self]), init)
	for i = init == nil and (isstart and 2 or #self - 1) or (isstart and 1 or #self), isstart and #self or 1, isstart and 1 or -1 do
		rs = f(rs, i, self[i])
	end
	return rs
end

local function indexof(self, elt, i, isstart)
	for j = (i == nil or i == 0) and (isstart and 1 or self.__len) or normalizeidx(self.__len, i), isstart and self.__len or 1, isstart and 1 or -1 do
		if elt == self[j] then
			return j
		end
	end
	return -1
end

local function pad(self, len, elt, isstart)
	local rs = self:clone()
	local diff = len - self.__len
	if diff <= 0 then
		return rs
	end
	if isstart then
		shift(rs, diff)
	end
	for i = isstart and 1 or #self + 1, isstart and diff or len do
		rs.__data[i] = elt
	end
	rs.__len = len
	return rs
end

--- Overloads index access to the array. Works the same way as an accessing an arbitrary table but in addition to that
--- it's also possible to access elements with negative indices. In such cases the counting starts from the end of the
--- array.
--- @param i number An index.
--- @return any elt The element associated with the index.
function mt:__index(i)
	return pt[i] or self.__data[normalizeidx(#self.__data, i)]
end

--- Overloads index assigning. Works the same way as an accessing an arbitrary table but in addition to that it's also
--- possible to assign elements at negative indices. In such cases the counting starts from the end of the array. Does
--- nothing if there's an attempt to assign at non numeric index.
--- @param i number Index at which assign the element.
--- @param elt any Value to assign.
function mt:__newindex(i, elt)
	local oldlen = self.__len
	i = normalizeidx(oldlen, i)
	if not i then
		return
	elseif i <= 0 then
		local offset = -i + 1
		i = 1
		self.__len = oldlen + offset
		-- TODO: Use collapse function
		for j = oldlen, 1, -1 do
			self.__data[j + offset], self.__data[j] = self.__data[j], nil
		end
	end
	self.__data[i] = elt
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
	rs:each(function (i, elt) rs.__data[i] = ternary(i <= #self, self.__data[i], a.__data[i - #self]) end)
	return rs
end

--- Overloads `==` operator. Deeply compares arrays.
--- @param t array An array to compare with.
--- @return boolean rs `true` if two arrays are deeply equal.
function mt:__eq(t)
	return isarray(t) and self.__len == t.__len and self:every(function (i, elt) return elt == t.__data[i] end)
end

--- Performs an intersection between two arrays. Same as `intersect` method. Raises an error if there's an attempt to
--- intersect with non array. Preserves an order of the first array.
--- @param a array Array to intersect with.
--- @return array rs Array with elements that both arrays contain.
function mt:__mul(a)
	if not isarray(a) then
		error(string.format("Unable to intersect with %s: only arrays allowed", type(a)))
	end
	local rs = array()
	self:each(function (i, elt) return a:contains(elt) and rs:addend(elt) end)
	return rs
end

--- Performs an union between two arrays. Same as `unite` method. Raises an error if there's an attempt to unite with
--- non array. Preserves an order of the first array.
--- @param a array Array to unite with.
--- @return array ts Array that contains elements from both arrays.
function mt:__add(a)
	if not isarray(a) then
		error(string.format("Unable to unite with %s: only arrays allowed", type(a)))
	end
	local rs = self:clone()
	a:each(function (i, elt) return not self:contains(elt) and rs:addend(elt) end)
	return rs
end

--- Returns length of the table. Same as `#` operator.
--- @return number len The length of the table.
function pt:len()
	return self.__len
end

--- Returns the first entry that satisfies a predicate.
--- @param f fun(i: number, elt: any): boolean Predicate.
--- @return number i Index of the element that satisfies predicate.
--- @return any elt Value that satisfies predicate.
function pt:find(f)
	for i = 1, self.__len do
		if f(i, self.__data[i]) then
			return i, self.__data[i]
		end
	end
	return -1
end

--- Check if at least one element in the array satisfies the predicate.
--- @param f fun(i: number, elt: any): boolean Predicate.
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
--- @param f fun(i: number, elt: any): boolean Predicate.
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
--- @param f fun(i: number, elt: any): boolean Predicate.
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

--- Applies given function to every element in the array and returns the new one with elements returned by the function.
--- @generic T Type of element the array contains.
--- @param f fun(i: number, elt: T): T Function to apply on each element. Returns new element.
--- @return array rs New array.
function pt:map(f)
	local rs = alloc(self.__len)
	self:each(function (i, elt) rs.__data[i] = f(i, elt) end)
	return rs
end

--- Applies passed closure to all elements.
--- @generic T Type of element the array contains.
--- @param f fun(i: number, elt: T) Closure.
function pt:each(f)
	for i = 1, self.__len do
		f(i, self.__data[i])
	end
end

--- Makes a clone of the table.
--- @param deep boolean Nested arrays will be deeply cloned if this element is set to `true`. By default `false`. Other
---                     methods that use cloning method performs a shallow one.
--- @return array rs Cloned array.
function pt:clone(deep)
	return self:map(function (i, elt) return deep and isarray(elt) and elt:clone() or elt end)
end

--- Sorts the array.
--- @generic T Type of elements the array contains.
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

--- Returns the first index and element of the array.
--- @generic T Type of elements the array contains.
--- @return number i The first index of the array. Usually 1 but it could be -1 if the array is empty.
--- @return T elt The first element of the array.
function pt:first()
	return self:isempty() and -1 or 1, self.__data[1]
end

--- Returns the last index and element of the array.
--- @generic T Type of elements the array contains.
--- @return number i The last index of the array. Usually equals to the length of the array but it could be -1 if the
---                  array is empty.
--- @return T elt The last element of the array.
function pt:last()
	return self:isempty() and -1 or self.__len, self.__data[self.__len]
end

--- Joins all the elements into a string with specified separator.
--- @return string s Joined string.
function pt:join(sep)
	return self:reducestart(function (rs, i, elt) return elt == nil and rs or (i == 1 and tostring(elt) or rs..sep..tostring(elt)) end, "")
end

--- Applies the given function to each element from the start to the end in the array returning an accumulate element.
--- @generic T Type of element the array contains.
--- @generic V Type of an accumulated element.
--- @param f fun(rs: V, i: number, elt: T): V Function to apply.
--- @param init? V A element to start with.
--- @return V rs Accumulated element.
function pt:reducestart(f, init)
	return reduce(self, f, init, true)
end

--- Applies the given function to each element from the end to the start in the array returning an accumulate element.
--- @generic T Type of element the array contains.
--- @generic V Type of an accumulated element.
--- @param f fun(rs: V, i: number, elt: T): V Function to apply.
--- @param init? V A element to start with.
--- @return V rs Accumulated element.
function pt:reduceend(f, init)
	return reduce(self, f, init, false)
end

--- Checks if the array has specified element. Primitive types and arrays are compared by element while other reference
--- types are compared by reference.
--- @generic T Type of element the array contains.
--- @param elt T Element against which to test.
--- @return boolean rs `true` if the array has element.
function pt:contains(elt)
	return self:some(function (i, val) return val == elt end)
end

--- Removes duplicates from the array.
--- @return array rs Array without duplicates.
function pt:uniq()
	local rs = array()
	for i = 1, self.__len do
		if not rs:contains(self.__data[i]) then
			rs.__len = rs.__len + 1
			rs.__data[rs.__len] = self.__data[i]
		end
	end
	return rs
end

--- Reverses the order of elements in the array. Works correctly only with numeric keys.
--- @return array rs Reversed array.
function pt:reverse()
	return self:map(function (i, elt) return self.__data[self.__len - i + 1] end)
end

--- Slices the part of the array. Raises an error if argument `to` is less than `from`.
--- @param from number Start index of the sliced array. If negative index is supplied then the real index is calculated
---                    relative to the end of the array. 0 is considered as 1. 1 by default.
--- @param to number End index of the sliced array. If negative index is supplied then the real index is calculated
---                      relative to the end of the array. 0 is considered as #self. #self by default.
--- @return array rs Slice of the array.
function pt:slice(from, to)
	if self.__len == 0 then
		return array()
	end
	from = (from == nil or from == 0) and 1 or from
	to = (to == nil or to == 0) and self.__len or to
	local normfrom = normalizeidx(self.__len, from)
	local normto = normalizeidx(self.__len, to)
	normfrom = ternary(normfrom <= 0, 1, ternary(normfrom > self.__len, self.__len + 1, normfrom))
	normto = ternary(normto <= 0, 1, ternary(normto > self.__len, self.__len, normto))
	if normfrom > self.__len then
		return array()
	end
	if normto < normfrom then
		error(string.format("Cannot slice the array from %d (%d) to %d (%d) index: %d is lesser than %d", from, normfrom, to, normto, normto, normfrom))
	end
	return array(table.unpack(self.__data, normfrom, normto))
end

--- Pads the start of the array with the given element to the specified length.
--- @generic T Type of element the array contains.
--- @param len number To which length pad the array.
--- @param elt T What item to add.
--- @return array rs Padded array.
function pt:padstart(len, elt)
	return pad(self, len, elt, true)
end

--- Pads the end of the array with the given element to the specified length.
--- @generic T Type of element the array contains.
--- @param len number To which length pad the array.
--- @param elt T What item to add.
--- @return array rs Padded array.
function pt:padend(len, elt)
	return pad(self, len, elt, false)
end

--- Checks if the array is empty.
--- @return boolean rs `true` if the array contains no elements.
function pt:isempty()
	return self.__len == 0
end

--- Converts the array into ordinary Lua table.
--- @param deep boolean Set to true for converting nested arrays into table too. `false` by default.
--- @return table ts Table.
function pt:totable(deep)
	local t = {}
	self:each(function (i, elt) t[i] = deep and isarray(elt) and elt:totable() or elt end)
	return t
end

--- Returns the first index at which the given element can be found.
--- @generic T Type of elements the array contains.
--- @param i? number At which index to start searching. 1 by default
--- @param elt T Value to find.
--- @return number i First index at which the element found, otherwise -1.
function pt:firstindexof(elt, i)
	return indexof(self, elt, i, true)
end

--- Returns the last index at which the given element can be found.
--- @generic T Type of elements the array contains.
--- @param i? number At which index to start searching. #self by default
--- @param elt T Value to find.
--- @return number i Last index at which the element found, otherwise -1.
function pt:lastindexof(elt, i)
	return indexof(self, elt, i, false)
end

--- Adds an element to the start of the array shifting all the elements to the end.
--- @generic T Type of elements the array contains
--- @param elt T Element to add.
function pt:addstart(elt)
	shift(self, 1)
	self.__data[1] = elt
end

--- Adds an element to the end of the array.
--- @generic T Type of elements the array contains.
--- @param elt T Element to add.
function pt:addend(elt)
	self.__len = self.__len + 1
	self.__data[self.__len] = elt
end

--- Deletes an element at the specified index.
--- @generic T Type of elements the array contains.
--- @param i number Index at which an element will be deleted. Can be negative.
--- @return T rs Deleted element.
function pt:del(i)
	if self.__len == 0 then
		return
	end
	i = normalizeidx(self.__len, i)
	local elt = self.__data[i]
	collapseat(self, i)
	return elt
end

--- Deletes an element from the start.
--- @generic T Type of elements the array contains.
--- @return T rs Deleted element.
function pt:delstart()
	return self:del(1)
end

--- Deletes an element from the end.
--- @generic T Type of elements the array contains.
--- @return T rs Deleted element.
function pt:delend()
	return self:del(self.__len)
end

--- Performs an intersection between two arrays. Same as `*` operator. Raises an error if there's an attempt to
--- intersect with non array. Preserves an order of the first array.
--- @param a array Array to intersect with.
--- @return array rs Array with elements that both arrays contain.
function pt:intersect(a)
	return self * a
end

--- Performs an union between two arrays. Same as `+` operator. Raises an error if there's an attempt to unite with non
--- array. Preserves an order of the first array.
--- @param a array Array to unite with.
--- @return array ts Array that contains elements from both arrays.
function pt:unite(a)
	return self + a
end

-- function mt:__pairs() end -- TODO
function mt:__sub(a) end -- TODO: Substraction
function pt:subtract(a) end
function pt:addbefore(i, elt) end -- TODO: Use internal shift/insertat function
function pt:addafter(i, elt) end -- TODO: Use internal shift/insertat function

return array
