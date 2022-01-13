TestSort = {
	["test: Should return an empty array when sorting an empty one"] = function ()
		luaunit.assertEquals(array():sort().__data, {})
	end;

	["test: Should return copy of the array when sorting an array with single item"] = function ()
		luaunit.assertEquals(array("a"):sort().__data, {"a"})
	end;

	["test: Should return correct result when sorting an array with multiple items and omitted sorting function"] = function ()
		luaunit.assertEquals(array("a", "c", "b"):sort().__data, {"a", "b", "c"})
	end;

	["test: Should return correct result when sorting an array with multiple items and custom sorting function"] = function ()
		luaunit.assertEquals(array("a", "c", "b"):sort(function (a, b) return a > b end).__data, {"c", "b", "a"})
	end;

	["test: Should not modify the current array"] = function ()
		local a = array("a", "c", "b")
		a:sort()
		luaunit.assertEquals(a.__data, {"a", "c", "b"})
	end;

	["test: Should return a new array"] = function ()
		local a = array("a", "b", "c")
		luaunit.assertFalse(rawequal(a:sort(), a))
	end;

	["test: Should return an instance of array"] = function ()
		luaunit.assertTrue(rawequal(getmetatable(array()), getmetatable(array():sort())))
	end;

	["test: Should return the same result when sorting already sorted array"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):sort().__data, {"a", "b", "c"})
	end;

	["test: Should return the same result when sorting an array of nils"] = function ()
		luaunit.assertEquals(array(nil, nil, nil):sort().__data, {nil, nil, nil})
	end;
}
