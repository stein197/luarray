TestReverse = {
	setUp = function (self)
		self.a = array("a", "b", "c")
	end;

	["test: Should return an empty array when the array is empty"] = function ()
		luaunit.assertEquals(array():reverse().__data, {})
	end;

	["test: Should return an array equal to the original one when the array has only one value"] = function ()
		luaunit.assertEquals(array("a"):reverse().__data, {"a"})
	end;

	["test: Should return reversed array"] = function (self)
		luaunit.assertEquals(self.a:reverse().__data, {"c", "b", "a"})
	end;

	["test: Should preserve nils when the array has nils"] = function ()
		luaunit.assertEquals(array("a", nil, "c"):reverse().__data, {"c", nil, "a"})
	end;

	["test: Should preserve nil when the array has it at the start"] = function ()
		luaunit.assertEquals(array(nil, "b", "c"):reverse().__data, {"c", "b", nil})
	end;

	["test: Should preserve nil when the array has it at the end"] = function ()
		luaunit.assertEquals(array("a", "b", nil):reverse().__data, {nil, "b", "a"})
	end;

	["test: Should make shallow copy of nested arrays"] = function ()
		local c = array("c")
		luaunit.assertTrue(rawequal(array("a", "b", c):reverse().__data[1], c))
	end;

	["test: Should not modify self"] = function (self)
		self.a:reverse()
		luaunit.assertEquals(self.a.__data, {"a", "b", "c"})
	end;

	["test: Should return a new array"] = function ()
		luaunit.assertTrue(rawequal(getmetatable(array():reverse()), getmetatable(array())))
	end;
}