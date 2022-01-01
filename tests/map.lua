TestMap = {
	setUp = function (self)
		self.a = array("a", "b", "c")
	end;
	
	["test: Should return an empty array when mapping an empty one"] = function ()
		luaunit.assertEquals(array():map(function () return 1 end).__data, {})
	end;

	["test: Should return correct result when mapping an array with single element"] = function ()
		luaunit.assertEquals(array("a"):map(function (i, elt) return elt:upper() end).__data, {"A"})
	end;

	["test: Should return correct result when mapping an arbitrary array"] = function (self)
		luaunit.assertEquals(self.a:map(function (i, elt) return elt:upper() end).__data, {"A", "B", "C"})
	end;

	["test: Should pass index and element arguments to the closure"] = function (self)
		local key, element, last
		self.a:map(function (i, elt, l)
			key = i
			element = elt
			last = l
		end)
		luaunit.assertEquals(key, 3)
		luaunit.assertEquals(element, "c")
		luaunit.assertNil(last)
	end;

	["test: Should return a new array array"] = function (self)
		luaunit.assertFalse(rawequal(self.a:map(function (i, elt) return i * 2 end), self.a))
	end;

	["test: Shouldn't modify itself"] = function (self)
		self.a:map(function (i) return i * 2 end)
		luaunit.assertEquals(self.a.__data, {"a", "b", "c"})
	end;

	["test: Should return correct result when mapping an array with nil"] = function ()
		luaunit.assertEquals(array("a", nil, "c"):map(function (i, elt) return elt ~= nil and elt:upper() or "nil" end).__data, {"A", "nil", "C"})
	end;

	["test: Should return correct result when mapping an array full of nils"] = function ()
		luaunit.assertEquals(array(nil, nil, nil):map(function (i, elt) return i * 2 end).__data, {2, 4, 6})
	end;
}