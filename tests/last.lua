TestLast = {
	["test: Should return -1, nil when an array is empty"] = function ()
		local i, v = array():last()
		luaunit.assertEquals(i, -1)
		luaunit.assertNil(v)
	end;

	["test: Should be correct"] = function ()
		local i, v = array("a", "b", "c"):last()
		luaunit.assertEquals(i, 3)
		luaunit.assertEquals(v, "c")
	end;

	["test: Should return 3, nil when the last value is nil"] = function ()
		local i, v = array("a", "b", nil):last()
		luaunit.assertEquals(i, 3)
		luaunit.assertNil(v)
	end;
}
