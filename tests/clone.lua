TestClone = {
	["test: Cloning returns different reference"] = function ()
		luaunit.assertFalse(rawequal(array():clone(), array():clone()))
	end;

	["test: Cloning an empty array return empty one"] = function ()
		luaunit.assertEquals(array():clone(), {})
	end;

	["test: Cloning an array with single element"] = function ()
		luaunit.assertEquals(array(1):clone(), {1})
	end;

	["test: Cloning an array with multuple elements"] = function ()
		luaunit.assertEquals(array {a = 1, b = 2, c = 3}: clone(), {a = 1, b = 2, c = 3})
	end;

	["test: Cloning nested arrays"] = function ()
		luaunit.assertEquals(array(1, 2, {c = 3, d = {4}}):clone(), {1, 2, {c = 3, d = {4}}})
	end;

	["test: Cloning an array with object element"] = function ()
		local o = Object()
		luaunit.assertTrue(array(o):clone()[1] == o)
	end;

	["test: Cloned nested arrays are different references"] = function ()
		local a = array(1, 2, {3})
		luaunit.assertFalse(rawequal(a:clone()[3], a[3]))
	end;
}