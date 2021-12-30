Test__eq = {
	["test: Should return true when comparing empty arrays"] = function ()
		luaunit.assertTrue(array() == array())
		luaunit.assertFalse(array() ~= array())
	end;

	["test: Should return true when comparing arrays with single element"] = function ()
		luaunit.assertTrue(array("a") == array("a"))
		luaunit.assertFalse(array("a") ~= array("a"))
	end;
	
	["test: Should return true when comparing ordinary arrays"] = function ()
		luaunit.assertTrue(array("a", "b", "c") == array("a", "b", "c"))
		luaunit.assertFalse(array("a", "b", "c") ~= array("a", "b", "c"))
	end;

	["test: Should return false when comparing with primitive"] = function ()
		luaunit.assertFalse(array() == "a")
		luaunit.assertTrue(array() ~= "a")
	end;

	["test: Should return false when comparing an array with plain table"] = function ()
		luaunit.assertFalse(array() == {})
		luaunit.assertTrue(array() ~= {})
	end;

	["test: Should return false when comparing with object with the same data"] = function ()
		local o = Object()
		o[1] = "a"
		o[2] = "b"
		o[3] = "c"
		luaunit.assertFalse(array("a", "b", "c") == o)
		luaunit.assertTrue(array("a", "b", "c") ~= o)
	end;

	["test: Should return false when comparing arrays with same elements and different order"] = function ()
		luaunit.assertFalse(array("a", "b", "c") == array("c", "b", "a"))
		luaunit.assertTrue(array("a", "b", "c") ~= array("c", "b", "a"))
	end;

	["test: Should return true when comparing arrays with equals nested arrays"] = function ()
		luaunit.assertTrue(array("a", "b", "c", array("d", "e", "f")) == array("a", "b", "c", array("d", "e", "f")))
		luaunit.assertFalse(array("a", "b", "c", array("d", "e", "f")) ~= array("a", "b", "c", array("d", "e", "f")))
	end;

	["test: Should return false when comparing arrays with mismatching nested arrays"] = function ()
		luaunit.assertFalse(array("a", "b", "c", array("d", "e", "f")) == array("a", "b", "c", array("d")))
		luaunit.assertTrue(array("a", "b", "c", array("d", "e", "f")) ~= array("a", "b", "c", array("d")))
	end;

	["test: Should return false when comparing arrays with mismatching lengths"] = function ()
		luaunit.assertFalse(array("a") == array("a", "b", "c"))
		luaunit.assertTrue(array("a") ~= array("a", "b", "c"))
	end;
}