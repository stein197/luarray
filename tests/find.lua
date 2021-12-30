TestFind = {
	["test: Should return -1, nil when finding in an empty array"] = function ()
		luaunit.assertEquals(array():find(function () return true end), -1)
	end;

	["test: Should pass expected arguments to closure"] = function ()
		local index, element, last
		array("a"):find(function (i, elt, l)
			index = i
			element = elt
			last = l
		end)
		luaunit.assertEquals(index, 1)
		luaunit.assertEquals(element, "a")
		luaunit.assertNil(last)
	end;

	["test: Should return index and element when finding in an arbitrary array"] = function ()
		local index, element = array("a", "b", "c"):find(function (i, elt) return i % 2 == 0 or elt == "b" end)
		luaunit.assertEquals(index, 2)
		luaunit.assertEquals(element, "b")
	end;

	["test: Should not call closure when finding in an empty array"] = function ()
		local a = "a"
		local closure = function () a = "b" end
		array():find(closure)
		luaunit.assertEquals(a, "a")
	end;

	["test: Should return corrent index when finding nil"] = function ()
		luaunit.assertEquals(array("a", nil, "c"):find(function (i, elt) return elt == nil end), 2)
	end;

	["test: Should return correct element when it goes after nil"] = function ()
		local idx, val = array("a", nil, "c"):find(function (i, elt) return i == 3 end)
		luaunit.assertEquals(idx, 3)
		luaunit.assertEquals(val, "c")
	end;

	["test: Should stop executing closure after finding first matching element"] = function ()
		local index = 0
		array("a", "b", "c"):find(function (i, elt)
			index = index + 1
			return elt == "b"
		end)
		luaunit.assertEquals(index, 2)
	end;
}
