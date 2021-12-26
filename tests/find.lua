TestFind = {
	["test: Should return nil, nil when finding in an empty array"] = function ()
		luaunit.assertNil(array():find(function () return true end))
	end;

	["test: Should pass expected arguments to closure"] = function ()
		local index, value, last
		array("a"):find(function (i, v, l)
			index = i
			value = v
			last = l
		end)
		luaunit.assertEquals(index, 1)
		luaunit.assertEquals(value, "a")
		luaunit.assertNil(last)
	end;

	["test: Should return index and value when finding in an arbitrary array"] = function ()
		local index, value = array("a", "b", "c"):find(function (i, v) return i % 2 == 0 or v == "b" end)
		luaunit.assertEquals(index, 2)
		luaunit.assertEquals(value, "b")
	end;

	["test: Should not call closure when finding in an empty array"] = function ()
		local a = "a"
		local closure = function () a = "b" end
		array():find(closure)
		luaunit.assertEquals(a, "a")
	end;

	["test: Should return corrent index when finding nil"] = function ()
		luaunit.assertEquals(array("a", nil, "b"):find(function (i, v) return v == nil end), 2)
	end;
}
