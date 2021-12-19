TestArray = {

	setUp = function (self)
		self.o = Object()
	end;
	
	["test: Should contain empty \"__data\" when passing no arguments"] = function ()
		luaunit.assertEquals(array().__data, {})
	end;

	["test: Should contain \"__data\" table with one element when passing single argument"] = function ()
		luaunit.assertEquals(array("a").__data, {"a"});
	end;

	["test: Should consider single argument as a source when passing a plain table"] = function ()
		luaunit.assertEquals(array({}).__data, {})
		luaunit.assertEquals(array({"a", "b", "c"}).__data, {"a", "b", "c"})
	end;

	["test: Should consider single argument as an element when passing an array"] = function ()
		local a1 = array(array("a"))
		luaunit.assertEquals(a1.__data[1].__data, {"a"})
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
		luaunit.assertEquals(array("a", "b", "c").__data, {"a", "b", "c"});
		luaunit.assertEquals(array({"a", "b", "c"}).__data, {"a", "b", "c"});
	end;

	["test: Should consider an argument as is when passing a plain table"] = function ()
		luaunit.assertEquals(array({"a", "b", {"c"}}).__data, {"a", "b", {"c"}})
		luaunit.assertEquals(array("a", "b", {"c"}).__data, {"a", "b", {"c"}})
		luaunit.assertEquals(array({{"a"}, "b", "c"}).__data, {{"a"}, "b", "c"})
		luaunit.assertEquals(array({"a"}, "b", "c").__data, {{"a"}, "b", "c"})
	end;

	["test: Should not wrap table when passing at as an element"] = function ()
		luaunit.assertNil(getmetatable(array("a", {"b"}).__data[2]))
	end;

	["test: Should consider an argument as is when passing an array"] = function ()
		local a = array("a", "b", array("c"))
		luaunit.assertEquals(a.__data[3].__data, {"c"})
		luaunit.assertTrue(rawequal(getmetatable(a.__data[3]), getmetatable(a)))
	end;

	["test: Should consider an argument as is when passing an object"] = function (self)
		luaunit.assertTrue(rawequal(array("a", "b", self.o).__data[3], self.o));
		luaunit.assertTrue(rawequal(array({"a", "b", self.o}).__data[3], self.o));
	end;

	["test: Should preserve nil when passing it as the first element"] = function ()
		luaunit.assertEquals(array(nil, "b", "c").__data, {nil, "b", "c"});
		luaunit.assertEquals(array({nil, "b", "c"}).__data, {nil, "b", "c"});
	end;

	["test: Should preserve nil when passing it as the middle element"] = function ()
		luaunit.assertEquals(array("a", nil, "c").__data, {"a", nil, "c"});
		luaunit.assertEquals(array({"a", nil, "c"}).__data, {"a", nil, "c"});
	end;

	["test: Should preserve nil when passing it as the last element"] = function ()
		luaunit.assertEquals(array("a", "b", nil).__data, {"a", "b", nil});
		luaunit.assertEquals(array({"a", "b", nil}).__data, {"a", "b", nil});
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
