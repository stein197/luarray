TestIsEmpty = {
	["test: isempty(): Empty table is empty"] = function ()
		luaunit.assertTrue(array():isempty())
	end;

	["test: isempty(): Table containing elements is not empty"] = function ()
		luaunit.assertFalse(array(1):isempty())
		luaunit.assertFalse(array(1, 2, 3):isempty())
	end;
}
