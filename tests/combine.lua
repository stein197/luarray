TestCombine = {
	["test: combine(): Combining empty tables returns empty one"] = function ()
		luaunit.assertEquals(array.combine({}, {}), {})
	end;

	["test: combine(): Combining tables with mismatching lengths raises an error"] = function ()
		luaunit.assertErrorMsgContains("Keys and values tables have different lengths: 1 against 2", function ()
			array.combine({1}, {1, 2})
		end)
	end;

	["test: combine(): Combining tables"] = function ()
		luaunit.assertEquals(array.combine({"a", "b", "c"}, {1, 2, 3}), {a = 1, b = 2, c = 3})
	end;

	["test: combine(): Combining tables with one element"] = function ()
		luaunit.assertEquals(array.combine({"a"}, {1}), {a = 1})
	end;

	["test: combine(): Combining empty arrays returns empty one"] = function ()
		luaunit.assertEquals(array.combine(array(), array()), {})
	end;

	["test: combine(): Combining arrays with mismatching lengths raises an error"] = function ()
		luaunit.assertErrorMsgContains("Keys and values tables have different lengths: 1 against 2", function ()
			array.combine(array(1), array(1, 2))
		end)
	end;

	["test: combine(): Combining arrays"] = function ()
		luaunit.assertEquals(array.combine(array {"a", "b", "c"}, array {1, 2, 3}), {a = 1, b = 2, c = 3})
	end;

	["test: combine(): Combining arrays with one element"] = function ()
		luaunit.assertEquals(array.combine(array {"a"}, array {1}), {a = 1})
	end;

	["test: combine(): Combining array keys with table values"] = function ()
		luaunit.assertEquals(array.combine(array {"a", "b", "c"}, {1, 2, 3}), {a = 1, b = 2, c = 3})
	end;

	["test: combine(): Combining table keys with array values"] = function ()
		luaunit.assertEquals(array.combine({"a", "b", "c"}, array {1, 2, 3}), {a = 1, b = 2, c = 3})
	end;

	["test: combine(): Returned type is an array"] = function ()
		luaunit.assertEquals(getmetatable(array.combine({1}, {1})), getmetatable(array()))
	end;
}
