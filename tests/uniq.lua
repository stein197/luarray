TestUniq = {
	setUp = function (self)
		self.a = array("a", "b", "c")
	end;
	
	["test: Should return an empty array when the array is empty"] = function ()
		luaunit.assertEquals(array():uniq().__data, {})
	end;

	["test: Should return an array equal to the original when the array contains only one element"] = function ()
		luaunit.assertEquals(array("a"):uniq().__data, {"a"})
	end;

	["test: Should remove duplicates when the array contains ones"] = function ()
		luaunit.assertEquals(array("a", "b", "b", "c", "c", "c"):uniq().__data, {"a", "b", "c"})
	end;

	["test: Should preserve order and the first matching element when the array contains duplicates"] = function ()
		luaunit.assertEquals(array("a", "c", "b", "b", "c"):uniq().__data, {"a", "c", "b"})
	end;

	["test: Should return an array equal to the initial when the array has no duplicates"] = function (self)
		luaunit.assertEquals(self.a:uniq().__data, {"a", "b", "c"})
	end;

	["test: Should not modify self"] = function ()
		local a = array("a", "a", "a")
		a:uniq()
		luaunit.assertEquals(a.__data, {"a", "a", "a"})
	end;

	["test: Should return a new array"] = function (self)
		luaunit.assertFalse(rawequal(self.a:uniq(), self.a))
	end;

	["test: Should preserve nil when the array contains nils"] = function ()
		luaunit.assertEquals(array("a", nil, "c", nil):uniq().__data, {"a", nil, "c"})
	end;

	["test: Should return an array equals to the original when the array is full of nils"] = function ()
		luaunit.assertEquals(array(nil, nil, nil):uniq().__data, {nil})
	end;

	["test: Should preserve only one element when the array contains duplicating arrays"] = function ()
		luaunit.assertEquals(array("a", "b", array("c"), array("c")):uniq().__data, {"a", "b", array("c")})
	end;

	["test: Should preserve only one element when the array contains duplicating references to the same object"] = function ()
		local o = Object()
		luaunit.assertEquals(array(o, "b", o):uniq().__data, {{}, "b"})
	end;

	["test: Should preserve all elements when the array contains cloned objects"] = function ()
		local o1 = Object()
		local o2 = Object()
		luaunit.assertEquals(array(o1, "b", o2):uniq().__data, {o1, "b", o2})
	end;
}