TestPadEnd = {
	["test: array():padend(0, \"d\") == {}"] = function ()
		luaunit.assertEquals(array():padend(0, "d"), {})
	end;

	["test: array():padend(3, \"d\") == {\"d\", \"d\", \"d\"}"] = function ()
		luaunit.assertEquals(array():padend(3, "d"), {"d", "d", "d"})
	end;

	["test: array(\"a\"):padend(0, \"a\") == {\"a\"}"] = function ()
		luaunit.assertEquals(array("a"):padend(0, "a"), {"a"})
	end;

	["test: array(\"a\"):padend(1, \"a\") == {\"a\"}"] = function ()
		luaunit.assertEquals(array("a"):padend(1, "a"), {"a"})
	end;

	["test: array(\"a\"):padend(3, \"d\") == {\"d\", \"d\", \"a\"}"] = function ()
		luaunit.assertEquals(array("a"):padend(3, "d"), {"a", "d", "d"})
	end;

	["test: array(\"a\", \"b\", \"c\"):padend(0, \"d\") == {\"a\", \"b\", \"c\"}"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):padend(0, "d"), {"a", "b", "c"})
	end;

	["test: array(\"a\", \"b\", \"c\"):padend(3, \"d\") == {\"a\", \"b\", \"c\"}"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):padend(3, "d"), {"a", "b", "c"})
	end;

	["test: array(\"a\", \"b\", \"c\"):padend(4, \"d\") == {\"d\", \"a\", \"b\", \"c\"}"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):padend(4, "d"), {"a", "b", "c", "d"})
	end;

	["test: array(...):padend(n, {}) wraps the plain table into the array"] = function ()
		luaunit.assertTrue(getmetatable(array():padend(2, {})[1]) == getmetatable(array()))
	end;

	["test: array(...):padend(n, array()) does not wrap the array"] = function ()
		local a = array()
		luaunit.assertTrue(rawequal(array():padend(2, a)[1], a))
	end;

	["test: array(...):padend(n, obj) does not wrap the object"] = function ()
		local o = Class()
		luaunit.assertTrue(rawequal(array():padend(2, o)[1], o))
	end;

	["test: array(...):padend(...) returns another array"] = function ()
		local a = array()
		luaunit.assertFalse(rawequal(a:padend(2, 2), a))
	end;

	["test: array(...):padend(...) does not modify the current array"] = function ()
		local a = array {"a", "b", "c"}
		a:padend(4, "d")
		luaunit.assertEquals(a, {"a", "b", "c"})
	end;

	["test: array(...):padend(...) only modifies __data"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):padend(4, "d").__data, {"a", "b", "c", "d"})
	end;

	["test: array(...):padend(-3, item) returns the same array"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):padend(-3, "d").__data, {"a", "b", "c"})
	end;
}
