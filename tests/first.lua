TestFirst = {
	["test: Should return -1, nil when an array is empty"] = function ()
		local i, v = array():first()
		luaunit.assertEquals(i, -1)
		luaunit.assertNil(v)
	end;

	["test: Should be correct"] = function ()
		local i, v = array("a", "b", "c"):first()
		luaunit.assertEquals(i, 1)
		luaunit.assertEquals(v, "a")
	end;

	["test: Should return 1, nil when the first value is nil"] = function ()
		local i, v = array(nil, "b", "c"):first()
		luaunit.assertEquals(i, 1)
		luaunit.assertNil(v)
	end;
}
