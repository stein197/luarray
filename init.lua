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

local function checkop(arg, op)
	if not isarray(arg) then
		error(string.format("Unable to %s with %s: only arrays allowed", op, type(arg)))
	end
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
	end
	if i ~= self.__len then
		for j = i, self.__len do
			self.__data[j] = self.__data[j + 1]
		end
	end
	self.__data[self.__len] = nil
	self.__len = self.__len - 1
end

local function add(self, i, elt, isbefore)
	i = normalizeidx(self.__len, i)
	if not i or i <= 0 or self.__len < i then
		return
	end
	i = isbefore and i or i + 1
	for j = self.__len, i, -1 do
		self.__data[j + 1], self.__data[j] = self.__data[j], nil
	end
	self.__len = self.__len + 1
	self.__data[i] = elt
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
--- it's also possible to access elements with negative indices. In such cases the counting starts from the end of the.
--- array.
--- @generic T Type of elements the array contains.
--- @param i number An index.
--- @return T elt The element associated with the index.
function mt:__index(i)
	return pt[i] or self.__data[normalizeidx(self.__len, i)]
end

--- Overloads index assigning. Works the same way as an assigning in arbitrary table but in addition to that it's also
--- possible to assign elements at negative indices. In such cases the counting starts from the end of the array. Does.
--- nothing if there's an attempt to assign at non numeric or 0 index.
--- @generic T Type of elements the array contains.
--- @param i number Index at which to assign the element.
--- @param elt T Element to assign.
function mt:__newindex(i, elt)
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
	checkop(a, "concatenate")
	local rs = alloc(self.__len + a.__len)
	rs:each(function (i) rs.__data[i] = ternary(i <= #self, self.__data[i], a.__data[i - #self]) end)
	return rs
end

--- Overloads `==` operator. Deeply compares arrays.
--- @param t array An array to compare with.
--- @return boolean rs `true` if two arrays are deeply equal.
function mt:__eq(t)
	return isarray(t) and self.__len == t.__len and self:every(function (i, elt) return elt == t.__data[i] end)
end

--- Performs intersection between two arrays. Same as `intersect` method. Raises an error if there's an attempt to
--- intersect with non array. Preserves an order of elements of the first array.
--- @param a array Array to intersect with.
--- @return array rs Array with elements that both arrays contain.
function mt:__mul(a)
	checkop(a, "intersect")
	local rs = array()
	self:each(function (i, elt) return a:contains(elt) and rs:addend(elt) end)
	return rs
end

--- Performs union between two arrays. Same as `unite` method. Raises an error if there's an attempt to unite with non
--- array. Preserves an order of elements of the first array.
--- @param a array Array to unite with.
--- @return array rs Array that contains elements from both arrays.
function mt:__add(a)
	checkop(a, "unite")
	local rs = self:clone()
	a:each(function (i, elt) return not rs:contains(elt) and rs:addend(elt) end)
	return rs
end

--- Performs subtraction between arrays. Same as `subtract` method. Raises an error if there's an attempt to subtract
--- on/from non array.
--- @param a array Array to subtract.
--- @return array rs Array whose elements were subtracted with another one.
function mt:__sub(a)
	checkop(a, "subtract")
	local rs = self:clone()
	-- TODO: Replace with less heavy algorithm - shift all elements at once instead of shifting in each loop
	for i = 1, a.__len do
		while true do
			local idx = rs:firstindexof(a.__data[i])
			if idx < 0 then
				break
			end
			collapseat(rs, idx)
		end
	end
	return rs
end

--- Overloads call to `pairs()` function. Returns an iterator through the entire array including nils.
function mt:__pairs()
	local i = 0
	return function ()
		i = i + 1
		if self.__len < i then
			return nil, nil
		end
		return i, self.__data[i]
	end
end

--- Returns length of the table. Same as `#` operator.
--- @return number len The length of the table.
function pt:len()
	return self.__len
end

--- Returns the first entry that satisfies a predicate.
--- @generic T Type of elements the array contains.
--- @param f fun(i: number, elt: T): boolean Predicate.
--- @return number i Index of the element that satisfies predicate.
--- @return any elt Element that satisfies predicate.
function pt:find(f)
	for i = 1, self.__len do
		if f(i, self.__data[i]) then
			return i, self.__data[i]
		end
	end
	return -1
end

--- Check if at least one element in the array satisfies the predicate.
--- @generic T Type of elements the array contains.
--- @param f fun(i: number, elt: T): boolean Predicate.
--- @return boolean rs `true` if at least one element satisfies the predicate.
function pt:some(f)
	for i = 1, self.__len do
		if f(i, self.__data[i]) then
			return true
		end
	end
	return false
end

--- Checks if every element in the array satisfies the predicate.
--- @generic T Type of elements the array contains.
--- @param f fun(i: number, elt: T): boolean Predicate.
--- @return boolean rs `true` if all elements satisfy the predicate.
function pt:every(f)
	for i = 1, self.__len do
		if not f(i, self.__data[i]) then
			return false
		end
	end
	return true
end

--- Filters all the elements preserving only those that pass the predicate. Returns a new array.
--- @generic T Type of elements the array contains.
--- @param f fun(i: number, elt: T): boolean Predicate.
--- @return array rs New array containing every element that satisfies the predicate.
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

--- Applies given function to every element in the array and returns a new one with elements returned by the function.
--- @generic T Type of element the array contains.
--- @generic U Type of elements the new array will contain.
--- @param f fun(i: number, elt: T): U Function to apply to each element.
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
--- @param deep boolean Nested arrays will be deeply cloned if this element is set to `true`. `false` by default. Other
---                     methods that use this method perform a shallow one.
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

--- Shuffles the array.
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
--- @return number i The first index of the array. -1 if the array is empty.
--- @return T elt The first element of the array. nil if the array is empty.
function pt:first()
	return self:isempty() and -1 or 1, self.__data[1]
end

--- Returns the last index and element of the array.
--- @generic T Type of elements the array contains.
--- @return number i The last index of the array. -1 if the array is empty.
--- @return T elt The last element of the array. nil if the array is empty.
function pt:last()
	return self:isempty() and -1 or self.__len, self.__data[self.__len]
end

--- Joins all the elements into a string with specified separator.
--- @return string s Joined string.
function pt:join(sep)
	return self:reducestart(function (rs, i, elt) return elt == nil and rs or (i == 1 and tostring(elt) or rs..sep..tostring(elt)) end, "")
end

--- Applies the given function to each element from the start to the end in the array returning an accumulate element.
--- @generic T Type of elements the array contains.
--- @generic U Type of an accumulated element.
--- @param f fun(rs: U, i: number, elt: T): U Function to apply.
--- @param init? U An element to start with.
--- @return U rs Accumulated element.
function pt:reducestart(f, init)
	return reduce(self, f, init, true)
end

--- Applies the given function to each element from the end to the start in the array returning an accumulate element.
--- @generic T Type of element the array contains.
--- @generic U Type of an accumulated element.
--- @param f fun(rs: U, i: number, elt: T): U Function to apply.
--- @param init? U An element to start with.
--- @return U rs Accumulated element.
function pt:reduceend(f, init)
	return reduce(self, f, init, false)
end

--- Checks if the array has specified element. Primitive types and arrays are compared by value and others by reference.
--- @generic T Type of elements the array contains.
--- @param elt T Element against which to test.
--- @return boolean rs `true` if the array contains the element.
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

--- Reverses the order of elements in the array.
--- @return array rs Reversed array.
function pt:reverse()
	return self:map(function (i) return self.__data[self.__len - i + 1] end)
end

--- Slices a part of the array. Raises an error if the argument `to` is less than `from`.
--- @param from number Start index of the sliced array. If negative index is supplied then the real index is calculated
---                    relative to the end of the array. 1 by default.
--- @param to number End index of the sliced array. If negative index is supplied then the real index is calculated
---                      relative to the end of the array. #self by default.
--- @return array rs Slice of the array.
function pt:slice(from, to)
	if self.__len == 0 then
		return array()
	end
	local normfrom = normalizeidx(self.__len, from) or 1
	local normto = normalizeidx(self.__len, to) or self.__len
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
--- @generic T Type of elements the array contains.
--- @param len number Length to which pad the array.
--- @param elt T Item to add.
--- @return array rs Padded array.
function pt:padstart(len, elt)
	return pad(self, len, elt, true)
end

--- Pads the end of the array with the given element to the specified length.
--- @generic T Type of elements the array contains.
--- @param len number Length to which pad the array.
--- @param elt T Item to add.
--- @return array rs Padded array.
function pt:padend(len, elt)
	return pad(self, len, elt, false)
end

--- Checks if the array is empty.
--- @return boolean rs `true` if the array does not contain elements.
function pt:isempty()
	return self.__len == 0
end

--- Converts the array into an ordinary Lua table.
--- @param deep boolean Set to `true` for converting nested arrays into table too. `false` by default.
--- @return table ts Table.
function pt:totable(deep)
	local t = {}
	self:each(function (i, elt) t[i] = deep and isarray(elt) and elt:totable() or elt end)
	return t
end

--- Returns the first index at which the given element can be found.
--- @generic T Type of elements the array contains.
--- @param elt T Element to find.
--- @param i? number Index at which to start searching. 1 by default.
--- @return number i First index at which the element found, otherwise -1.
function pt:firstindexof(elt, i)
	return indexof(self, elt, i, true)
end

--- Returns the last index at which the given element can be found.
--- @generic T Type of elements the array contains.
--- @param elt T Element to find.
--- @param i? number Index at which to start searching. #self by default.
--- @return number i Last index at which the element found, otherwise -1.
function pt:lastindexof(elt, i)
	return indexof(self, elt, i, false)
end

--- Adds an element to the start of the array shifting all the elements to the end.
--- @generic T Type of elements the array contains.
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

--- Deletes an element at the specified index shifting rightmost elements to the left.
--- @generic T Type of elements the array contains.
--- @param i number Index at which an element will be deleted.
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

--- Deletes an element from the start shifting all elements to the left.
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

--- Performs intersection between two arrays. Same as `*` operator. Raises an error if there's an attempt to intersect
--- with non array. Preserves an order of elements of the first array.
--- @param a array Array to intersect with.
--- @return array rs Array with elements that both arrays contain.
function pt:intersect(a)
	return self * a
end

--- Performs union between two arrays. Same as `+` operator. Raises an error if there's an attempt to unite with non
--- array. Preserves an order of elements of the first array.
--- @param a array Array to unite with.
--- @return array rs Array that contains elements from both arrays.
function pt:unite(a)
	return self + a
end

--- Performs subtraction between arrays. Same as `-` operator. Raises an error if there's an attempt to subtract
--- on/from non array.
--- @param a array Array to subtract.
--- @return array rs Array whose elements were subtracted with another one.
function pt:subtract(a)
	return self - a
end

--- Splits the array into chunks of the same size. Raises an error if `size` is less than 1.
--- @param size number Size of chunks.
--- @return array rs Chunked array.
function pt:chunk(size)
	if size < 1 then
		error(string.format("Unable to chunk array with %i size of length: the size cannot be less than 1", size))
	end
	local len = math.ceil(self.__len / size)
	local rs = alloc(len)
	for i = 1, len do
		rs.__data[i] = self:slice(size * (i - 1) + 1, size * i)
	end
	return rs
end

--- Flattens the array to the specified depth.
--- @param depth number Max depth at which flatten the array. 1 by default.
--- @return array rs Flattened array. Returns the same array when `depth` is 0.
function pt:flat(depth)
	depth = depth == nil and 1 or depth
	local rs = array()
	for i = 1, self.__len do
		if isarray(self.__data[i]) and depth > 0 then
			self.__data[i]:flat(depth - 1):each(function (_, elt) rs:addend(elt) end)
		else
			rs:addend(self.__data[i])
		end
	end
	return rs
end

--- Returns the only element that distinct from others by any parameter. Could be used for retrieving min or max values.
--- @generic T Type of elements the array contains.
--- @param f fun(a: T, b: T): T Comparison function. Should return the highest element.
--- @return T rs The only element that has the most precedence over others.
function pt:only(f)
	return self:reducestart(function (rs, i, elt) return f(rs, elt) end)
end

--- Adds an element before specified index. Does nothing if the index is out of bounds.
--- @generic T Type of elements the array contains.
--- @param i number Index before which add the element.
--- @param elt T An element to add.
function pt:addbefore(i, elt)
	add(self, i, elt, true)
end

--- Adds an element after specified index. Does nothing if the index is out of bounds.
--- @generic T Type of elements the array contains.
--- @param i number Index after which add the element.
--- @param elt T An element to add.
function pt:addafter(i, elt)
	add(self, i, elt, false)
end

return array
