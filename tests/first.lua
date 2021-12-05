TestFirst = {
	["test: First entry of an empty array is nil"] = function ()
		luaunit.assertNil(array():first())
	end;

	["test: Retrieving the first entry from the array"] = function ()
		local k, v = array("a", "b", "c"):first()
		luaunit.assertEquals(k, 1)
		luaunit.assertEquals(v, "a")
	end;
}
