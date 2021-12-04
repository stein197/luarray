TestSome = {
	["test: some(): Calling on empty array returns false"] = function ()
		luaunit.assertFalse(array():some(function () return true end))
	end;

	["test: some(): Calling on array with single trythy element returns true"] = function ()
		luaunit.assertTrue(array(1, 2, 3):some(function (v) return v == 2 end))
	end;

	["test: some(): Calling on array with all falsy elements return false"] = function ()
		luaunit.assertFalse(array(1, 2, 3):some(function (v) return type(v) == "string" end))
	end;

	["test: some(): Calling on array with all truthy elements return true"] = function ()
		luaunit.assertTrue(array(1, 2, 3):some(function (v) return type(v) ~= "string" end))
	end;

	["test: some(): Not returning from closure is considered as falsy"] = function ()
		luaunit.assertFalse(array(true):some(function () end))
	end;

	["test: some(): Closure accepts value, key and table itself"] = function ()
		local value, key, tbl
		local a = array({a = 1})
		a:some(function (v, k, t)
			value = v
			key = k
			tbl = t
		end)
		luaunit.assertEquals(value, 1)
		luaunit.assertEquals(key, "a")
		luaunit.assertEquals(tbl, a)
	end;
}