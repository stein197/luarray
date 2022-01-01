Test__add = {
	-- TODO: Add tests for duplicates
	["test: Should return an empty array after uniting with an empty one when the array is empty"] = function ()
		luaunit.assertEquals((array() + array()).__data, {})
		luaunit.assertEquals(array():unite(array()).__data, {})
	end;

	["test: Should always return an array equal to the one of original when one of the arrays is empty"] = function ()
		luaunit.assertEquals((array() + array("a")).__data, {"a"})
		luaunit.assertEquals(array("a"):unite(array()).__data, {"a"})
	end;

	["test: Should return an array equal to one of the initial ones when one of them is a subset of another"] = function ()
		luaunit.assertEquals((array("a", "b", "c") + array("a", "b", "c", "d", "e", "f")).__data, {"a", "b", "c", "d", "e", "f"})
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):unite(array("a", "b", "c")).__data, {"a", "b", "c", "d", "e", "f"})
	end;

	["test: Should return correct result"] = function ()
		luaunit.assertEquals((array("a", "b", "c", "d") + array("f", "e", "d", "c")).__data, {"a", "b", "c", "d", "f", "e"})
		luaunit.assertEquals(array("f", "e", "d", "c"):unite(array("a", "b", "c", "d")).__data, {"f", "e", "d", "c", "a", "b"})
	end;

	["test: Should return correct result with nil when both arrays contain nil"] = function ()
		luaunit.assertEquals((array(nil, "b", "c") + array("c", nil, "d")).__data, {nil, "b", "c", "d"})
		luaunit.assertEquals(array("c", nil, "d"):unite(array(nil, "b", "c")).__data, {"c", nil, "d", "b"})
	end;

	["test: Should return correct result with nil when both arrays contain and one of them has only one element"] = function ()
		luaunit.assertEquals((array(nil, "b", "c") + array(nil)).__data, {nil, "b", "c"})
		luaunit.assertEquals(array(nil):unite(array(nil, "b", "c")).__data, {nil, "b", "c"})
	end;

	["test: Should return correct result both arrays don't have overlapping elements"] = function ()
		luaunit.assertEquals((array("a", "b", "c") + array("d", "e", "f")).__data, {"a", "b", "c", "d", "e", "f"})
		luaunit.assertEquals(array("d", "e", "f"):unite(array("a", "b", "c")).__data, {"d", "e", "f", "a", "b", "c"})
	end;

	["test: Should return an array equal to itself after uniting with itself"] = function ()
		local a = array("a", "b", "c")
		luaunit.assertEquals((a + a).__data, {"a", "b", "c"})
		luaunit.assertEquals(a:unite(a).__data, {"a", "b", "c"})
	end;

	["test: Should add only one element to the array when the array to unite with has duplicates"] = function ()
		luaunit.assertEquals((array("a") + array("a", "b", "b")).__data, {"a", "b"})
	end;

	["test: Should preserve duplicates when the array has duplicates"] = function ()
		luaunit.assertEquals(array("a", "b", "b"):unite(array("a", "b")).__data, {"a", "b", "b"})
	end;

	["test: Should raise an error when there's an attempt to unite with plain table"] = function ()
		luaunit.assertErrorMsgContains("Unable to unite with table: only arrays allowed", function () return array() + {} end)
	end;

	["test: Should return a new array"] = function ()
		local a = array()
		luaunit.assertFalse(rawequal(a + array(), a))
	end;

	["test: Should return a new array after uniting with itself"] = function ()
		local a = array()
		luaunit.assertFalse(rawequal(a + a, a))
	end;

	["test: Should not modify itself"] = function ()
		local a = array("a", "b", "c")
		a:unite(array("c", "d", "e"))
		luaunit.assertEquals(a.__data, {"a", "b", "c"})
	end;
}