TestFirst = {
	["test: Should return -1, nil when an array is empty"] = function ()
		local i, elt = array():first()
		luaunit.assertEquals(i, -1)
		luaunit.assertNil(elt)
	end;

	["test: Should be correct"] = function ()
		local i, elt = array("a", "b", "c"):first()
		luaunit.assertEquals(i, 1)
		luaunit.assertEquals(elt, "a")
	end;

	["test: Should return 1, nil when the first element is nil"] = function ()
		local i, elt = array(nil, "b", "c"):first()
		luaunit.assertEquals(i, 1)
		luaunit.assertNil(elt)
	end;
}
