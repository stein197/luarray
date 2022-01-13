TestAddBefore = {
	setUp = function (self)
		self.one = array("a")
		self.a = array("a", "b", "c")
	end;
	
	["test: Should do nothing when the array is empty"] = function ()
		local a = array()
		a:addbefore(1, "a")
		luaunit.assertEquals(a.__data, {})
	end;

	["test: Should do nothing when the index is not 1 nor -1 and the array contains only one element"] = function (self)
		self.one:addbefore(2, "z")
		self.one:addbefore(-2, "z")
		luaunit.assertEquals(self.one.__data, {"a"})
	end;

	["test: Should add an element to the start when the array contains only one element and the index is 1"] = function (self)
		self.one:addbefore(1, "z")
		luaunit.assertEquals(self.one.__data, {"z", "a"})
	end;

	["test: Should add an element to the start when the array contains only one element and the index is -1"] = function (self)
		self.one:addbefore(-1, "z")
		luaunit.assertEquals(self.one.__data, {"z", "a"})
	end;

	["test: Should do nothing when the index is 0 and the array has only one element"] = function (self)
		self.one:addbefore(0, "z")
		luaunit.assertEquals(self.one.__data, {"a"})
	end;

	["test: Should do nothing when the index is 0"] = function (self)
		self.a:addbefore(0, "z")
		luaunit.assertEquals(self.a.__data, {"a", "b", "c"})
	end;

	["test: Should do nothing when the index is > #self"] = function (self)
		self.a:addbefore(10, "z")
		luaunit.assertEquals(self.a.__data, {"a", "b", "c"})
	end;

	["test: Should do nothing when the index is < -#self"] = function (self)
		self.a:addbefore(-10, "z")
		luaunit.assertEquals(self.a.__data, {"a", "b", "c"})
	end;

	["test: Should do nothing when the index is #self + 1"] = function (self)
		self.a:addbefore(4, "z")
		luaunit.assertEquals(self.a.__data, {"a", "b", "c"})
	end;

	["test: Should do nothing when the index is -#self - 1"] = function (self)
		self.a:addbefore(-4, "z")
		luaunit.assertEquals(self.a.__data, {"a", "b", "c"})
	end;

	["test: Should add an element to the start when the index is 1"] = function (self)
		self.a:addbefore(1, "z")
		luaunit.assertEquals(self.a.__data, {"z", "a", "b", "c"})
	end;

	["test: Should add an element to the middle when the index is the middle one"] = function (self)
		self.a:addbefore(2, "z")
		luaunit.assertEquals(self.a.__data, {"a", "z", "b", "c"})
	end;

	["test: Should add an element before the last one when the index is length of the array"] = function (self)
		self.a:addbefore(3, "z")
		luaunit.assertEquals(self.a.__data, {"a", "b", "z", "c"})
	end;

	["test: Should add an element to the start when the index is -#self"] = function (self)
		self.a:addbefore(-3, "z")
		luaunit.assertEquals(self.a.__data, {"z", "a", "b", "c"})
	end;

	["test: Should add an element to the middle when the index is the middle one and it's < 0"] = function (self)
		self.a:addbefore(-2, "z")
		luaunit.assertEquals(self.a.__data, {"a", "z", "b", "c"})
	end;

	["test: Should add an element to before the last one start when the index is -1"] = function (self)
		self.a:addbefore(-1, "z")
		luaunit.assertEquals(self.a.__data, {"a", "b", "z", "c"})
	end;
}
