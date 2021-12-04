TestValues = {
	["test: values(): Calling on empty array will return empty one"] = function ()
		luaunit.assertEquals(array():values(), {})
	end;

	["test: values(): Retrieving values from list"] = function ()
		luaunit.assertItemsEquals(array("a", "b", "c"):values(), {"a", "b", "c"})
	end;

	["test: values(): Retrieving values from assoc array"] = function ()
		luaunit.assertItemsEquals(array {a = 1, b = 2, c = 3} :values(), {1, 2, 3})
	end;

	["test: values(): Retuned type is an array"] = function ()
		luaunit.assertEquals(getmetatable(array():values()), getmetatable(array()))
	end;
}