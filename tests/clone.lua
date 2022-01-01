TestClone = {
	setUp = function (self)
		self.a = array("a", "b", "c")
	end;
	
	["test: Should return different reference"] = function ()
		local a = array()
		luaunit.assertFalse(rawequal(a:clone(), a))
	end;

	["test: Should return an empty array when cloning an empty one"] = function ()
		luaunit.assertEquals(array():clone().__data, {})
	end;

	["test: Should be correct when cloning an array with single element"] = function ()
		luaunit.assertEquals(array("a"):clone().__data, {"a"})
	end;

	["test: Should be correct when cloning an array with multuple elements"] = function (self)
		luaunit.assertEquals(self.a:clone().__data, {"a", "b", "c"})
	end;
	
	["test: Should be correct when cloning an array containing nil"] = function ()
		luaunit.assertEquals(array("a", nil, "c"):clone().__data, {"a", nil, "c"})
	end;

	["test: Should be correct when cloning an array of nils"] = function ()
		luaunit.assertEquals(array(nil, nil, nil):clone().__data, {nil, nil, nil})
	end;

	["test: Should return an instance of array"] = function ()
		luaunit.assertTrue(rawequal(getmetatable(array():clone()), getmetatable(array())))
	end;

	["test: Should perform a shallow copy of an object by reference when cloning an array containing an object"] = function ()
		local o = Object()
		luaunit.assertTrue(rawequal(array(o):clone().__data[1], o))
	end;

	["test: Should perform a shallow copy of a table by reference when cloning an array containing a table"] = function ()
		local t = {}
		luaunit.assertTrue(rawequal(array(t):clone().__data[1], t))
	end;

	["test: Should contain a different reference to nested array when flag is set to true"] = function ()
		local a = array("d", "e", "f")
		luaunit.assertFalse(rawequal(array("a", "b", "c", a):clone(true).__data[4], a))
	end;

	["test: Should contain an array with the same elements when flag is set to true"] = function ()
		local a = array("d", "e", "f")
		luaunit.assertEquals(array("a", "b", "c", a):clone(true).__data[4].__data, {"d", "e", "f"})
	end;

	["test: Should contain the same reference to a nested array when flag is set to false"] = function ()
		local a = array("d", "e", "f")
		luaunit.assertTrue(rawequal(array("a", "b", "c", a):clone(false).__data[4], a))
	end;

	["test: Should contain the same reference to a nested array when flag is not set"] = function ()
		local a = array("d", "e", "f")
		luaunit.assertTrue(rawequal(array("a", "b", "c", a):clone().__data[4], a))
	end;

	["test: Shouldn't modify itself when flag is set to true"] = function (self)
		self.a:clone(true)
		luaunit.assertEquals(self.a.__data, {"a", "b", "c"})
	end;

	["test: Shouldn't modify itself when flag is set to false"] = function (self)
		self.a:clone(false)
		luaunit.assertEquals(self.a.__data, {"a", "b", "c"})
	end;

	["test: Shouldn't modify itself when flag is not set"] = function (self)
		self.a:clone()
		luaunit.assertEquals(self.a.__data, {"a", "b", "c"})
	end;
}