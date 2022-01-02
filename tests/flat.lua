TestFlat = {
	setUp = function (self)
		self.a = array("a", "b", array("c", "d", array("e", "f")))
	end;
	
	["test: Should return an empty array when the array is empty"] = function ()
		luaunit.assertEquals(array():flat().__data, {})
		luaunit.assertEquals(array():flat(0).__data, {})
		luaunit.assertEquals(array():flat(1).__data, {})
		luaunit.assertEquals(array():flat(10).__data, {})
	end;

	["test: Should return a new array"] = function (self)
		luaunit.assertFalse(rawequal(self.a:flat(), self.a))
	end;

	["test: Shouldn't modify itself"] = function (self)
		self.a:flat(2)
		luaunit.assertEquals(self.a, array("a", "b", array("c", "d", array("e", "f"))))
	end;

	["test: Should return correct result"] = function (self)
		luaunit.assertEquals(self.a:flat(), array("a", "b", "c", "d", array("e", "f")))
		luaunit.assertEquals(self.a:flat(1), array("a", "b", "c", "d", array("e", "f")))
		luaunit.assertEquals(self.a:flat(2), array("a", "b", "c", "d", "e", "f"))
	end;

	["test: Should return the same result when the argument is omitted and 1"] = function (self)
		luaunit.assertEquals(self.a:flat(), self.a:flat(1))
	end;

	["test: Should return an array equal to the original one when the depth is 0"] = function (self)
		luaunit.assertEquals(self.a:flat(0), array("a", "b", array("c", "d", array("e", "f"))))
	end;

	["test: Should return totally flattened array when the depth is a large number"] = function (self)
		luaunit.assertEquals(self.a:flat(10).__data, {"a", "b", "c", "d", "e", "f"})
	end;
}
