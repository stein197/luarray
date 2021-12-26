TestSome = {
	["test: Should return false when searching in empty array"] = function ()
		luaunit.assertFalse(array():some(function () return true end))
	end;

	["test: Should return true when searchin in an array with single truthy value"] = function ()
		luaunit.assertTrue(array("a", "b", "c"):some(function (i, v) return v == "b" end))
	end;

	["test: Should return false when searching in array with all falsy values"] = function ()
		luaunit.assertFalse(array("a", "b", "c"):some(function (i, v) return type(v) == "number" end))
	end;

	["test: Should return true when all values in an array are thuthy"] = function ()
		luaunit.assertTrue(array("a", "b", "c"):some(function (i, v) return type(v) == "string" end))
	end;

	["test: Should return false when closure doesn't return anything"] = function ()
		luaunit.assertFalse(array(true):some(function () end))
	end;

	["test: Should pass index and key arguments to closure"] = function ()
		local index, value, last
		local a = array("a")
		a:some(function (i, v, l)
			index = i
			value = v
			last = l
		end)
		luaunit.assertEquals(index, 1)
		luaunit.assertEquals(value, "a")
		luaunit.assertNil(last)
	end;

	["test: Should return true when searching for nil and there's nil in an array"] = function ()
		luaunit.assertTrue(array("a", nil, "c"):some(function (i, v) return v == "c" end))
	end;

	["test: Should return true when searching for an element that goes after nil"] = function ()
		luaunit.assertTrue(array("a", nil, "c"):some(function (i, v) return v == "c" end))
	end;
}