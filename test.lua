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

-- TODO: Unite cases into table and go through the tables to assert equality
TestArray = {
	["test: array() returns a table containing \"__data\" field"] = function ()
		ae(array().__data, {})
	end;

	["test: array({}) creates a wrapper around single table argument"] = function ()
		ae(array(tempty), {__data = {}})
		ae(array(t123), {__data = {1, 2, 3}})
		ae(array(tassoc), {__data = {a = 1, b = 2, c = 3}})
	end;

	["test: array(1) creates a wrapper around single argument"] = function ()
		ae(array(1), {__data = {1}})
	end;

	["test: array(1, 2, 3) creates a wrapper around arguments"] = function ()
		ae(array(1, 2, 3), {__data = {1, 2, 3}})
	end;

	["test: array({...}, ...) creates a wrapper around arguments where the first one is a table"] = function ()
		ae(array({1}, 2, 3), {__data = {{__data = {1}}, 2, 3}})
	end;

	["test: array({}) on arrays just assigns them instead of wrapping them again"] = function ()
		ae(array(array(1)), {__data = {{__data = {1}}}})
		ae(array(1, array(1)), {__data = {1, {__data = {1}}}})
		ae(array(array(1), 1), {__data = {{__data = {1}}, 1}})
	end;

	["test: array(..., {...}) wraps nested tables"] = function ()
		ae(array({1, 2, {3, 4}}), {__data = {1, 2, {__data = {3, 4}}}})
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
		ae(a, {__data = {__index = 1}})
	end;

	["test: __newindex(): Setting at proto index will write the value to __data field"] = function ()
		local a = array()
		a.len = 1
		ae(a, {__data = {len = 1}})
	end;

	["test: __newindex(): Setting table value will wrap it"] = function ()
		local a = array()
		a.t = {}
		ae(a, {__data = {t = {__data = {}}}})
		a = array()
		a.t = {1}
		ae(a, {__data = {t = {__data = {1}}}})
	end;

	["test: __newindex(): Setting array value will assign it"] = function ()
		local a = array()
		a.t = array()
		ae(a.t, {__data = {}})
		a = array()
		a.t = {1}
		ae(a.t, {__data = {1}})
	end;

}

os.exit(luaunit.run())
