TestReduceEnd = {
	["test: Should return nil when an array is empty"] = function ()
		luaunit.assertNil(array():reduceend(function () return 1 end))
	end;

	["test: Should return the initial value when an array is empty and the initial value is provided"] = function ()
		luaunit.assertEquals(array():reduceend(function () return "b" end, "a"), "a")
	end;

	["test: Should return the only value when an array has only one value and the initial value is not provided"] = function ()
		luaunit.assertEquals(array("a"):reduceend(function () return "b" end), "a")
	end;

	["test: Should return correct result  when an array has only one value and the initial value is not provided"] = function ()
		luaunit.assertEquals(array(1):reduceend(function (rs, k, v) return rs + v end, 2), 3)
	end;

	["test: Should pass accumulate, index and value arguments to the closure"] = function ()
		local result, index, value, null
		array("a", "b"):reduceend(function (rs, i, v, n)
			result = rs
			index = i
			value = v
			null = n
		end)
		luaunit.assertEquals(result, "b")
		luaunit.assertEquals(index, 1)
		luaunit.assertEquals(value, "a")
		luaunit.assertNil(null)
	end;

	["test: Should pass the initial value to the first call of closure when the initial value is provided"] = function ()
		local tmp
		array("a", "b", "c"):reduceend(function (rs)
			if not tmp then
				tmp = rs
			end
		end, "A")
		luaunit.assertEquals(tmp, "A")
	end;

	["test: Should not modify self"] = function ()
		local a = array("a", "b", "c")
		a:reduceend(function () return 1 end)
		luaunit.assertEquals(a.__data, {"a", "b", "c"})
	end;

	["test: Should be correct when the initial value is not provided"] = function ()
		luaunit.assertEquals(array(1, 2, 3):reduceend(function (rs, k, v) return rs + v end), 6)
	end;

	["test: Should be correct when the initial value is provided"] = function ()
		luaunit.assertEquals(array(1, 2, 3):reduceend(function (rs, k, v) return rs + v end, 1), 7)
	end;

	["test: Should iterate from the end to the start"] = function ()
		local tmpidx, tmpval = {}, {}
		array("a", "b", "c"):reduceend(function (rs, i, v)
			table.insert(tmpidx, i)
			table.insert(tmpval, v)
		end)
		luaunit.assertEquals(tmpidx, {2, 1})
		luaunit.assertEquals(tmpval, {"b", "a"})
	end;

	["test: Should interate through nils when there are nils in the array"] = function ()
		local tmpidx, tmpval = {}, {}
		array("a", nil, "c"):reduceend(function (rs, i, v)
			table.insert(tmpidx, i)
			table.insert(tmpval, v)
		end)
		luaunit.assertEquals(tmpidx, {2, 1})
		luaunit.assertEquals(tmpval, {"a"})
	end;

	["test: Should pass the first value as accumulated to the first call of closure when the initial value is not provided"] = function ()
		local tmpidx, tmpval, tmprs
		array("a", "b", "c", "d", "e", "f"):reduceend(function (rs, i, v)
			if tmpidx then
				return
			end
			tmpidx = i
			tmpval = v
			tmprs = rs
		end)
		luaunit.assertEquals(tmpidx, 5)
		luaunit.assertEquals(tmpval, "e")
		luaunit.assertEquals(tmprs, "f")
	end;
}