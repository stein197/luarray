TestReduceStart = {
	["test: array():reducestart(f) == nil"] = function ()
		luaunit.assertNil(array():reducestart(function () return 1 end))
	end;

	["test: array():reducestart(f, \"a\") == \"a\""] = function ()
		luaunit.assertEquals(array():reducestart(function () return "b" end, "a"), "a")
	end;

	["test: array(\"a\"):reducestart(f) == \"a\""] = function ()
		luaunit.assertEquals(array("a"):reducestart(function () return "b" end), "a")
	end;

	["test: array(1):reducestart(f, 2) == 3"] = function ()
		luaunit.assertEquals(array(1):reducestart(function (rs, k, v) return rs + v end, 2), 3)
	end;

	["test: array(...):reducestart(...) closure accepts all arguments"] = function ()
		local result, key, value, null
		array("a", "b"):reducestart(function (rs, k, v, n)
			result = rs
			key = k
			value = v
			null = n
		end)
		luaunit.assertEquals(result, "a")
		luaunit.assertEquals(key, 2)
		luaunit.assertEquals(value, "b")
		luaunit.assertNil(null)
	end;

	["test: array(...):reducestart(...) does not modify the array itself"] = function ()
		local a = array("a", "b", "c")
		a:reducestart(function () return 1 end)
		luaunit.assertEquals(a, {"a", "b", "c"})
	end;

	["test: array(...):reducestart(f)"] = function ()
		luaunit.assertEquals(array(1, 2, 3):reducestart(function (rs, k, v) return rs + v end), 6)
	end;

	["test: array(...):reducestart(f, init)"] = function ()
		luaunit.assertEquals(array(1, 2, 3):reducestart(function (rs, k, v) return rs + v end, 1), 7)
	end;

	["test: array(...):reducestart(...) goes from start to the end"] = function ()
		local value
		array("a", "b", "c"):reducestart(function (rs, k, v) value = v end)
		luaunit.assertEquals(value, "c")
	end;
}