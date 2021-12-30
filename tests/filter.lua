TestFilter = {
	setUp = function (self)
		self.a = array("a", "b", "c")
	end;
	
	["test: Should return correct result"] = function (self)
		luaunit.assertEquals(self.a:filter(function (i, elt) return i % 2 == 1 end).__data, {"a", "c"})
	end;

	["test: Should return an empty array when filtering an empty one"] = function ()
		luaunit.assertEquals(array():filter(function (elt) end).__data, {})
	end;

	["test: Should return a new array"] = function (self)
		luaunit.assertFalse(rawequal(self.a, self.a:filter(function (i) return i % 2 == 2 end)))
	end;

	["test: Should not modify the initial array"] = function (self)
		self.a:filter(function (i) return i % 2 == 2 end)
		luaunit.assertEquals(self.a.__data, {"a", "b", "c"})
	end;

	["test: Should pass index and element arguments to the closure"] = function (self)
		local index, element, last
		self.a:filter(function (i, elt, l)
			index = i
			element = elt
			last = l
		end)
		luaunit.assertEquals(index, 3)
		luaunit.assertEquals(element, "c")
		luaunit.assertNil(last)
	end;

	["test: Should return correct result when there're nils in predicate"] = function ()
		luaunit.assertEquals(array("a", nil, "c"):filter(function (i, elt) return i >= 2 end).__data, {nil, "c"})
	end;

	["test: Should return correct result when predicate returns true for nil"] = function ()
		luaunit.assertEquals(array("a", nil, "c"):filter(function (i, elt) return elt == nil end).__data, {nil})
	end;

	["test: Should return the copy of the array when predicate returns true for every element"] = function (self)
		luaunit.assertEquals(self.a:filter(function () return true end).__data, {"a", "b", "c"})
	end;

	["test: Should return an empty array when predicate returns false for every element"] = function (self)
		luaunit.assertEquals(self.a:filter(function () return false end).__data, {})
	end;
}