TestDelStart = {
	["test: Should always do nothing when the array is empty"] = function ()
		local a = array()
		a:delstart()
		luaunit.assertEquals(a.__data, {})
	end;

	["test: Should make an array empty after deleting the only element"] = function ()
		local a = array("a")
		a:delstart()
		luaunit.assertEquals(a.__data, {})
	end;

	["test: Should delete the first element"] = function ()
		local a = array("a", "b", "c")
		a:delstart()
		luaunit.assertEquals(a.__data, {"b", "c"})
	end;

	["test: Should delete the first element when the element is nil"] = function ()
		local a = array(nil, "b", "c")
		a:delstart()
		luaunit.assertEquals(a.__data, {"b", "c"})
	end;

	["test: Should return the first element"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):delstart(), "a")
	end;

	["test: Should return nil when the first element is nil"] = function ()
		luaunit.assertNil(array(nil, "b", "c"):delstart())
	end;

	["test: Should return nil when the array is empty"] = function ()
		luaunit.assertNil(array():delstart())
	end;
}