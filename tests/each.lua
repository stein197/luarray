TestEach = {
	setUp = function (self)
		self.a = array("a", "b", "c")
	end;
	
	["test: Should do nothing when iterating over an empty array"] = function ()
		local tmp
		array():each(function () tmp = 1 end)
		luaunit.assertNil(tmp)
	end;

	["test: Should iterate over all elements"] = function (self)
		local rs = {}
		self.a:each(function (i, elt) rs[i] = elt end)
		luaunit.assertEquals(rs, {"a", "b", "c"})
	end;

	["test: Should iterate over all elements when there are nils"] = function ()
		local a = array("a", nil, "c")
		local rs = {}
		a:each(function (i, elt) rs[i] = elt end)
		luaunit.assertEquals(rs, {"a", nil, "c"})
	end;

	["test: Should iterate over all elements when an array is full of nils"] = function ()
		local a = array(nil, nil, nil)
		local rs = {}
		a:each(function (i, elt) rs[i] = elt end)
		luaunit.assertEquals(rs, {nil, nil, nil})
	end;

	["test: Should not modify an array itself"] = function (self)
		self.a:each(function () return "a" end)
		luaunit.assertEquals(self.a.__data, {"a", "b", "c"})
	end;

	["test: Should pass index and element arguments to the closure"] = function (self)
		local index, element, last
		self.a:each(function (i, elt, l)
			index = i
			element = elt
			last = l
		end)
		luaunit.assertEquals(index, 3)
		luaunit.assertEquals(element, "c")
		luaunit.assertNil(last)
	end;
}
