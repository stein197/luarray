TestFilter = {
	["test: filter()"] = function ()
		luaunit.assertEquals(array(1, 2, 3, 4):filter(function (v) return v % 2 == 0 end), {[2] = 2, [4] = 4})
	end;

	["test: filter(): Filtering an empty array returns empty one"] = function ()
		luaunit.assertEquals(array():filter(function (v) end), {})
	end;

	["test: filter(): Filtered am array preserves keys"] = function ()
		luaunit.assertEquals(array({a = 1, b = 2, c = 3, d = 4}):filter(function (v) return v % 2 == 0 end), {b = 2, d = 4})
	end;

	["test: filter(): Filtration returns new array"] = function ()
		local a = array(1, 2, 3)
		luaunit.assertNotEquals(a:filter(function (v) return v % 2 == 2 end), a)
	end;

	["test: filter(): Filtration does not modify the initial array"] = function ()
		local a = array(1, 2, 3)
		a:filter(function (v) return v % 2 == 2 end)
		luaunit.assertEquals(a, array(1, 2, 3))
	end;

	["test: filter(): Closure accepts all arguments"] = function ()
		local value, key, tbl
		local a = array({a = 1})
		a:filter(function (v, k, t)
			value = v
			key = k
			tbl = t
		end)
		luaunit.assertEquals(value, 1)
		luaunit.assertEquals(key, "a")
		luaunit.assertTrue(tbl == a)
	end;

	["test: filter(): Filtration preserves keys by default"] = function ()
		luaunit.assertEquals(array(1, 2, 3, 4):filter(function (v) return v % 2 == 0 end), {[2] = 2, [4] = 4})
	end;

	["test: filter(): Filtration preserves keys when \"preservekeys\" is explicitly true"] = function ()
		luaunit.assertEquals(array(1, 2, 3, 4):filter(function (v) return v % 2 == 0 end, true), {[2] = 2, [4] = 4})
	end;

	["test: filter(): Filtration discards keys when \"preservekeys\" is explicitly false"] = function ()
		luaunit.assertEquals(array(1, 2, 3, 4):filter(function (v) return v % 2 == 0 end, false), {2, 4})
	end;

	["test: filter(): Returned value is an array"] = function ()
		luaunit.assertTrue(getmetatable(array():filter(function () end)) == getmetatable(array()))
	end;
}