TestFirstIndexOf = {
	["test: Should always return -1 when the array is empty"] = function ()
		luaunit.assertEquals(array():firstindexof("a"), -1)
		luaunit.assertEquals(array():firstindexof("a", 10), -1)
	end;

	["test: Should return 1 when the array has only one element and it is required"] = function ()
		luaunit.assertEquals(array("a"):firstindexof("a"), 1)
	end;

	["test: Should return 1 when the array has only one element and it is required and start index is 1"] = function ()
		luaunit.assertEquals(array("a"):firstindexof("a", 1), 1)
	end;

	["test: Should return -1 when the array has only one element and start index is greater than 1"] = function ()
		luaunit.assertEquals(array("a"):firstindexof("a", 2), -1)
	end;

	["test: Should return -1 when the array has only one element and it is not required"] = function ()
		luaunit.assertEquals(array("a"):firstindexof("b"), -1)
	end;

	["test: Should return correct result when the array contains required element"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):firstindexof("b"), 2)
	end;

	["test: Should return correct result when the array contains required element and start index is 0"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):firstindexof("b", 0), 2)
	end;

	["test: Should return correct result when the array contains required element and start index is provided"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):firstindexof("b", 2), 2)
	end;

	["test: Should return -1 when the array does not contain required element"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):firstindexof("d"), -1)
	end;

	["test: Should return -1 when the array does not contain required element and start index is provided"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):firstindexof("d", 2), -1)
	end;

	["test: Should return correct result when searching for a nested array"] = function ()
		luaunit.assertEquals(array("a", "b", array("c")):firstindexof(array("c")), 3)
	end;

	["test: Should return the first index when the array contains multiple required elements"] = function ()
		luaunit.assertEquals(array("a", "b", "c", "b", "a"):firstindexof("b"), 2)
	end;

	["test: Should return the second index when the array contains multiple required elements and start index is provided"] = function ()
		luaunit.assertEquals(array("a", "b", "c", "b", "a"):firstindexof("b", 3), 4)
	end;

	["test: Should return correct result when start index is negative"] = function ()
		luaunit.assertEquals(array("a", "b", "c", "b", "a"):firstindexof("b", -2), 4)
		luaunit.assertEquals(array("a", "b", "c", "b", "a"):firstindexof("b", -4), 2)
	end;

	["test: Should return correct for nil when nil is at the start of the array"] = function ()
		luaunit.assertEquals(array(nil, "b", "c"):firstindexof(nil), 1)
	end;

	["test: Should return correct for nil when nil is at the middle of the array"] = function ()
		luaunit.assertEquals(array("a", nil, "c"):firstindexof(nil), 2)
	end;

	["test: Should return correct for nil when nil is at the end of the array"] = function ()
		luaunit.assertEquals(array("a", "b", nil):firstindexof(nil), 3)
	end;
}