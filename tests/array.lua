TestArray = {
	["test: array(): Created array contains \"__data\" field"] = function ()
		luaunit.assertEquals(array().__data, {})
	end;

	["test: array(): Passing single plain table wraps it"] = function ()
		luaunit.assertEquals(array({}), {})
		luaunit.assertEquals(array(1, 2, 3), {1, 2, 3})
		luaunit.assertEquals(array({a = 1, b = 2, c = 3}), {a = 1, b = 2, c = 3})
	end;

	["test: array(1) creates a wrapper around single argument"] = function ()
		luaunit.assertEquals(array(1).__data, {1})
	end;

	["test: array(1, 2, 3) creates a wrapper around arguments"] = function ()
		luaunit.assertEquals(array(1, 2, 3).__data, {1, 2, 3})
	end;

	["test: array({...}, ...) creates a wrapper around arguments where the first one is a table"] = function ()
		local a = array({1}, 2, 3)
		luaunit.assertEquals(a.__data, {{1}, 2, 3})
		luaunit.assertTrue(getmetatable(a.__data[1]) == getmetatable(a))
	end;

	["test: array({}) on arrays just assigns them instead of wrapping them again"] = function ()
		local a1 = array(array(1))
		luaunit.assertEquals(a1.__data, {{1}})
		luaunit.assertTrue(getmetatable(a1.__data[1]) == getmetatable(a1))
		local a2 = array(1, array(1))
		luaunit.assertEquals(a2.__data, {1, {1}})
		luaunit.assertTrue(getmetatable(a2.__data[2]) == getmetatable(a2))
		local a3 = array(array(1), 1)
		luaunit.assertEquals(a3.__data, {{1}, 1})
		luaunit.assertTrue(getmetatable(a3.__data[1]) == getmetatable(a3))
	end;

	["test: array(..., {...}) wraps nested tables"] = function ()
		local a = array({1, 2, {3, 4}})
		luaunit.assertEquals(a.__data, {1, 2, {3, 4}})
		luaunit.assertTrue(getmetatable(a.__data[3]) == getmetatable(a))
	end;

	["test: array(): Instantiating array with metakeys will put them in internal __data field"] = function ()
		luaunit.assertEquals(array({__index = 1, len = 2}).__data, {__index = 1, len = 2})
		luaunit.assertEquals(array({__index = 1, len = 2}), {__index = 1, len = 2})
	end;

	["test: array(): Instantiating with first value of false"] = function ()
		luaunit.assertEquals(array(false, true).__data, {false, true})
		luaunit.assertEquals(array({false, true}).__data, {false, true})
	end;
}
