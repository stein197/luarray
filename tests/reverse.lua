TestReverse = {
	["test: Reversing empty array returns an empty one"] = function ()
		luaunit.assertEquals(array():reverse(), {})
	end;

	["test: Reversing an array"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):reverse(), {"c", "b", "a"})
	end;

	["test: Reversing sparsed array"] = function ()
		luaunit.assertEquals(array {"a", "b", nil, "d"}: reverse(), {"d", nil, "b", "a"})
	end;
}