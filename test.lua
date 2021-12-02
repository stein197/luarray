local array <const> = require ""
local luaunit <const> = require "luaunit"

local cases = {
	empty = {},
	[1] = {1},
	a = {"a"},
	[123] = {1, 2, 3},
	abc = {"a", "b", "c"},
	assoc = {a = 1, b = 2, c = 3},
	nestfirst = {{1}, 2},
	nestlast = {1, {2}}
}
local tempty = {}
local t1 = {1}
local ta = {"a"}
local t123 = {1, 2, 3}
local tabc = {"a", "b", "c"}
local tassoc = {a = 1, b = 2, c = 3}
local ae = luaunit.assertEquals
local at = luaunit.assertTrue
local af = luaunit.assertFalse
local ane = luaunit.assertNotEquals

-- TODO: Unite cases into table and go through the tables to assert equality, structure tests
TestArray = {
	["test: array() returns a table containing \"__data\" field"] = function ()
		ae(array().__data, {})
	end;

	["test: array({}) creates a wrapper around single table argument"] = function ()
		ae(array(tempty).__data, {})
		ae(array(t123).__data, {1, 2, 3})
		ae(array(tassoc).__data, {a = 1, b = 2, c = 3})
	end;

	["test: array(1) creates a wrapper around single argument"] = function ()
		ae(array(1).__data, {1})
	end;

	["test: array(1, 2, 3) creates a wrapper around arguments"] = function ()
		ae(array(1, 2, 3).__data, {1, 2, 3})
	end;

	["test: array({...}, ...) creates a wrapper around arguments where the first one is a table"] = function ()
		local a = array({1}, 2, 3)
		ae(a.__data, {{1}, 2, 3})
		ae(getmetatable(a.__data[1]), getmetatable(a))
	end;

	["test: array({}) on arrays just assigns them instead of wrapping them again"] = function ()
		local a1 = array(array(1))
		ae(a1.__data, {{1}})
		ae(getmetatable(a1.__data[1]), getmetatable(a1))
		local a2 = array(1, array(1))
		ae(a2.__data, {1, {1}})
		ae(getmetatable(a2.__data[2]), getmetatable(a2))
		local a3 = array(array(1), 1)
		ae(a3.__data, {{1}, 1})
		ae(getmetatable(a3.__data[1]), getmetatable(a3))
	end;

	["test: array(..., {...}) wraps nested tables"] = function ()
		local a = array({1, 2, {3, 4}})
		ae(a.__data, {1, 2, {3, 4}})
		ae(getmetatable(a.__data[3]), getmetatable(a))
	end;

	["test: array(): Instantiating array with metakeys will put them in internal __data field"] = function ()
		ae(array({__index = 1, len = 2}).__data, {__index = 1, len = 2})
		ae(array({__index = 1, len = 2}), {__index = 1, len = 2})
	end;

	["test: array(): Instantiating with first value of false"] = function ()
		ae(array(false, true).__data, {false, true})
		ae(array({false, true}).__data, {false, true})
	end;

	["test: __index(): Accessing by number"] = function ()
		ae(array("a")[1], "a")
	end;

	["test: __index(): Accessing by string"] = function ()
		ae(array({a = 1}).a, 1)
	end;

	["test: __index(): Accessing by complex type"] = function ()
		local k = {1}
		ae(array({[k] = "a"})[k], "a")
	end;

	["test: __index(): Access methods will return one"] = function ()
		ae(type(array({1, 2, 3}).len), "function")
	end;

	["test: __newindex(): Setting at numberic index"] = function ()
		local a = array()
		a[1] = "a"
		ae(a[1], "a")
	end;

	["test: __newindex(): Setting at string index"] = function ()
		local a = array()
		a.a = 1
		ae(a.a, 1)
	end;

	["test: __newindex(): Setting at complex type index"] = function ()
		local a = array()
		local i = {1}
		a[i] = 1
		ae(a[i], 1)
	end;

	["test: __newindex(): Setting at meta index will write the value to __data field"] = function ()
		local a = array()
		a.__index = 1
		ae(a.__data, {__index = 1})
	end;

	["test: __newindex(): Setting at proto index will write the value to __data field"] = function ()
		local a = array()
		a.len = 1
		ae(a.__data, {len = 1})
	end;

	["test: __newindex(): Setting table value will wrap it"] = function ()
		local a = array()
		a.t = {}
		ae(a.__data, {t = {}})
		ae(getmetatable(a.t), getmetatable(a))
		a = array()
		a.t = {1}
		ae(a.__data, {t = {1}})
		ae(getmetatable(a.t), getmetatable(a))
	end;

	["test: __newindex(): Setting array value will assign it"] = function ()
		local a = array()
		a.t = array()
		ae(a.t.__data, {})
		a = array()
		a.t = {1}
		ae(a.t.__data, {1})
	end;

	["test: __newindex(): Can access values through direct __data access"] = function ()
		ae(array({a = 1}).__data.a, 1)
	end;

	["test: __len(): Length of empty table is 0"] = function ()
		ae(#array(), 0)
	end;

	["test: __len()"] = function ()
		ae(#array(1, 2, 3), 3)
	end;

	["test: __add(): Adding simple values will add them into inner __data"] = function () error "Not implemented" end;
	["test: __add(): Adding a table will wrap it"] = function () error "Not implemented" end;
	["test: __add(): Adding an array will just add it"] = function () error "Not implemented" end;
	["test: __add(): Adding nil does nothing"] = function () error "Not implemented" end;

	["test: __pairs(): Iterating through an array"] = function ()
		local rs = {}
		for k, v in pairs(array("a", "b", "c")) do
			rs[k] = v
		end;
		ae(rs, {"a", "b", "c"})
	end;

	["test: __pairs(): Iterating through an empty array"] = function ()
		local rs = {}
		for k, v in pairs(array()) do
			rs[k] = v
		end;
		ae(rs, {})
	end;

	["test: __pairs(): Iterating through an associated array"] = function ()
		local rs = {}
		for k, v in pairs(array({a = 1, b = 2, c = 3})) do
			rs[k] = v
		end;
		ae(rs, {a = 1, b = 2, c = 3})
	end;

	["test: __ipairs(): Iterating through an array"] = function ()
		local rs = {}
		for k, v in ipairs(array("a", "b", "c")) do
			rs[k] = v
		end;
		ae(rs, {"a", "b", "c"})
	end;

	["test: __ipairs(): Iterating through an empty array"] = function ()
		local rs = {}
		for k, v in ipairs(array()) do
			rs[k] = v
		end;
		ae(rs, {})
	end;

	["test: __ipairs(): Iterating through an associated array"] = function ()
		local rs = {}
		for k, v in ipairs(array({a = 1, b = 2, c = 3})) do
			rs[k] = v
		end;
		ae(rs, {})
	end;

	["test: len(): Length of empty table is 0"] = function ()
		ae(array():len(), 0)
	end;

	["test: len()"] = function ()
		ae(array(1, 2, 3):len(), 3)
	end;

	["test: some(): Calling on empty array returns false"] = function ()
		af(array():some(function () return true end))
	end;

	["test: some(): Calling on array with single trythy element returns true"] = function ()
		at(array(1, 2, 3):some(function (v) return v == 2 end))
	end;

	["test: some(): Calling on array with all falsy elements return false"] = function ()
		af(array(1, 2, 3):some(function (v) return type(v) == "string" end))
	end;

	["test: some(): Calling on array with all truthy elements return true"] = function ()
		at(array(1, 2, 3):some(function (v) return type(v) ~= "string" end))
	end;

	["test: some(): Not returning from closure is considered as falsy"] = function ()
		af(array(true):some(function () end))
	end;

	["test: some(): Closure accepts value, key and table itself"] = function ()
		local value, key, tbl
		local a = array({a = 1})
		a:some(function (v, k, t)
			value = v
			key = k
			tbl = t
		end)
		ae(value, 1)
		ae(key, "a")
		ae(tbl, a)
	end;

	["test: every(): Calling on empty array returns true"] = function ()
		at(array():every(function () return false end))
	end;

	["test: every(): Calling on array with single falsy element returns false"] = function ()
		af(array(1, 2, 3):every(function (v) return v <= 2 end))
	end;

	["test: every(): Calling on array with all truthy elements return true"] = function ()
		at(array(1, 2, 3):every(function (v) return type(v) ~= "string" end))
	end;

	["test: every(): Not returning from closure is considered as falsy"] = function ()
		af(array(true):every(function () end))
	end;

	["test: every(): Closure accepts value, key and table itself"] = function ()
		local value, key, tbl
		local a = array({a = 1})
		a:every(function (v, k, t)
			value = v
			key = k
			tbl = t
		end)
		ae(value, 1)
		ae(key, "a")
		ae(tbl, a)
	end;

	["test: filter()"] = function ()
		ae(array(1, 2, 3, 4):filter(function (v) return v % 2 == 0 end), {[2] = 2, [4] = 4})
	end;

	["test: filter(): Filtering an empty array returns empty one"] = function ()
		ae(array():filter(function (v) end), {})
	end;

	["test: filter(): Filtered am array preserves keys"] = function ()
		ae(array({a = 1, b = 2, c = 3, d = 4}):filter(function (v) return v % 2 == 0 end), {b = 2, d = 4})
	end;

	["test: filter(): Filtration returns new array"] = function ()
		local a = array(1, 2, 3)
		ane(a:filter(function (v) return v % 2 == 2 end), a)
	end;

	["test: filter(): Filtration does not modify the initial array"] = function ()
		local a = array(1, 2, 3)
		a:filter(function (v) return v % 2 == 2 end)
		ae(a, array(1, 2, 3))
	end;

	["test: filter(): Closure accepts all arguments"] = function ()
		local value, key, tbl
		local a = array({a = 1})
		a:filter(function (v, k, t)
			value = v
			key = k
			tbl = t
		end)
		ae(value, 1)
		ae(key, "a")
		at(tbl == a)
	end;

	["test: filter(): Filtration preserves keys by default"] = function ()
		ae(array(1, 2, 3, 4):filter(function (v) return v % 2 == 0 end), {[2] = 2, [4] = 4})
	end;

	["test: filter(): Filtration preserves keys when \"preservekeys\" is explicitly true"] = function ()
		ae(array(1, 2, 3, 4):filter(function (v) return v % 2 == 0 end, true), {[2] = 2, [4] = 4})
	end;

	["test: filter(): Filtration discards keys when \"preservekeys\" is explicitly false"] = function ()
		ae(array(1, 2, 3, 4):filter(function (v) return v % 2 == 0 end, false), {2, 4})
	end;

	["test: filter(): Returned value is an array"] = function ()
		ae(getmetatable(array():filter(function () end)), getmetatable(array()))
	end;

	["test: each(): Closure accepts all arguments"] = function ()
		local value, key, tbl
		local a = array({a = 1})
		a:each(function (v, k, t)
			value = v
			key = k
			tbl = t
		end)
		ae(value, 1)
		ae(key, "a")
		at(tbl == a)
	end;

	["test: combine(): Combining empty tables returns empty one"] = function ()
		ae(array.combine({}, {}), {})
	end;

	["test: combine(): Combining tables with mismatching lengths raises an error"] = function ()
		luaunit.assertErrorMsgContains("Keys and values tables have different lengths: 1 against 2", function ()
			array.combine({1}, {1, 2})
		end)
	end;

	["test: combine(): Combining tables"] = function ()
		ae(array.combine({"a", "b", "c"}, {1, 2, 3}), {a = 1, b = 2, c = 3})
	end;

	["test: combine(): Combining tables with one element"] = function ()
		ae(array.combine({"a"}, {1}), {a = 1})
	end;

	["test: combine(): Combining empty arrays returns empty one"] = function ()
		ae(array.combine(array(), array()), {})
	end;

	["test: combine(): Combining arrays with mismatching lengths raises an error"] = function ()
		luaunit.assertErrorMsgContains("Keys and values tables have different lengths: 1 against 2", function ()
			array.combine(array(1), array(1, 2))
		end)
	end;

	["test: combine(): Combining arrays"] = function ()
		ae(array.combine(array {"a", "b", "c"}, array {1, 2, 3}), {a = 1, b = 2, c = 3})
	end;

	["test: combine(): Combining arrays with one element"] = function ()
		ae(array.combine(array {"a"}, array {1}), {a = 1})
	end;

	["test: combine(): Combining array keys with table values"] = function ()
		ae(array.combine(array {"a", "b", "c"}, {1, 2, 3}), {a = 1, b = 2, c = 3})
	end;

	["test: combine(): Combining table keys with array values"] = function ()
		ae(array.combine({"a", "b", "c"}, array {1, 2, 3}), {a = 1, b = 2, c = 3})
	end;

	["test: combine(): Returned type is an array"] = function ()
		ae(getmetatable(array.combine({1}, {1})), getmetatable(array()))
	end;

	["test: keys(): Calling on empty array will return empty one"] = function ()
		ae(array():keys(), {})
	end;

	["test: keys(): Retrieving numeric keys"] = function ()
		ae(array("a", "b", "c"):keys(), {1, 2, 3})
	end;

	["test: keys(): Retrieving string keys"] = function ()
		ae(array {a = 1, b = 2, c = 3} :keys(), {"a", "b", "c"})
	end;

	["test: keys(): Retuned type is an array"] = function ()
		ae(getmetatable(array():keys()), getmetatable(array()))
	end;

	["test: values(): Calling on empty array will return empty one"] = function ()
		ae(array():values(), {})
	end;

	["test: values(): Retrieving values from list"] = function ()
		ae(array("a", "b", "c"):values(), {"a", "b", "c"})
	end;

	["test: values(): Retrieving values from assoc array"] = function ()
		ae(array {a = 1, b = 2, c = 3} :values(), {1, 2, 3})
	end;

	["test: values(): Retuned type is an array"] = function ()
		ae(getmetatable(array():values()), getmetatable(array()))
	end;

	["test: swap(): Swapping empty array returns empty one"] = function ()
		ae(array():swap(), {})
	end;

	["test: swap(): Swapping does not modifies an initial array"] = function ()
		local a = array {a = 1, b = 2, c = 3}
		a:swap()
		ae(a, {a = 1, b = 2, c = 3})
	end;

	["test: swap(): Swapping returns new array"] = function ()
		local a = array {a = 1, b = 2, c = 3}
		ane(a:swap(), a)
	end;

	["test: swap(): Returned type is an array"] = function ()
		ae(getmetatable(array():swap()), getmetatable(array()))
	end;

	["test: swap()"] = function ()
		ae(array {a = 1, b = 2, c = 3}: swap(), {[1] = "a", [2] = "b", [3] = "c"})
	end;

	["test: isempty(): Empty table is empty"] = function ()
		at(array():isempty())
	end;

	["test: isempty(): Table containing elements is not empty"] = function ()
		af(array(1):isempty())
		af(array(1, 2, 3):isempty())
	end;
}

os.exit(luaunit.run())
