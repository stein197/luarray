TestSort = {
	["test: Should return an empty array when sorting an empty one"] = function ()
		luaunit.assertEquals(array():sort().__data, {})
	end;

	["test: Should return copy of the array when sorting an array with single item"] = function ()
		luaunit.assertEquals(array("a"):sort().__data, {"a"})
	end;

	["test: Should return correct result when sorting an array with multiple items and omitted sorting function"] = function ()
		luaunit.assertEquals(array("a", "c", "b"):sort().__data, {"a", "b", "c"})
	end;

	["test: Should return correct result when sorting an array with multiple items and custom sorting function"] = function ()
		luaunit.assertEquals(array("a", "c", "b"):sort(function (a, b) return a > b end).__data, {"c", "b", "a"})
	end;

	["test: Should not modify the current array"] = function ()
		local a = array("a", "c", "b")
		a:sort()
		luaunit.assertEquals(a.__data, {"a", "c", "b"})
	end;

	["test: Should return a new array"] = function ()
		local a = array("a", "b", "c")
		luaunit.assertFalse(rawequal(a:sort(), a))
	end;

	["test: Should return an instance of array"] = function ()
		luaunit.assertTrue(rawequal(getmetatable(array()), getmetatable(array():sort())))
	end;

	["test: Should return the same result when sorting already sorted array"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):sort().__data, {"a", "b", "c"})
	end;

	["test: Should place nils in the middle when sorting nils in the middle"] = function ()
		luaunit.assertEquals(array("a", 1, nil):sort(function (a, b)
			if a == "a" then
				return true
			elseif a == 1 then
				return false 
			else
				return true
			end
		end).__data, {"a", nil, 1})
	end;

	["test: Should place nils in the start when sorting nils to the start"] = function ()
		luaunit.assertEquals(array("a", nil, "c"):sort(function (a, b)
			return a == nil or a < b
		end).__data, {nil, "a", "c"})
	end;

	["test: Should place nils in the end when sorting nils to the end"] = function ()
		luaunit.assertEquals(array("a", nil, "c"):sort(function (a, b)
			if a == nil then
				return false
			end
			return a < b
		end).__data, {"a", "c", nil})
	end;

	["test: Should return the same result when sorting an array of nils"] = function ()
		luaunit.assertEquals(array(nil, nil, nil):sort().__data, {nil, nil, nil})
	end;
}
