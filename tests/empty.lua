TestEmpty = {
	["test: empty(): Empty table is empty"] = function ()
		luaunit.assertTrue(array():empty())
	end;

	["test: empty(): Table containing elements is not empty"] = function ()
		luaunit.assertFalse(array(1):empty())
		luaunit.assertFalse(array(1, 2, 3):empty())
	end;
}
