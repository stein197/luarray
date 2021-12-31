TestAddStart = {
	["test: Should add an element to the start when the array is empty"] = function ()
		local a = array()
		a:addstart("a")
		luaunit.assertEquals(a.__data, {"a"})
	end;

	["test: Should add an element to the start"] = function ()
		local a = array("a", "b", "c")
		a:addstart("d")
		luaunit.assertEquals(a.__data, {"d", "a", "b", "c"})
	end;

	["test: Should add nil to the start when the array is empty"] = function ()
		local a = array()
		a:addstart(nil)
		luaunit.assertEquals(a.__data, {nil})
	end;

	["test: Should add nil to the start"] = function ()
		local a = array("a", "b", "c")
		a:addstart(nil)
		luaunit.assertEquals(a.__data, {nil, "a", "b", "c"})
	end;
}