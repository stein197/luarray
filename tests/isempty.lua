TestEmpty = {
	["test: Should return true when the array is empty"] = function ()
		luaunit.assertTrue(array():isempty())
	end;

	["test: Should return false when the array is not empty"] = function ()
		luaunit.assertFalse(array(1):isempty())
		luaunit.assertFalse(array(1, 2, 3):isempty())
	end;

	["test: Should return false when the array is full of nils"] = function ()
		luaunit.assertFalse(array(nil):isempty())
	end;
}
