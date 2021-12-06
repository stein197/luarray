TestSort = {
	["test: Sorting an empty array returns empty one"] = function ()
		luaunit.assertEquals(array():sort(), {})
	end;

	["test: Sorting an array with single item does nothing"] = function ()
		luaunit.assertEquals(array("a"):sort(), {"a"})
	end;

	["test: Sorting an array with multiple items"] = function ()
		luaunit.assertEquals(array("a", "c", "b"):sort(), {"a", "b", "c"})
	end;

	["test: Sorting an array with multiple items with custom closure"] = function ()
		luaunit.assertEquals(array("a", "c", "b"):sort(function (a, b) return a > b end), {"c", "b", "a"})
	end;

	["test: Sorting does not modify the current array"] = function ()
		local a = array("a", "c", "b")
		a:sort()
		luaunit.assertEquals(a, {"a", "c", "b"})
	end;

	["test: Sorting returns a new array"] = function ()
		local a = array("a", "c", "b")
		luaunit.assertFalse(rawequal(a:sort(), a))
	end;
}
