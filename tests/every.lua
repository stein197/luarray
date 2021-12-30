TestEvery = {
	["test: Should return true when testing an empty array"] = function ()
		luaunit.assertTrue(array():every(function () return false end))
	end;

	["test: Should return false when there's a single falsy element"] = function ()
		luaunit.assertFalse(array("a", "b", "c"):every(function (i, elt) return i <= 2 end))
	end;

	["test: Should return true when all elements are truthy"] = function ()
		luaunit.assertTrue(array("a", "b", "c"):every(function (i, elt) return type(elt) == "string" end))
	end;

	["test: Should return false when closure returns nothing"] = function ()
		luaunit.assertFalse(array(true):every(function () end))
	end;

	["test: Should pass index and element arguments to closure"] = function ()
		local index, element, last
		array("a"):every(function (i, elt, l)
			index = i
			element = elt
			last = l
		end)
		luaunit.assertEquals(index, 1)
		luaunit.assertEquals(element, "a")
		luaunit.assertNil(last)
	end;

	["test: Should stop executing closure after finding first falsy element"] = function ()
		local index = 0
		array("a", "b", "c"):every(function (i, elt)
			index = index + 1
			return elt == "a"
		end)
		luaunit.assertEquals(index, 2)
	end;
}