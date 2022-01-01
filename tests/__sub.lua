Test__sub = {
	["test: Should return an empty array after subtracting with an empty one when the array is empty"] = function ()
		luaunit.assertEquals((array() - array()).__data, {})
		luaunit.assertEquals(array():subtract(array()).__data, {})
	end;

	["test: Should return an empty array when the array is empty"] = function ()
		luaunit.assertEquals((array() - array("a")).__data, {})
	end;

	["test: Should return an array equal to the original when the argument is an empty one"] = function ()
		luaunit.assertEquals(array("a"):subtract(array()).__data, {"a"})
	end;

	["test: Should return an empty array when the array is a subset of another"] = function ()
		luaunit.assertEquals((array("a", "b", "c") - array("a", "b", "c", "d", "e", "f")).__data, {})
	end;

	["test: Should return correct result"] = function ()
		luaunit.assertEquals((array("a", "b", "c", "d") - array("f", "e", "d", "c")).__data, {"a", "b"})
		luaunit.assertEquals(array("f", "e", "d", "c"):subtract(array("a", "b", "c", "d")).__data, {"f", "e"})
	end;

	["test: Should return correct result with nil when both arrays contain nil"] = function ()
		luaunit.assertEquals((array(nil, "b", "c") - array("c", nil, "d")).__data, {"b"})
		luaunit.assertEquals(array("c", nil, "d"):subtract(array(nil, "b", "c")).__data, {"d"})
	end;

	["test: Should return correct result with nil when both arrays contain and one of them has only one element"] = function ()
		luaunit.assertEquals((array(nil, "b", "c") - array(nil)).__data, {"b", "c"})
		luaunit.assertEquals(array(nil):subtract(array(nil, "b", "c")).__data, {})
	end;

	["test: Should return an array equal to the initial one when both arrays don't have overlapping elements"] = function ()
		luaunit.assertEquals((array("a", "b", "c") - array("d", "e", "f")).__data, {"a", "b", "c"})
		luaunit.assertEquals(array("d", "e", "f"):subtract(array("a", "b", "c")).__data, {"d", "e", "f"})
	end;

	["test: Should return an empty array after subtracting with itself"] = function ()
		local a = array("a", "b", "c")
		luaunit.assertEquals((a - a).__data, {})
		luaunit.assertEquals(a:subtract(a).__data, {})
	end;

	["test: Should subtract all elements when the array to subtract with has duplicates"] = function ()
		luaunit.assertEquals((array("a", "b") - array("a", "a")).__data, {"b"})
	end;

	["test: Should subtract all elements when the array has duplicates"] = function ()
		luaunit.assertEquals(array("a", "b", "b"):subtract(array("a", "b")).__data, {})
	end;

	["test: Should raise an error when there's an attempt to subtract with plain table"] = function ()
		luaunit.assertErrorMsgContains("Unable to subtract with table: only arrays allowed", function () return array() - {} end)
	end;
	
	["test: Should return a new array"] = function ()
		local a = array()
		luaunit.assertFalse(rawequal(a - array(), a))
	end;

	["test: Should return a new array after subtracting with itself"] = function ()
		local a = array()
		luaunit.assertFalse(rawequal(a - a, a))
	end;

	["test: Should not modify itself"] = function ()
		local a = array("a", "b", "c")
		a:subtract(array("c", "d", "e"))
		luaunit.assertEquals(a.__data, {"a", "b", "c"})
	end;
}