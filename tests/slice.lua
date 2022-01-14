TestSlice = {
	["test: Should always return an empty array regardless of the arguments when the array is empty"] = function ()
		luaunit.assertEquals(array():slice().__data, {})
		luaunit.assertEquals(array():slice(0).__data, {})
		luaunit.assertEquals(array():slice(0, 0).__data, {})
		luaunit.assertEquals(array():slice(0, 1).__data, {})
	end;

	["test: Should always return an array equal to the original one regardless of the arguments when the array has only one element"] = function ()
		luaunit.assertEquals(array("a"):slice().__data, {"a"})
		luaunit.assertEquals(array("a"):slice(0).__data, {"a"})
		luaunit.assertEquals(array("a"):slice(1).__data, {"a"})
		luaunit.assertEquals(array("a"):slice(-1).__data, {"a"})
		luaunit.assertEquals(array("a"):slice(1, 1).__data, {"a"})
		luaunit.assertEquals(array("a"):slice(-1, -1).__data, {"a"})
		luaunit.assertEquals(array("a"):slice(1, -1).__data, {"a"})
		luaunit.assertEquals(array("a"):slice(-1, 1).__data, {"a"})
	end;

	["test: Should return either entire array or empty one when the arguments are out of bounds"] = function ()
		luaunit.assertEquals(array("a"):slice(-2).__data, {"a"})
		luaunit.assertEquals(array("a"):slice(2).__data, {})
		luaunit.assertEquals(array("a"):slice(2, -2).__data, {})
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):slice(8).__data, {})
	end;

	["test: Should raise an error when \"to\" argument is lesser than \"from\""] = function ()
		luaunit.assertErrorMsgContains("Cannot slice the array from 5 (5) to 3 (3) index: 3 is lesser than 5", function () array("a", "b", "c", "d", "e", "f"):slice(5, 3) end)
		luaunit.assertErrorMsgContains("Cannot slice the array from -2 (5) to 3 (3) index: 3 is lesser than 5", function () array("a", "b", "c", "d", "e", "f"):slice(-2, 3) end)
	end;

	["test: Should return correct result"] = function ()
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):slice().__data, {"a", "b", "c", "d", "e", "f"})
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):slice(0).__data, {"a", "b", "c", "d", "e", "f"})
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):slice(1).__data, {"a", "b", "c", "d", "e", "f"})
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):slice(3).__data, {"c", "d", "e", "f"})
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):slice(-3).__data, {"d", "e", "f"})
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):slice(0, 0).__data, {"a", "b", "c", "d", "e", "f"})
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):slice(1, 4).__data, {"a", "b", "c", "d"})
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):slice(-5, 5).__data, {"b", "c", "d", "e"})
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):slice(1, 6).__data, {"a", "b", "c", "d", "e", "f"})
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):slice(-6, -1).__data, {"a", "b", "c", "d", "e", "f"})
	end;

	["test: Should make shallow copy of nested array when the array has nested one"] = function ()
		local c = array("c")
		luaunit.assertTrue(rawequal(array("a", "b", c):slice(3, 3).__data[1], c))
	end;

	["test: Should return correct result when the array is full of nils"] = function ()
		luaunit.assertEquals(array(nil, nil, nil, nil, nil, nil):slice(2, -2).__data, {nil, nil, nil, nil})
	end;

	["test: Should return an array with nil when the array has nils"] = function ()
		luaunit.assertEquals(array("a", "b", nil, nil, "e", "f"):slice(2, -2).__data, {"b", nil, nil, "e"})
	end;

	["test: Should return an array with nil at the start when slicing the array after nil"] = function ()
		luaunit.assertEquals(array("a", "b", nil, "e", "f"):slice(3).__data, {nil, "e", "f"})
	end;

	["test: Should return an array with nil at the end when slicing the array before nil"] = function ()
		luaunit.assertEquals(array("a", "b", nil, "e", "f"):slice(1, 3).__data, {"a", "b", nil})
	end;

	["test: Should consider 0 as 1 when passing 0 as the first argument"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):slice(0, 2).__data, {"a", "b"})
	end;

	["test: Should consider 0 as max when passing 0 as the second argument"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):slice(0, 0).__data, {"a", "b", "c"})
	end;

	["test: Shouldn't modify itself"] = function ()
		local a = array("a", "b", "c")
		a:slice(1, 2)
		luaunit.assertEquals(a.__data, {"a", "b", "c"})
	end;

	["test: Should return a new array"] = function ()
		local a = array("a", "b", "c")
		luaunit.assertFalse(rawequal(a, a:slice()))
	end;
}
