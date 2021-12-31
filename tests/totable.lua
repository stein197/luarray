TestToTable = {
	["test: Should return an empty table when the array is empty"] = function ()
		luaunit.assertEquals(array():totable(), {})
	end;

	["test: Should convert nested tables when the argument is set to true"] = function ()
		local c = array("c")
		local a = array("a", "b", c)
		luaunit.assertEquals(a:totable(true), {"a", "b", {"c"}})
		luaunit.assertFalse(rawequal(a:totable(true)[3], c))
	end;

	["test: Should not convert nested tables when the argument is set to false"] = function ()
		local c = array("c")
		local a = array("a", "b", c)
		luaunit.assertEquals(a:totable(false), {"a", "b", c})
		luaunit.assertTrue(rawequal(a:totable(false)[3], c))
	end;

	["test: Should not convert nested tables when the argument is not provided"] = function ()
		local c = array("c")
		local a = array("a", "b", c)
		luaunit.assertEquals(a:totable(), {"a", "b", c})
		luaunit.assertTrue(rawequal(a:totable()[3], c))
	end;

	["test: Should not convert objects when the argument is set to true"] = function ()
		local o = Object()
		local rs = array("a", "b", o):totable(true)
		luaunit.assertEquals(rs, {"a", "b", o})
		luaunit.assertTrue(getmetatable(rs[3]) == getmetatable(Object()))
	end;

	["test: Should not convert objects when the argument is set to false"] = function ()
		local o = Object()
		local rs = array("a", "b", o):totable(false)
		luaunit.assertEquals(rs, {"a", "b", o})
		luaunit.assertTrue(getmetatable(rs[3]) == getmetatable(Object()))
	end;

	["test: Should not convert objects when the argument is not provided"] = function ()
		local o = Object()
		local rs = array("a", "b", o):totable()
		luaunit.assertEquals(rs, {"a", "b", o})
		luaunit.assertTrue(getmetatable(rs[3]) == getmetatable(Object()))
	end;

	["test: Should return an array equal to the original one when converting to table and back to array"] = function ()
		local a = array("a", "b", "c")
		luaunit.assertTrue(array(table.unpack(a:totable())) == a)
	end;

	["test: Should return a plain table"] = function ()
		luaunit.assertNil(getmetatable(array():totable()))
	end;

	["test: Should return correct result when there are nils"] = function ()
		luaunit.assertEquals(array("a", nil, "c"):totable(), {"a", nil, "c"})
	end;

	["test: Should not modify self"] = function ()
		local a = array("a", "b", "c")
		a:totable()
		luaunit.assertEquals(a.__data, {"a", "b", "c"})
	end;
}
