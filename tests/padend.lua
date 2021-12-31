TestPadEnd = {
	["test: Should return an empty array when padding an empty one to 0 length"] = function ()
		luaunit.assertEquals(array():padend(0, "a").__data, {})
	end;

	["test: Should return an array full of same elements when padding an empty one"] = function ()
		luaunit.assertEquals(array():padend(3, "a").__data, {"a", "a", "a"})
	end;

	["test: Should return an array equal to the original one when padding to 0 length"] = function ()
		luaunit.assertEquals(array("a"):padend(0, "a").__data, {"a"})
	end;

	["test: Should return an array equal to the original one when padding to the array's length"] = function ()
		luaunit.assertEquals(array("a"):padend(1, "a").__data, {"a"})
		luaunit.assertEquals(array("a", "b", "c"):padend(3, "a").__data, {"a", "b", "c"})
	end;

	["test: Should return an array equal to the original one when padding to negative length"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):padend(-3, "d").__data, {"a", "b", "c"})
	end;

	["test: Should return an array equal to the original one when padding to the length that is less than array's one"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):padend(2, "d").__data, {"a", "b", "c"})
	end;

	["test: Should return correct result"] = function ()
		luaunit.assertEquals(array("a"):padend(3, "b").__data, {"a", "b", "b"})
		luaunit.assertEquals(array("a", "b", "c"):padend(5, "d").__data, {"a", "b", "c", "d", "d"})
	end;

	["test: Should return correct result when padding to the length greater than array's one by 1"] = function ()
		luaunit.assertEquals(array("a"):padend(2, "b").__data, {"a", "b"})
		luaunit.assertEquals(array("a", "b", "c"):padend(4, "d").__data, {"a", "b", "c", "d"})
	end;

	["test: Should return correct result when there is nil at the end"] = function ()
		luaunit.assertEquals(array("a", "b", nil):padend(4, "d").__data, {"a", "b", nil, "d"})
		luaunit.assertEquals(array("a", "b", nil):padend(6, "d").__data, {"a", "b", nil, "d", "d", "d"})
	end;

	["test: Should return correct result when padding with nils"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):padend(4, nil).__data, {"a", "b", "c", nil})
		luaunit.assertEquals(array("a", "b", "c"):padend(6, nil).__data, {"a", "b", "c", nil, nil, nil})
	end;

	["test: Should return a new array"] = function ()
		local a = array()
		luaunit.assertFalse(rawequal(a:padend(2, "a"), a))
	end;

	["test: Should not modify self"] = function ()
		local a = array("a", "b", "c")
		a:padend(4, "d")
		luaunit.assertEquals(a.__data, {"a", "b", "c"})
	end;
}
