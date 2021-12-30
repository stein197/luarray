TestLast = {
	["test: Should return -1, nil when an array is empty"] = function ()
		local i, elt = array():last()
		luaunit.assertEquals(i, -1)
		luaunit.assertNil(elt)
	end;

	["test: Should be correct"] = function ()
		local i, elt = array("a", "b", "c"):last()
		luaunit.assertEquals(i, 3)
		luaunit.assertEquals(elt, "c")
	end;

	["test: Should return 3, nil when the last element is nil"] = function ()
		local i, elt = array("a", "b", nil):last()
		luaunit.assertEquals(i, 3)
		luaunit.assertNil(elt)
	end;
}
