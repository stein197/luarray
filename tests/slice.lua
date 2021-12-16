TestSlice = {
	["test: array():slice() == {}"] = function ()
		luaunit.assertEquals(array():slice(), {})
	end;

	["test: array():slice(0) == {}"] = function ()
		luaunit.assertEquals(array():slice(0), {})
	end;

	["test: array():slice(0, 0) == {}"] = function ()
		luaunit.assertEquals(array():slice(0, 0), {})
	end;

	["test: array():slice(0, 1) == {}"] = function ()
		luaunit.assertEquals(array():slice(0, 1), {})
	end;

	["test: array(\"a\"):slice() == {\"a\"}"] = function ()
		luaunit.assertEquals(array("a"):slice(), {"a"})
	end;

	["test: array(\"a\"):slice(0) == {\"a\"}"] = function ()
		luaunit.assertEquals(array("a"):slice(0), {"a"})
	end;

	["test: array(\"a\"):slice(1) == {\"a\"}"] = function ()
		luaunit.assertEquals(array("a"):slice(1), {"a"})
	end;

	["test: array(\"a\"):slice(-1) == {\"a\"}"] = function ()
		luaunit.assertEquals(array("a"):slice(-1), {"a"})
	end;

	["test: array(\"a\"):slice(2) -> error"] = function ()
		luaunit.assertError(function () array("a"):slice(2) end)
	end;

	["test: array(\"a\"):slice(-2) == {\"a\"}"] = function ()
		luaunit.assertEquals(array("a"):slice(-2), {"a"})
	end;

	["test: array(\"a\"):slice(0, 0) == {}"] = function ()
		luaunit.assertEquals(array("a"):slice(0, 0), {})
	end;

	["test: array(\"a\"):slice(1, 1) == {\"a\"}"] = function ()
		luaunit.assertEquals(array("a"):slice(1, 1), {"a"})
	end;

	["test: array(\"a\"):slice(-1, -1) == {\"a\"}"] = function ()
		luaunit.assertEquals(array("a"):slice(-1, -1), {"a"})
	end;

	["test: array(\"a\"):slice(1, -1) == {\"a\"}"] = function ()
		luaunit.assertEquals(array("a"):slice(1, -1), {"a"})
	end;

	["test: array(\"a\"):slice(-1, 1) == {\"a\"}"] = function ()
		luaunit.assertEquals(array("a"):slice(-1, 1), {"a"})
	end;

	["test: array(\"a\"):slice(2, -2) -> error"] = function ()
		luaunit.assertError(function () array("a"):slice(2, -2) end)
	end;

	["test: array({{...}}):slice(...) copies the inner array"] = function ()
		local a = array({a = 1}, 2, 3)
		luaunit.assertFalse(rawequal(a[1], a:slice()[1]))
	end;

	["test: array(obj):slice(...) copies only reference"] = function ()
		local a = array(Object(), 2, 3)
		luaunit.assertTrue(rawequal(a[1], a:slice()[1]))
	end;

	["test: array(\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"):slice() == {\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"}"] = function ()
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):slice(), {"a", "b", "c", "d", "e", "f"})
	end;

	["test: array(\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"):slice(0) == {\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"}"] = function ()
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):slice(0), {"a", "b", "c", "d", "e", "f"})
	end;

	["test: array(\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"):slice(1) == {\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"}"] = function ()
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):slice(1), {"a", "b", "c", "d", "e", "f"})
	end;

	["test: array(\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"):slice(3) == {\"c\", \"d\", \"e\", \"f\"}"] = function ()
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):slice(3), {"c", "d", "e", "f"})
	end;

	["test: array(\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"):slice(-3) == {\"d\", \"e\", \"f\"}"] = function ()
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):slice(-3), {"d", "e", "f"})
	end;

	["test: array(\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"):slice(-8) == {\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"}"] = function ()
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):slice(-8), {"a", "b", "c", "d", "e", "f"})
	end;

	["test: array(\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"):slice(8) -> error"] = function ()
		luaunit.assertError(function () array("a", "b", "c", "d", "e", "f"):slice(8) end)
	end;

	["test: array(\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"):slice(0, 0) == {}"] = function ()
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):slice(0, 0), {})
	end;

	["test: array(\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"):slice(1, 4) == {\"a\", \"b\", \"c\", \"d\"}"] = function ()
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):slice(1, 4), {"a", "b", "c", "d"})
	end;

	["test: array(\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"):slice(-5, 5) == {\"b\", \"c\", \"d\", \"e\"}"] = function ()
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):slice(-5, 5), {"b", "c", "d", "e"})
	end;

	["test: array(\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"):slice(5, 3) -> error"] = function ()
		luaunit.assertError(function () array("a", "b", "c", "d", "e", "f"):slice(5, 3) end)
	end;

	["test: array(\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"):slice(1, 6) == {\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"}"] = function ()
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):slice(1, 6), {"a", "b", "c", "d", "e", "f"})
	end;

	["test: array(\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"):slice(-6, -1) == {\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"}"] = function ()
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):slice(-6, -1), {"a", "b", "c", "d", "e", "f"})
	end;

	["test: array(...):slice(...) does not modify the current array"] = function ()
		local a = array(1, 2, 3)
		a:slice(1, 2)
		luaunit.assertEquals(a, {1, 2, 3})
	end;

	["test: array(...):slice(...) returns a new array"] = function ()
		local a = array(1, 2, 3)
		luaunit.assertFalse(rawequal(a, a:slice()))
	end;

}
