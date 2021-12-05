Test__add = {
	["test: Adding a value will returns a new array"] = function ()
		local a = array()
		luaunit.assertNotEquals(a + 1, a)
	end;

	["test: Adding simple values will add them into inner __data"] = function ()
		luaunit.assertEquals((array() + 1).__data, {1})
	end;

	["test: Adding a table will wrap it"] = function ()
		luaunit.assertEquals(array(1, 2, 3) + {d = 4}, array(1, 2, 3, {d = 4}))
	end;

	["test: Adding an array will just add it"] = function ()
		luaunit.assertEquals(array(1, 2, 3) + array(), array(1, 2, 3, {}))
	end;

	["test: Adding an object will just add it"] = function ()
		local o = Class()
		luaunit.assertEquals(array() + o, array(o))
	end;

	["test: Adding nil does nothing"] = function ()
		luaunit.assertEquals(array() + nil, array())
	end;

	["test: Adding does not modify current array"] = function ()
		local a = array(1, 2, 3)
		local b = a + 4
		luaunit.assertEquals(a, {1, 2, 3})
	end;
}
