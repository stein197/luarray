Test__concat = {
	setUp = function (self)
		self.a1 = array("a", "b", "c")
		self.a2 = array("d", "e", "f")
	end;

	["test: Should return an instance of array when concatenating"] = function (self)
		luaunit.assertTrue(rawequal(getmetatable(array()), getmetatable(self.a1..self.a2)))
	end;
	
	["test: Should return an empty array when concatenating with an empty one"] = function ()
		luaunit.assertEquals((array()..array()).__data, {})
	end;

	["test: Should return an array with single element when concatenating an array with single element with empty one"] = function ()
		luaunit.assertEquals((array()..array("a")).__data, {"a"})
	end;

	["test: Should return an array with nil when concatenating an array with nil with empty one"] = function ()
		luaunit.assertEquals((array()..array(nil)).__data, {nil})
	end;

	["test: Should raise an error when concatenating with non array"] = function ()
		luaunit.assertErrorMsgContains("Cannot concatenate array with table", function ()
			local a = array()..{}
		end)
	end;

	["test: Should raise an error when concatenating with an object"] = function ()
		luaunit.assertErrorMsgContains("Cannot concatenate array with table", function ()
			local a = array()..Object()
		end)
	end;

	["test: Should return a new array when concatenating"] = function (self)
		luaunit.assertFalse(rawequal(self.a1..self.a2, self.a1))
		luaunit.assertFalse(rawequal(self.a1..self.a2, self.a2))
	end;

	["test: Should not modify the first array when concatenating"] = function (self)
		local a = self.a1..self.a2
		luaunit.assertEquals(self.a1.__data, {"a", "b", "c"})
	end;

	["test: Should not modify the second array when concatenating"] = function (self)
		local a = self.a1..self.a2
		luaunit.assertEquals(self.a2.__data, {"d", "e", "f"})
	end;

	["test: Should not remove duplicate elements when concatenating arrays with intersecting elements"] = function ()
		luaunit.assertEquals((array("a", "b", "c")..array("a", "c")).__data, {"a", "b", "c", "a", "c"})
	end;

	["test: Should return a doubled array when concatenating with self"] = function (self)
		luaunit.assertEquals((self.a1..self.a1).__data, {"a", "b", "c", "a", "b", "c"})
	end;

	["test: Should return correct result when concatenating arbitrary arrays"] = function (self)
		luaunit.assertEquals((self.a1..self.a2).__data, {"a", "b", "c", "d", "e", "f"})
	end;

	["test: Should return a different array when changing the order of operands"] = function (self)
		luaunit.assertEquals((self.a2..self.a1).__data, {"d", "e", "f", "a", "b", "c"})
	end;

	["test: Should preserve nils when concatenating arrays with nils"] = function ()
		luaunit.assertEquals((array("a", nil, "c")..array(nil, "e", "f")).__data, {"a", nil, "c", nil, "e", "f"})
	end;

	["test: Should preserve nils when concatenating arrays of nils"] = function ()
		luaunit.assertEquals((array(nil)..array(nil, nil, nil)).__data, {nil, nil, nil, nil})
	end;

	["test: Should return correct result when concatenating more than two arrays"] = function (self)
		luaunit.assertEquals((self.a1..self.a2..array("g", "h", "i")).__data, {"a", "b", "c", "d", "e", "f", "g", "h", "i"})
	end;

	["test: Should return correct result when concatenating array of booleans"] = function ()
		luaunit.assertEquals((array(false, true, false)..array(false, true, false)).__data, {false, true, false, false, true, false})
	end;
}