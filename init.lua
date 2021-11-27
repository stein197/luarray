local prototype = {
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
}

local metatable = {
	__index = prototype;
	__newindex = function (self, k, v) end; -- TODO
	__len = function (self) end; -- TODO
	__pairs = function (self) end; -- TODO
	__add = function (self, tbl) end; -- TODO
	__sub = function (self, tbl) end; -- TODO
	__eq = function (self, tbl) end; -- TODO
	__concat = function(self, tbl) end; -- TODO
	__call = function(self, ...) end; -- TODO: Iterator?
}

local function combine() end

return function (...)
	local args = {...}
	return setmetatable({
		-- TODO: Deep clone instead of assigning?
		__data = #args == 1 and type(args[1]) == "table" and args[1] or args
	}, metatable)
end
