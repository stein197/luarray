TestArray = {

	setUp = function (self)
		self.o = Object()
	end;
	
	["test: Should contain empty \"__data\" when passing no arguments"] = function ()
		luaunit.assertEquals(array().__data, {})
	end;

	["test: Should contain \"__data\" table with one element when passing single argument"] = function ()
		luaunit.assertEquals(array(1).__data, {1});
	end;

	["test: Should consider single argument as a source when passing a plain table"] = function ()
		luaunit.assertEquals(array({}).__data, {})
		luaunit.assertEquals(array({1, 2, 3}).__data, {1, 2, 3})
	end;

	["test: Should consider single argument as an element when passing an array"] = function ()
		local a1 = array(array(1))
		luaunit.assertEquals(a1.__data[1].__data, {1})
		luaunit.assertTrue(getmetatable(a1.__data[1]) == getmetatable(a1))
	end;

	["test: Should consider single argument as an element when passing an object"] = function (self)
		luaunit.assertTrue(rawequal(array(self.o).__data[1], self.o));
		luaunit.assertTrue(rawequal(array({self.o}).__data[1], self.o));
	end;

	["test: Should contain empty \"__data\" table when passing nil as the only element"] = function ()
		luaunit.assertEquals(#array(nil).__data, 0);
		luaunit.assertEquals(#array({nil}).__data, 0);
	end;

	["test: Should contain \"__data\" table with multiple elements when passing multiple arguments"] = function ()
		luaunit.assertEquals(array(1, 2, 3).__data, {1, 2, 3});
		luaunit.assertEquals(array({1, 2, 3}).__data, {1, 2, 3});
	end;

	["test: Should consider an argument as is when passing a plain table"] = function ()
		luaunit.assertEquals(array({1, 2, {3}}).__data, {1, 2, {3}})
		luaunit.assertEquals(array(1, 2, {3}).__data, {1, 2, {3}})
		luaunit.assertEquals(array({1}, 2, 3).__data, {{1}, 2, 3})
	end;

	["test: Should not wrap table when passing at as an element"] = function ()
		luaunit.assertNil(getmetatable(array(1, {2}).__data[2]))
	end;

	["test: Should consider an argument as is when passing an array"] = function ()
		local a = array(1, 2, array(3))
		luaunit.assertEquals(a.__data[3].__data, {3})
		luaunit.assertTrue(rawequal(getmetatable(a.__data[3]), getmetatable(a)))
	end;

	["test: Should consider an argument as is when passing an object"] = function (self)
		luaunit.assertTrue(rawequal(array(1, 2, self.o).__data[3], self.o));
		luaunit.assertTrue(rawequal(array({1, 2, self.o}).__data[3], self.o));
	end;

	["test: Should preserve nil when passing it as the first element"] = function ()
		luaunit.assertEquals(array(nil, 2, 3).__data, {nil, 2, 3});
	end;

	["test: Should preserve nil when passing it as the middle element"] = function ()
		luaunit.assertEquals(array(1, nil, 3).__data, {1, nil, 3});
	end;

	["test: Should preserve nil when passing it as the last element"] = function ()
		luaunit.assertEquals(array(1, 2, nil).__data, {1, 2, nil});
	end;

	["test: Should preserve false when passing it as a first value"] = function ()
		luaunit.assertEquals(array(false, true).__data, {false, true})
		luaunit.assertEquals(array({false, true}).__data, {false, true})
	end;

	["test: Should start indices start from 1"] = function ()
		local index
		for i in ipairs(array("a", "b", "c").__data) do
			index = i
			break
		end
		luaunit.assertEquals(index, 1);
	end;

	["test: array(...)"] = function ()
		luaunit.assertEquals(array("a", "b", "c", {"d"}).__data, {"a", "b", "c", {"d"}});
		luaunit.assertEquals(array({"a", "b", "c", {"d"}}).__data, {"a", "b", "c", {"d"}});
	end;
}
