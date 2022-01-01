TestShuffle = {
	setUp = function(self)
		self.a = array("a", "b", "c", "d", "e", "f")
	end;
	
	["test: Should be correct"] = function (self)
		luaunit.assertNotEquals(self.a:shuffle(), {"a", "b", "c", "d", "e", "f"})
	end;

	["test: Should return an empty array when shuffling an empty one"] = function ()
		luaunit.assertEquals(array():shuffle().__data, {})
	end;

	["test: Should return an array equal to the initial one when shuffling an array with single element"] = function ()
		luaunit.assertEquals(array("a"):shuffle().__data, {"a"})
	end;

	["test: Shouldn't modify itself"] = function (self)
		self.a:shuffle()
		luaunit.assertEquals(self.a.__data, {"a", "b", "c", "d", "e", "f"})
	end;

	["test: Should return a new array"] = function (self)
		luaunit.assertFalse(rawequal(self.a, self.a:shuffle()))
	end;

	["test: Should return an array with the same items of the initial one"] = function (self)
		luaunit.assertItemsEquals(self.a:shuffle().__data, {"a", "b", "c", "d", "e", "f"})
	end;

	["test: Should preserve nils when shuffling an array with nils"] = function ()
		luaunit.assertItemsEquals(array("a", nil, "c", nil, "e", nil):shuffle().__data, {nil, nil, nil, "a", "c", "e"})
	end;
}
