TestLastIndexOf = {
	["test: Should always return -1 when the array is empty"] = function ()
		luaunit.assertEquals(array():lastindexof("a"), -1)
		luaunit.assertEquals(array():lastindexof("a", 10), -1)
	end;

	["test: Should return 1 when the array has only one element and it is required"] = function ()
		luaunit.assertEquals(array("a"):lastindexof("a"), 1)
	end;

	["test: Should return 1 when the array has only one element and it is required and start index is 1"] = function ()
		luaunit.assertEquals(array("a"):lastindexof("a", 1), 1)
	end;

	["test: Should return -1 when the array has only one element and it is not required"] = function ()
		luaunit.assertEquals(array("a"):lastindexof("b"), -1)
	end;

	["test: Should return correct result when the array contains required element"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):lastindexof("b"), 2)
	end;

	["test: Should return correct result when the array contains required element and start index is 0"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):lastindexof("b", 0), 2)
	end;

	["test: Should return correct result when the array contains required element and start index is provided"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):lastindexof("b", 2), 2)
	end;

	["test: Should return -1 when the array does not contain required element"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):lastindexof("d"), -1)
	end;

	["test: Should return -1 when the array does not contain required element and start index is provided"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):lastindexof("d", 2), -1)
	end;

	["test: Should return correct result when searching for a nested array"] = function ()
		luaunit.assertEquals(array("a", "b", array("c")):lastindexof(array("c")), 3)
	end;

	["test: Should return the first index when the array contains multiple required elements"] = function ()
		luaunit.assertEquals(array("a", "b", "c", "b", "a"):lastindexof("b"), 4)
	end;

	["test: Should return the second index when the array contains multiple required elements and start index is provided"] = function ()
		luaunit.assertEquals(array("a", "b", "c", "b", "a"):lastindexof("b", 3), 2)
	end;

	["test: Should return correct result when start index is negative"] = function ()
		luaunit.assertEquals(array("a", "b", "c", "b", "a"):lastindexof("b", -1), 4)
		luaunit.assertEquals(array("a", "b", "c", "b", "a"):lastindexof("b", -3), 2)
	end;

	["test: Should return correct for nil when nil is at the start of the array"] = function ()
		luaunit.assertEquals(array(nil, "b", "c"):lastindexof(nil), 1)
	end;

	["test: Should return correct for nil when nil is at the middle of the array"] = function ()
		luaunit.assertEquals(array("a", nil, "c"):lastindexof(nil), 2)
	end;

	["test: Should return correct for nil when nil is at the end of the array"] = function ()
		luaunit.assertEquals(array("a", "b", nil):lastindexof(nil), 3)
	end;

	["test: Should return nil when the index is out of bounds"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):lastindexof("a", -10), -1)
	end;
}