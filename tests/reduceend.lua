TestReduceEnd = {
	["test: array():reduceend(f) == nil"] = function ()
		luaunit.assertNil(array():reduceend(function () return 1 end))
	end;

	["test: array():reduceend(f, \"a\") == \"a\""] = function ()
		luaunit.assertEquals(array():reduceend(function () return "b" end, "a"), "a")
	end;

	["test: array(\"a\"):reduceend(f) == \"a\""] = function ()
		luaunit.assertEquals(array("a"):reduceend(function () return "b" end), "a")
	end;

	["test: array(1):reduceend(f, 2) == 3"] = function ()
		luaunit.assertEquals(array(1):reduceend(function (rs, k, v) return rs + v end, 2), 3)
	end;

	["test: array(...):reduceend(...) closure accepts all arguments"] = function ()
		local result, key, value, null
		array("a", "b"):reduceend(function (rs, k, v, n)
			result = rs
			key = k
			value = v
			null = n
		end)
		luaunit.assertEquals(result, "b")
		luaunit.assertEquals(key, 1)
		luaunit.assertEquals(value, "a")
		luaunit.assertNil(null)
	end;

	["test: array(...):reduceend(...) does not modify the array itself"] = function ()
		local a = array("a", "b", "c")
		a:reduceend(function () return 1 end)
		luaunit.assertEquals(a, {"a", "b", "c"})
	end;

	["test: array(...):reduceend(f)"] = function ()
		luaunit.assertEquals(array(1, 2, 3):reduceend(function (rs, k, v) return rs + v end), 6)
	end;

	["test: array(...):reduceend(f, init)"] = function ()
		luaunit.assertEquals(array(1, 2, 3):reduceend(function (rs, k, v) return rs + v end, 1), 7)
	end;
}