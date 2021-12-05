TestLast = {
	["test: Last entry of an empty array is nil"] = function ()
		luaunit.assertNil(array():last())
	end;

	["test: Retrieving the last entry from the array"] = function ()
		local k, v = array("a", "b", "c"):last()
		luaunit.assertEquals(k, 3)
		luaunit.assertEquals(v, "c")
	end;
}
