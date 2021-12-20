TestToTable = {
	["test: totable(): Converting empty array returns empty table"] = function ()
		luaunit.assertEquals(array():totable(), {})
	end;

	["test: totable(): Converting nested arrays"] = function ()
		luaunit.assertEquals(array(array(1), {2}), {{1}, {2}})
	end;

	["test: totable(): Converting does not destructures inner tables with different metatables"] = function ()
		local o = Object()
		local rs = array(1, 2, o):totable()
		luaunit.assertEquals(rs, {1, 2, o})
		luaunit.assertTrue(getmetatable(rs[3]) == getmetatable(Object()))
		luaunit.assertEquals(rs[3]:method(), "string")
	end;

	["test: totable(): Converting to table and back to an array returns the initial array"] = function ()
		local a = {a = 1, b = 2, c = {d = 4}}
		luaunit.assertEquals(array(array(a):totable()), a)
	end;

	["test: totable(): Returned value is a plain table"] = function ()
		luaunit.assertNil(getmetatable(array():totable()))
	end;

	["test: totable()"] = function ()
		luaunit.assertEquals(array(1, 2, {3, {d = 4}}):totable(), {1, 2, {3, {d = 4}}})
	end;
}
