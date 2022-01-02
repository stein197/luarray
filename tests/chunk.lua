TestChunk = {
	setUp = function (self)
		self.a = array("a", "b", "c", "d", "e", "f")
	end;
	
	["test: Should always return an empty array when the array is empty"] = function ()
		luaunit.assertEquals(array():chunk(1).__data, {})
	end;

	["test: Should return an array with one element equal to the original one when the array has only one element"] = function ()
		luaunit.assertEquals(array("a"):chunk(1).__data, {array("a")})
	end;

	["test: Should return an array with one element equal to the original one when the argument is greater than the array's length"] = function (self)
		luaunit.assertEquals(self.a:chunk(10).__data, {array("a", "b", "c", "d", "e", "f")})
	end;

	["test: Should return a new array"] = function ()
		local a = array()
		luaunit.assertFalse(rawequal(a:chunk(1), a))
	end;

	["test: Should raise an error when the argument is less than 1"] = function ()
		luaunit.assertErrorMsgContains("Unable to chunk array with 0 size of length: the size cannot be less than 1", function () array():chunk(0) end)
	end;

	["test: Shouldn't modify itself"] = function (self)
		self.a:chunk(1)
		luaunit.assertEquals(self.a.__data, {"a", "b", "c", "d", "e", "f"})
	end;

	["test: Should return correct result when the array can be chunked in equal pieces"] = function (self)
		luaunit.assertEquals(self.a:chunk(2).__data, {array("a", "b"), array("c", "d"), array("e", "f")})
	end;

	["test: Should return an array with the last element lesser than others when the array cannot be chunked in equal pieces"] = function (self)
		luaunit.assertEquals(self.a:chunk(4).__data, {array("a", "b", "c", "d"), array("e", "f")})
	end;
}
