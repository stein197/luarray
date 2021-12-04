Test__index = {
	setUp = function (self)
		self.o = Class()
	end;
	
	["test: Accessing an empty array returns nil"] = function ()
		luaunit.assertNil(array()[1])
	end;

	["test: Accessing an array with single element"] = function ()
		luaunit.assertEquals(array(1)[1], 1)
	end;

	["test: Accessing an array with multiple elements"] = function ()
		luaunit.assertEquals(array(1, 2, 3)[3], 3)
	end;

	["test: Accessing a key associated with an array returns the array"] = function ()
		local a = array(1, 2, 3)
		luaunit.assertTrue(array(1, 2, a)[3] == a)
		luaunit.assertTrue(array(a)[1] == a)
		luaunit.assertTrue(array({a})[1] == a)
	end;

	["test: Accessing a key associated with an object returns the object"] = function (self)
		luaunit.assertTrue(array(1, 2, self.o)[3] == self.o)
		luaunit.assertTrue(array(self.o)[1] == self.o)
		luaunit.assertTrue(array({self.o})[1] == self.o)
	end;

	["test: Accessing by an not existing key returns nil"] = function ()
		luaunit.assertNil(array(1, 2, 3)[0])
	end;

	["test: Accessing by number"] = function ()
		luaunit.assertEquals(array("a")[1], "a")
	end;

	["test: Accessing by string"] = function ()
		luaunit.assertEquals(array({a = 1}).a, 1)
	end;

	["test: Accessing by an object type"] = function (self)
		luaunit.assertEquals(array({[self.o] = 1})[self.o], 1)
	end;

	["test: Accessing __data field"] = function ()
		luaunit.assertEquals(array(1, 2, 3).__data, {1, 2, 3})
	end;
	
	["test: Access methods will return one"] = function ()
		luaunit.assertEquals(type(array({1, 2, 3}).len), "function")
	end;
}
