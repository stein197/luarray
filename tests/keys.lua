TestKeys = {
	["test: keys(): Calling on empty array will return empty one"] = function ()
		luaunit.assertEquals(array():keys(), {})
	end;

	["test: keys(): Retrieving numeric keys"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):keys(), {1, 2, 3})
	end;

	["test: keys(): Retrieving string keys"] = function ()
		luaunit.assertEquals(array {a = 1, b = 2, c = 3} :keys(), {"a", "b", "c"})
	end;

	["test: keys(): Retuned type is an array"] = function ()
		luaunit.assertEquals(getmetatable(array():keys()), getmetatable(array()))
	end;
}