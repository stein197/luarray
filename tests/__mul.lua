Test__mul = {
	["test: Should return an empty array after intersecting with an empty one when the array is empty"] = function ()
		luaunit.assertEquals((array() * array()).__data, {})
		luaunit.assertEquals(array():intersect(array()).__data, {})
	end;

	["test: Should always return an empty array when one of the arrays is empty"] = function ()
		luaunit.assertEquals((array() * array("a")).__data, {})
		luaunit.assertEquals(array("a"):intersect(array()).__data, {})
	end;

	["test: Should return an array equal to one of the initial ones when one of them is a subset of another"] = function ()
		luaunit.assertEquals((array("a", "b", "c") * array("a", "b", "c", "d", "e", "f")).__data, {"a", "b", "c"})
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):intersect(array("a", "b", "c")).__data, {"a", "b", "c"})
	end;

	["test: Should return correct result"] = function ()
		luaunit.assertEquals((array("a", "b", "c", "d") * array("f", "e", "d", "c")).__data, {"c", "d"})
		luaunit.assertEquals(array("f", "e", "d", "c"):intersect(array("a", "b", "c", "d")).__data, {"d", "c"})
	end;

	["test: Should return correct result with nil when both arrays contain nil"] = function ()
		luaunit.assertEquals((array(nil, "b", "c") * array("c", nil, "d")).__data, {nil, "c"})
		luaunit.assertEquals(array("c", nil, "d"):intersect(array(nil, "b", "c")).__data, {"c", nil})
	end;

	["test: Should return correct result with nil when both arrays contain and one of them has only one element"] = function ()
		luaunit.assertEquals((array(nil, "b", "c") * array(nil)).__data, {nil})
		luaunit.assertEquals(array(nil):intersect(array(nil, "b", "c")).__data, {nil})
	end;

	["test: Should return an empty array when both arrays don't have overlapping elements"] = function ()
		luaunit.assertEquals((array("a", "b", "c") * array("d", "e", "f")).__data, {})
		luaunit.assertEquals(array("d", "e", "f"):intersect(array("a", "b", "c")).__data, {})
	end;

	["test: Should return an array equal to the initial one after intersecting with itself"] = function ()
		local a = array("a", "b", "c")
		luaunit.assertEquals((a * a).__data, {"a", "b", "c"})
		luaunit.assertEquals(a:intersect(a).__data, {"a", "b", "c"})
	end;

	["test: Should preserve only one element when the array to intersect with has duplicates"] = function ()
		luaunit.assertEquals((array("a") * array("a", "a", "b")).__data, {"a"})
	end;

	["test: Should preserve duplicates when the array has duplicates"] = function ()
		luaunit.assertEquals(array("a", "b", "b"):intersect(array("b")).__data, {"b", "b"})
	end;

	["test: Should raise an error when there's an attempt to intersect with plain table"] = function ()
		luaunit.assertErrorMsgContains("Unable to intersect with table: only arrays allowed", function () return array() * {} end)
	end;

	["test: Should return a new array"] = function ()
		local a = array()
		luaunit.assertFalse(rawequal(a * array(), a))
	end;

	["test: Should return a new array after intersecting with itself"] = function ()
		local a = array()
		luaunit.assertFalse(rawequal(a * a, a))
	end;

	["test: Should not modify itself"] = function ()
		local a = array("a", "b", "c")
		a:intersect(array("c", "d", "e"))
		luaunit.assertEquals(a.__data, {"a", "b", "c"})
	end;
}