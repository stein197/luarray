TestEach = {
	["test: each(): Closure accepts all arguments"] = function ()
		local value, key, tbl
		local a = array({a = 1})
		a:each(function (v, k, t)
			value = v
			key = k
			tbl = t
		end)
		luaunit.assertEquals(value, 1)
		luaunit.assertEquals(key, "a")
		luaunit.assertTrue(tbl == a)
	end;
}
