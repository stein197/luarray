TestReduceStart = {
	["test: Should return nil when an array is empty"] = function ()
		luaunit.assertNil(array():reducestart(function () return 1 end))
	end;

	["test: Should return the initial value when an array is empty and the initial value is provided"] = function ()
		luaunit.assertEquals(array():reducestart(function () return "b" end, "a"), "a")
	end;

	["test: Should return the only value when an array has only one value and the initial value is not provided"] = function ()
		luaunit.assertEquals(array("a"):reducestart(function () return "b" end), "a")
	end;

	["test: Should return correct result  when an array has only one value and the initial value is not provided"] = function ()
		luaunit.assertEquals(array(1):reducestart(function (rs, k, v) return rs + v end, 2), 3)
	end;

	["test: Should pass accumulate, index and value arguments to the closure"] = function ()
		local result, index, value, null
		array("a", "b"):reducestart(function (rs, i, v, n)
			result = rs
			index = i
			value = v
			null = n
		end)
		luaunit.assertEquals(result, "a")
		luaunit.assertEquals(index, 2)
		luaunit.assertEquals(value, "b")
		luaunit.assertNil(null)
	end;

	["test: Should pass the initial value to the call of closure when the initial value is provided"] = function ()
		local tmp
		array("a", "b", "c"):reducestart(function (rs)
			if not tmp then
				tmp = rs
			end
		end, "A")
		luaunit.assertEquals(tmp, "A")
	end;

	["test: Should not modify self"] = function ()
		local a = array("a", "b", "c")
		a:reducestart(function () return 1 end)
		luaunit.assertEquals(a.__data, {"a", "b", "c"})
	end;

	["test: Should be correct when the initial value is not provided"] = function ()
		luaunit.assertEquals(array(1, 2, 3):reducestart(function (rs, k, v) return rs + v end), 6)
	end;

	["test: Should be correct when the initial value is provided"] = function ()
		luaunit.assertEquals(array(1, 2, 3):reducestart(function (rs, k, v) return rs + v end, 1), 7)
	end;

	["test: Should iterate from the end to the start"] = function ()
		local tmpidx, tmpval = {}, {}
		array("a", "b", "c"):reducestart(function (rs, i, v)
			table.insert(tmpidx, i)
			table.insert(tmpval, v)
		end)
		luaunit.assertEquals(tmpidx, {2, 3})
		luaunit.assertEquals(tmpval, {"b", "c"})
	end;

	["test: Should interate through nils when there are nils in the array"] = function ()
		local tmpidx, tmpval = {}, {}
		array("a", nil, "c"):reducestart(function (rs, i, v)
			table.insert(tmpidx, i)
			table.insert(tmpval, v)
		end)
		luaunit.assertEquals(tmpidx, {2, 3})
		luaunit.assertEquals(tmpval, {"c"})
	end;

	["test: Should pass the first value as accumulated to the first call of closure when the initial value is not provided"] = function ()
		local tmpidx, tmpval, tmprs
		array("a", "b", "c", "d", "e", "f"):reducestart(function (rs, i, v)
			if tmpidx then
				return
			end
			tmpidx = i
			tmpval = v
			tmprs = rs
		end)
		luaunit.assertEquals(tmpidx, 2)
		luaunit.assertEquals(tmpval, "b")
		luaunit.assertEquals(tmprs, "a")
	end;
}
