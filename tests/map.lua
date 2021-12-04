TestMap = {
	["test: map(): Mapping an empty array returns empty one"] = function ()
		luaunit.assertEquals(array():map(function () return 1 end), {})
	end;

	["test: map(): Mapping an array with single element"] = function ()
		luaunit.assertEquals(array(2):map(function (v) return v * 2 end), {4})
	end;

	["test: map(): Mapping an array with multiple items"] = function ()
		luaunit.assertEquals(array({a = 1, b = 2, c = 3}):map(function (v, k) return v * 2, k..k end), {aa = 2, bb = 4, cc = 6})
	end;

	["test: map(): Mapping closure takes all arguments"] = function ()
		local value, key, tbl
		local a = array({a = 1})
		a:map(function (v, k, t)
			value = v
			key = k
			tbl = t
		end)
		luaunit.assertEquals(value, 1)
		luaunit.assertEquals(key, "a")
		luaunit.assertTrue(tbl == a)
	end;

	["test: map(): Mapping returns different array"] = function ()
		local a = array {1, 2, 3}
		luaunit.assertNotEquals(a:map(function (v) return v * 2 end), a)
	end;

	["test: map(): Mapping does not modify self"] = function ()
		local a = array {1, 2, 3}
		a:map(function (v) return v * 2 end)
		luaunit.assertEquals(a, {1, 2, 3})
	end;
}