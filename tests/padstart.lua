TestPadStart = {
	["test: Should return an empty array when padding an empty one to 0 length"] = function ()
		luaunit.assertEquals(array():padstart(0, "a").__data, {})
	end;

	["test: Should return an array full of same elements when padding an empty one"] = function ()
		luaunit.assertEquals(array():padstart(3, "a").__data, {"a", "a", "a"})
	end;

	["test: Should return an array equal to the original one when padding to 0 length"] = function ()
		luaunit.assertEquals(array("a"):padstart(0, "a").__data, {"a"})
	end;

	["test: Should return an array equal to the original one when padding to the array's length"] = function ()
		luaunit.assertEquals(array("a"):padstart(1, "a").__data, {"a"})
		luaunit.assertEquals(array("a", "b", "c"):padstart(3, "a").__data, {"a", "b", "c"})
	end;

	["test: Should return an array equal to the original one when padding to negative length"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):padstart(-3, "d").__data, {"a", "b", "c"})
	end;

	["test: Should return an array equal to the original one when padding to the length that is less than array's one"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):padstart(2, "d").__data, {"a", "b", "c"})
	end;

	["test: Should return correct result"] = function ()
		luaunit.assertEquals(array("a"):padstart(3, "b").__data, {"b", "b", "a"})
		luaunit.assertEquals(array("a", "b", "c"):padstart(5, "d").__data, {"d", "d", "a", "b", "c"})
	end;

	["test: Should return correct result when padding to the length greater than array's one by 1"] = function ()
		luaunit.assertEquals(array("a"):padstart(2, "b").__data, {"b", "a"})
		luaunit.assertEquals(array("a", "b", "c"):padstart(4, "d").__data, {"d", "a", "b", "c"})
	end;

	["test: Should return correct result when there is nil at the start"] = function ()
		luaunit.assertEquals(array(nil, "b", "c"):padstart(4, "d").__data, {"d", nil, "b", "c"})
		luaunit.assertEquals(array(nil, "b", "c"):padstart(6, "d").__data, {"d", "d", "d", nil, "b", "c"})
	end;

	["test: Should return correct result when padding with nils"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):padstart(4, nil).__data, {nil, "a", "b", "c"})
		luaunit.assertEquals(array("a", "b", "c"):padstart(6, nil).__data, {nil, nil, nil, "a", "b", "c"})
	end;

	["test: Should return a new array"] = function ()
		local a = array()
		luaunit.assertFalse(rawequal(a:padstart(2, "a"), a))
	end;

	["test: Should not modify self"] = function ()
		local a = array("a", "b", "c")
		a:padstart(4, "d")
		luaunit.assertEquals(a.__data, {"a", "b", "c"})
	end;
}
