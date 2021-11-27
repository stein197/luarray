local _ENV = setmetatable({}, {
	__index = _ENV
})

proto = {
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

	totable = function (self)
		local t = {}
		for k, v in pairs(self.__data) do
			t[k] = type(v) == "table" and v:totable() or v
		end
		return t
	end;
}

metatable = {
	__index = function (self, k)
		local m = proto[k]
		return m and m or self.__data[k]
	end;

	__newindex = function (self, k, v)
		if not proto[k] and not metatable[k] then
			self.__data[k] = type(v) == "table" and getmetatable(v) ~= metatable and ctor(v) or v
		end
	end;

	__len = function (self)
		return #self.__data
	end;

	__pairs = function (self) end; -- TODO
	__add = function (self, tbl) end; -- TODO
	__sub = function (self, tbl) end; -- TODO
	__eq = function (self, tbl) end; -- TODO
	__concat = function(self, tbl) end; -- TODO
	__call = function(self, ...) end; -- TODO: Iterator?
}

function ctor(self, ...)
	local args = {...}
	local array = {
		__data = {}
	}
	local data = #args == 1 and type(args[1]) == "table" and args[1] or args
	for k, v in pairs(data) do
		array.__data[k] = type(v) == "table" and getmetatable(v) ~= metatable and ctor(v) or v
	end
	return setmetatable(array, metatable)
end

return setmetatable({
	combine = function (keys, values)

	end;
}, {
	__call = ctor
})
