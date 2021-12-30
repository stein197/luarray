TestSome = {
	["test: Should return false when searching in empty array"] = function ()
		luaunit.assertFalse(array():some(function () return true end))
	end;

	["test: Should return true when searchin in an array with single truthy element"] = function ()
		luaunit.assertTrue(array("a", "b", "c"):some(function (i, elt) return elt == "b" end))
	end;

	["test: Should return false when searching in array with all falsy elements"] = function ()
		luaunit.assertFalse(array("a", "b", "c"):some(function (i, elt) return type(elt) == "number" end))
	end;

	["test: Should return true when all elements in an array are thuthy"] = function ()
		luaunit.assertTrue(array("a", "b", "c"):some(function (i, elt) return type(elt) == "string" end))
	end;

	["test: Should return false when closure doesn't return anything"] = function ()
		luaunit.assertFalse(array(true):some(function () end))
	end;

	["test: Should pass index and key arguments to closure"] = function ()
		local index, element, last
		array("a"):some(function (i, elt, l)
			index = i
			element = elt
			last = l
		end)
		luaunit.assertEquals(index, 1)
		luaunit.assertEquals(element, "a")
		luaunit.assertNil(last)
	end;

	["test: Should return true when searching for nil and there's nil in an array"] = function ()
		luaunit.assertTrue(array("a", nil, "c"):some(function (i, elt) return elt == "c" end))
	end;

	["test: Should return true when searching for an element that goes after nil"] = function ()
		luaunit.assertTrue(array("a", nil, "c"):some(function (i, elt) return elt == "c" end))
	end;

	["test: Should stop executing closure after finding first truthy element"] = function ()
		local index = 0
		array("a", "b", "c"):some(function (i, elt)
			index = index + 1
			return elt == "b"
		end)
		luaunit.assertEquals(index, 2)
	end;
}