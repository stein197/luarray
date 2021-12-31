TestAddEnd = {
	["test: Should add an element to the end when the array is empty"] = function ()
		local a = array()
		a:addend("a")
		luaunit.assertEquals(a.__data, {"a"})
	end;

	["test: Should add an element to the end"] = function ()
		local a = array("a", "b", "c")
		a:addend("d")
		luaunit.assertEquals(a.__data, {"a", "b", "c", "d"})
	end;

	["test: Should add nil to the end when the array is empty"] = function ()
		local a = array()
		a:addend(nil)
		luaunit.assertEquals(a.__data, {nil})
	end;

	["test: Should add nil to the end"] = function ()
		local a = array("a", "b", "c")
		a:addend(nil)
		luaunit.assertEquals(a.__data, {"a", "b", "c", nil})
	end;
}