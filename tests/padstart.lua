TestPadStart = {
	["test: array():padstart(0, \"d\") == {}"] = function ()
		luaunit.assertEquals(array():padstart(0, "d"), {})
	end;

	["test: array():padstart(3, \"d\") == {\"d\", \"d\", \"d\"}"] = function ()
		luaunit.assertEquals(array():padstart(3, "d"), {"d", "d", "d"})
	end;

	["test: array(\"a\"):padstart(0, \"a\") == {\"a\"}"] = function ()
		luaunit.assertEquals(array("a"):padstart(0, "a"), {"a"})
	end;

	["test: array(\"a\"):padstart(1, \"a\") == {\"a\"}"] = function ()
		luaunit.assertEquals(array("a"):padstart(1, "a"), {"a"})
	end;

	["test: array(\"a\"):padstart(3, \"d\") == {\"d\", \"d\", \"a\"}"] = function ()
		luaunit.assertEquals(array("a"):padstart(3, "d"), {"d", "d", "a"})
	end;

	["test: array(\"a\", \"b\", \"c\"):padstart(0, \"d\") == {\"a\", \"b\", \"c\"}"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):padstart(0, "d"), {"a", "b", "c"})
	end;

	["test: array(\"a\", \"b\", \"c\"):padstart(3, \"d\") == {\"a\", \"b\", \"c\"}"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):padstart(3, "d"), {"a", "b", "c"})
	end;

	["test: array(\"a\", \"b\", \"c\"):padstart(4, \"d\") == {\"d\", \"a\", \"b\", \"c\"}"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):padstart(4, "d"), {"d", "a", "b", "c"})
	end;

	["test: array(...):padstart(n, {}) wraps the plain table into the array"] = function ()
		luaunit.assertTrue(getmetatable(array():padstart(2, {})[1]) == getmetatable(array()))
	end;

	["test: array(...):padstart(n, array()) does not wrap the array"] = function ()
		local a = array()
		luaunit.assertTrue(rawequal(array():padstart(2, a)[1], a))
	end;

	["test: array(...):padstart(n, obj) does not wrap the object"] = function ()
		local o = Object()
		luaunit.assertTrue(rawequal(array():padstart(2, o)[1], o))
	end;

	["test: array(...):padstart(...) returns another array"] = function ()
		local a = array()
		luaunit.assertFalse(rawequal(a:padstart(2, 2), a))
	end;

	["test: array(...):padstart(...) does not modify the current array"] = function ()
		local a = array {"a", "b", "c"}
		a:padstart(4, "d")
		luaunit.assertEquals(a, {"a", "b", "c"})
	end;

	["test: array(...):padstart(...) only modifies __data"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):padstart(4, "d").__data, {"d", "a", "b", "c"})
	end;

	["test: array(...):padstart(-3, item) returns the same array"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):padstart(-3, "d").__data, {"a", "b", "c"})
	end;
}
