TestShuffle = {
	setUp = function(self)
		self.a = array("a", "b", "c", "d", "e", "f")
	end;
	
	["test: shuffle()"] = function (self)
		luaunit.assertNotEquals(self.a:shuffle(), {"a", "b", "c", "d", "e", "f"})
	end;

	["test: Shuffling an empty array return empty one"] = function ()
		luaunit.assertEquals(array():shuffle(), {})
	end;

	["test: Shuffling an array with single element returns equal one"] = function ()
		luaunit.assertEquals(array("a"):shuffle(), {"a"})
	end;

	["test: Shuffling does not modify the current array"] = function (self)
		self.a:shuffle()
		luaunit.assertEquals(self.a, {"a", "b", "c", "d", "e", "f"})
	end;

	["test: Shuffling returns a new array"] = function (self)
		luaunit.assertNotEquals(rawequal(self.a, self.a:shuffle()))
	end;

	["test: Shuffling returns an array with the same amount of items"] = function (self)
		luaunit.assertEquals(self.a:shuffle():len(), 6)
	end;

	["test: Shuffling returns an array with the same items"] = function (self)
		luaunit.assertItemsEquals(self.a:shuffle(), {"a", "b", "c", "d", "e", "f"})
	end;
}
