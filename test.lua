local array = require ""
local luaunit = require "luaunit"

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
}

os.exit(luaunit.run())
