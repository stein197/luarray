TestDel = {
	setUp = function (self)
		self.a = array("a", "b", "c", "d", "e", "f")
	end;

	["test: Should always do nothing when the array is empty"] = function ()
		local a = array()
		a:del(1)
		a:del(-1)
		a:del(2)
		luaunit.assertEquals(a.__data, {})
	end;

	["test: Should make an array empty after deleting the only element with 1"] = function ()
		local a = array("a")
		a:del(1)
		luaunit.assertEquals(a.__data, {})
	end;

	["test: Should make an array empty after deleting the only element with -1"] = function ()
		local a = array("a")
		a:del(-1)
		luaunit.assertEquals(a.__data, {})
	end;

	["test: Should do nothing when the argument is out of bounds"] = function (self)
		self.a:del(10)
		luaunit.assertEquals(self.a.__data, {"a", "b", "c", "d", "e", "f"})
	end;

	["test: Should do nothing when the argument 0"] = function (self)
		self.a:del(0)
		luaunit.assertEquals(self.a.__data, {"a", "b", "c", "d", "e", "f"})
	end;

	["test: Should delete the first element when the argument is 1"] = function (self)
		self.a:del(1)
		luaunit.assertEquals(self.a.__data, {"b", "c", "d", "e", "f"})
	end;

	["test: Should delete the first element when the argument min negative"] = function (self)
		self.a:del(-6)
		luaunit.assertEquals(self.a.__data, {"b", "c", "d", "e", "f"})
	end;

	["test: Should delete the first element when the argument is 1 and the first element is nil"] = function ()
		local a = array(nil, "b", "c")
		a:del(1)
		luaunit.assertEquals(a.__data, {"b", "c"})
	end;

	["test: Should delete the first element when the argument min negative and the first element is nil"] = function ()
		local a = array(nil, "b", "c")
		a:del(-3)
		luaunit.assertEquals(a.__data, {"b", "c"})
	end;

	["test: Should delete the last element when the argument is #self"] = function (self)
		self.a:del(6)
		luaunit.assertEquals(self.a.__data, {"a", "b", "c", "d", "e"})
	end;

	["test: Should delete the last element when the argument -1"] = function (self)
		self.a:del(-1)
		luaunit.assertEquals(self.a.__data, {"a", "b", "c", "d", "e"})
	end;

	["test: Should delete the last element when the argument is #self and the last element is nil"] = function ()
		local a = array("a", "b", nil)
		a:del(3)
		luaunit.assertEquals(a.__data, {"a", "b"})
	end;

	["test: Should delete the last element when the argument -1 and the last element is nil"] = function ()
		local a = array("a", "b", nil)
		a:del(-1)
		luaunit.assertEquals(a.__data, {"a", "b"})
	end;

	["test: Should delete an element"] = function (self)
		self.a:del(3)
		luaunit.assertEquals(self.a.__data, {"a", "b", "d", "e", "f"})
	end;

	["test: Should delete an element when the argument is negative"] = function (self)
		self.a:del(-3)
		luaunit.assertEquals(self.a.__data, {"a", "b", "c", "e", "f"})
	end;

	["test: Should delete nil when the element is nil"] = function ()
		local a = array("a", nil, "c")
		a:del(2)
		luaunit.assertEquals(a.__data, {"a", "c"})
	end;

	["test: Should delete nil when the element is nil and the argument is negative"] = function ()
		local a = array("a", nil, "c")
		a:del(-2)
		luaunit.assertEquals(a.__data, {"a", "c"})
	end;

	["test: Should return deleted element"] = function (self)
		luaunit.assertEquals(self.a:del(3), "c")
	end;

	["test: Should return deleted element when the argument is negative"] = function (self)
		luaunit.assertEquals(self.a:del(-3), "d")
	end;

	["test: Should return the first element when deleting the first one by 1"] = function (self)
		luaunit.assertEquals(self.a:del(1), "a")
	end;

	["test: Should return the first element when deleting the first one by -#self"] = function (self)
		luaunit.assertEquals(self.a:del(-6), "a")
	end;

	["test: Should return the last element when deleting the last one by #self"] = function (self)
		luaunit.assertEquals(self.a:del(6), "f")
	end;

	["test: Should return the last element when deleting the last one by -1"] = function (self)
		luaunit.assertEquals(self.a:del(-1), "f")
	end;

	["test: Should return nil when the element in nil"] = function ()
		luaunit.assertNil(array("a", nil, "c"):del(2))
	end;

	["test: Should return nil when the array is empty"] = function (self)
		luaunit.assertNil(array():del(3))
	end;
}