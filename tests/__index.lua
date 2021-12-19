Test__index = {
	["test: Should return nil when accessing an empty array"] = function ()
		luaunit.assertNil(array()[1])
		luaunit.assertNil(array()[-1])
		luaunit.assertNil(array({})[1])
		luaunit.assertNil(array({})[-1])
	end;

	["test: Should return nil when accessing with 0"] = function ()
		luaunit.assertNil(array("a")[0])
	end;

	["test: Should return nil when accessing an element at large positive index"] = function ()
		luaunit.assertNil(array("a", "b", "c")[100])
		luaunit.assertNil(array({"a", "b", "c"})[100])
	end;

	["test: Should return nil when accessing an element at large negative index"] = function ()
		luaunit.assertNil(array("a", "b", "c")[-100])
		luaunit.assertNil(array({"a", "b", "c"})[-100])
	end;

	["test: Should return the only element when accessing with 1"] = function ()
		luaunit.assertEquals(array("a")[1], "a")
		luaunit.assertEquals(array({"a"})[1], "a")
	end;

	["test: Should return the only element when accessing with -1"] = function ()
		luaunit.assertEquals(array("a")[-1], "a")
		luaunit.assertEquals(array({"a"})[-1], "a")
	end;

	["test: Should return nil when accessing nil element in the start"] = function ()
		luaunit.assertNil(array(nil, "b", "c")[1])
		luaunit.assertNil(array({nil, "b", "c"})[1])
		luaunit.assertNil(array(nil, "b", "c")[-3])
		luaunit.assertNil(array({nil, "b", "c"})[-3])
	end;

	["test: Should return nil when accessing nil element in the middle"] = function ()
		luaunit.assertNil(array("a", nil, "c")[2])
		luaunit.assertNil(array({"a", nil, "c"})[2])
		luaunit.assertNil(array("a", nil, "c")[-2])
		luaunit.assertNil(array({"a", nil, "c"})[-2])
	end;

	["test: Should return nil when accessing nil element in the end"] = function ()
		luaunit.assertNil(array("a", "b", nil)[3])
		luaunit.assertNil(array({"a", "b", nil})[3])
	end;

	["test: Should return prototype function when accessing function name"] = function ()
		luaunit.assertEquals(type(array("a", "b", "c").len), "function")
	end;

	["test: Should return corresponding element when accessing with positive index"] = function ()
		luaunit.assertEquals(array("a", "b", "c", "d")[3], "c")
		luaunit.assertEquals(array({"a", "b", "c", "d"})[3], "c")
	end;

	["test: Should return corresponding element when accessing with negative index"] = function ()
		luaunit.assertEquals(array("a", "b", "c", "d")[-3], "b")
		luaunit.assertEquals(array({"a", "b", "c", "d"})[-3], "b")
	end;

	["test: Should return the last element when accessing with positive maximum index"] = function ()
		luaunit.assertEquals(array("a", "b", "c")[3], "c")
		luaunit.assertEquals(array({"a", "b", "c"})[3], "c")
	end;

	["test: Should return the first element when accessing with negative minimum index"] = function ()
		luaunit.assertEquals(array("a", "b", "c")[-3], "a")
		luaunit.assertEquals(array({"a", "b", "c"})[-3], "a")
	end;

	["test: Should return corresponding element after nil when accessing with positive index"] = function ()
		luaunit.assertEquals(array("a", nil, "c")[3], "c")
	end;

	["test: Should return corresponding element before nil when accessing with negative index"] = function ()
		luaunit.assertEquals(array("a", nil, "c")[-3], "a")
	end;
}
