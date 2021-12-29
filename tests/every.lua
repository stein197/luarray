TestEvery = {
	["test: Should return true when testing an empty array"] = function ()
		luaunit.assertTrue(array():every(function () return false end))
	end;

	["test: Should return false when there's a single falsy value"] = function ()
		luaunit.assertFalse(array("a", "b", "c"):every(function (i, v) return i <= 2 end))
	end;

	["test: Should return true when all values are truthy"] = function ()
		luaunit.assertTrue(array("a", "b", "c"):every(function (i, v) return type(v) == "string" end))
	end;

	["test: Should return false when closure returns nothing"] = function ()
		luaunit.assertFalse(array(true):every(function () end))
	end;

	["test: Should pass index and value arguments to closure"] = function ()
		local index, value, last
		array("a"):every(function (i, v, l)
			index = i
			value = v
			last = l
		end)
		luaunit.assertEquals(index, 1)
		luaunit.assertEquals(value, "a")
		luaunit.assertNil(last)
	end;

	["test: Should stop executing closure after finding first falsy value"] = function ()
		local index = 0
		array("a", "b", "c"):every(function (i, v)
			index = index + 1
			return v == "a"
		end)
		luaunit.assertEquals(index, 2)
	end;
}