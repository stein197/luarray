Test__concat = {
	["test: Concatenating with an empty table does nothing"] = function ()
		luaunit.assertEquals(array()..{}, {})
	end;

	["test: Concatenating with an empty array does nothing"] = function ()
		luaunit.assertEquals(array()..array(), {})
	end;

	["test: Concatenating with a table with single element"] = function ()
		luaunit.assertEquals(array()..{1}, {1})
		luaunit.assertEquals(array(1)..{2}, {1, 2})
	end;

	["test: Concatenating with a array with single element"] = function ()
		luaunit.assertEquals(array()..array {1}, {1})
		luaunit.assertEquals(array(1)..array {2}, {1, 2})
	end;

	["test: Concatenating with a table"] = function ()
		luaunit.assertEquals(array(1, 2, 3)..{4, 5, f = 6}, {1, 2, 3, 4, 5, f = 6})
	end;

	["test: Concatenating with a array"] = function ()
		luaunit.assertEquals(array(1, 2, 3)..array {4, 5, f = 6}, {1, 2, 3, 4, 5, f = 6})
	end;

	["test: Concatenating with a table containing table will wrap it"] = function ()
		local inner = {d = 4}
		luaunit.assertEquals(array(1, 2, 3)..{inner}, array({1, 2, 3, {d = 4}}))
		luaunit.assertFalse(rawequal(inner, (array(1, 2, 3)..{inner})[4]))
	end;

	["test: Concatenating with a table containing array will clone it"] = function ()
		local inner = array {d = 4}
		luaunit.assertEquals(array(1, 2, 3)..{inner}, array(1, 2, 3, {d = 4}))
		luaunit.assertFalse(rawequal(inner, (array(1, 2, 3)..{inner})[4]))
	end;

	["test: Concatenating with a table containing object will assign the reference"] = function ()
		local a = Object()
		luaunit.assertEquals(array(1, 2, 3)..{a}, {1, 2, 3, a})
		luaunit.assertTrue(rawequal(a, (array(1, 2, 3)..{a})[4]))
	end;

	["test: Concatenating with an array containing table will wrap it"] = function ()
		local inner = {d = 4}
		luaunit.assertEquals(array(1, 2, 3)..array {inner}, array(1, 2, 3, {d = 4}))
		luaunit.assertFalse(rawequal(inner, (array(1, 2, 3)..array {inner})[4]))
	end;

	["test: Concatenating with an array containing array will clone it"] = function ()
		local inner = array {d = 4}
		luaunit.assertEquals(array(1, 2, 3)..array {inner}, array(1, 2, 3, {d = 4}))
		luaunit.assertFalse(rawequal(inner, (array(1, 2, 3)..array {inner})[4]))
	end;

	["test: Concatenating with an array containing object will assign the reference"] = function ()
		local a = Object()
		luaunit.assertEquals(array(1, 2, 3)..array {a}, {1, 2, 3, a})
		luaunit.assertTrue(rawequal(a, (array(1, 2, 3)..array {a})[4]))
	end;

	["test: Concatenating with an object raises an error"] = function ()
		luaunit.assertError(function () return array(1, 2, 3)..Object() end)
	end;

	["test: Concatenating with primitive raises an error"] = function ()
		luaunit.assertError(function () return array(1, 2, 3)..1 end)
	end;

	["test: Concatenating with nil raises an error"] = function ()
		luaunit.assertError(function () return array(1, 2, 3)..nil end)
	end;

	["test: Concatenating does not modify the current array"] = function ()
		local a = array(1, 2, 3)
		local b = a..{3, 4}
		luaunit.assertEquals(a, {1, 2, 3})
	end;

	["test: Concatenating returns a new array"] = function ()
		local a = array(1, 2, 3)
		local b = a..{3, 4}
		luaunit.assertFalse(rawequal(a, b))
	end;

	["test: Concatenating only modifies __data inner field"] = function ()
		luaunit.assertEquals((array(1, 2, 3)..{1}).__data, {1, 2, 3, 1})
	end;

	["test: Elements with duplicating numeric indeces will be concatenated without overriding"] = function ()
		luaunit.assertEquals(array(1, 2, 3)..array("a", "b", "c"), {1, 2, 3, "a", "b", "c"})
	end;

	["test: Elements with duplicating non-numeric indeces will be overrided"] = function ()
		luaunit.assertEquals(array {a = 1, b = 2, c = 3}..array {c = 4, d = 4}, {a = 1, b = 2, c = 4, d = 4})
	end;
}