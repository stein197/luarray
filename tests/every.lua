TestEvery = {
	["test: every(): Calling on empty array returns true"] = function ()
		luaunit.assertTrue(array():every(function () return false end))
	end;

	["test: every(): Calling on array with single falsy element returns false"] = function ()
		luaunit.assertFalse(array(1, 2, 3):every(function (v) return v <= 2 end))
	end;

	["test: every(): Calling on array with all truthy elements return true"] = function ()
		luaunit.assertTrue(array(1, 2, 3):every(function (v) return type(v) ~= "string" end))
	end;

	["test: every(): Not returning from closure is considered as falsy"] = function ()
		luaunit.assertFalse(array(true):every(function () end))
	end;

	["test: every(): Closure accepts value, key and table itself"] = function ()
		local value, key, tbl
		local a = array({a = 1})
		a:every(function (v, k, t)
			value = v
			key = k
			tbl = t
		end)
		luaunit.assertEquals(value, 1)
		luaunit.assertEquals(key, "a")
		luaunit.assertEquals(tbl, a)
	end;
}