TestDelEnd = {
	["test: Should always do nothing when the array is empty"] = function ()
		local a = array()
		a:delend()
		luaunit.assertEquals(a.__data, {})
	end;

	["test: Should make an array empty after deleting the only element"] = function ()
		local a = array("a")
		a:delend()
		luaunit.assertEquals(a.__data, {})
	end;

	["test: Should delete the last element"] = function ()
		local a = array("a", "b", "c")
		a:delend()
		luaunit.assertEquals(a.__data, {"a", "b"})
	end;

	["test: Should delete the last element when the element is nil"] = function ()
		local a = array("a", "b", nil)
		a:delend()
		luaunit.assertEquals(a.__data, {"a", "b", nil})
	end;

	["test: Should return the last element"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):delend(), "a")
	end;

	["test: Should return nil when the last element is nil"] = function ()
		luaunit.assertNil(array("a", "b", nil):delend())
	end;

	["test: Should return nil when the array is empty"] = function ()
		luaunit.assertNil(array():delend())
	end;
}