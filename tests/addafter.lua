TestAddAfter = {
	setUp = function (self)
		self.one = array("a")
		self.a = array("a", "b", "c")
	end;
	
	["test: Should do nothing when the array is empty"] = function ()
		local a = array()
		a:addafter(1, "a")
		luaunit.assertEquals(a.__data, {})
	end;

	["test: Should do nothing when the index is not 1 nor -1 and the array contains only one element"] = function (self)
		self.one:addafter(2, "z")
		self.one:addafter(-2, "z")
		luaunit.assertEquals(self.one.__data, {"a"})
	end;

	["test: Should add an element to the end when the array contains only one element and the index is 1"] = function (self)
		self.one:addafter(1, "z")
		luaunit.assertEquals(self.one.__data, {"a", "z"})
	end;

	["test: Should add an element to the end when the array contains only one element and the index is -1"] = function (self)
		self.one:addafter(-1, "z")
		luaunit.assertEquals(self.one.__data, {"a", "z"})
	end;

	["test: Should do nothing when the index is 0 and the array has only one element"] = function (self)
		self.one:addafter(0, "z")
		luaunit.assertEquals(self.one.__data, {"a"})
	end;

	["test: Should do nothing when the index is 0"] = function (self)
		self.a:addafter(0, "z")
		luaunit.assertEquals(self.a.__data, {"a", "b", "c"})
	end;

	["test: Should do nothing when the index is > #self"] = function (self)
		self.a:addafter(10, "z")
		luaunit.assertEquals(self.a.__data, {"a", "b", "c"})
	end;

	["test: Should do nothing when the index is < -#self"] = function (self)
		self.a:addafter(-10, "z")
		luaunit.assertEquals(self.a.__data, {"a", "b", "c"})
	end;

	["test: Should do nothing when the index is #self + 1"] = function (self)
		self.a:addafter(4, "z")
		luaunit.assertEquals(self.a.__data, {"a", "b", "c"})
	end;

	["test: Should do nothing when the index is -#self - 1"] = function (self)
		self.a:addafter(-4, "z")
		luaunit.assertEquals(self.a.__data, {"a", "b", "c"})
	end;

	["test: Should add an element after the first one when the index is 1"] = function (self)
		self.a:addafter(1, "z")
		luaunit.assertEquals(self.a.__data, {"a", "z", "b", "c"})
	end;

	["test: Should add an element to the middle when the index is the middle one"] = function (self)
		self.a:addafter(2, "z")
		luaunit.assertEquals(self.a.__data, {"a", "b", "z", "c"})
	end;

	["test: Should add an element to the end when the index is length of the array"] = function (self)
		self.a:addafter(3, "z")
		luaunit.assertEquals(self.a.__data, {"a", "b", "c", "z"})
	end;

	["test: Should add an element after the first one when the index is -#self"] = function (self)
		self.a:addafter(-3, "z")
		luaunit.assertEquals(self.a.__data, {"a", "z", "b", "c"})
	end;

	["test: Should add an element to the middle when the index is the middle one and it's < 0"] = function (self)
		self.a:addafter(-2, "z")
		luaunit.assertEquals(self.a.__data, {"a", "b", "z", "c"})
	end;

	["test: Should add an element to the end when the index is -1"] = function (self)
		self.a:addafter(-1, "z")
		luaunit.assertEquals(self.a.__data, {"a", "b", "c", "z"})
	end;
}
