-- TODO: There is a problem with length assertions. The length of sparse tables is undefined so the behavior of length operator should not rely on the inner length of table
Test__newindex = {
	setUp = function (self)
		self.a1 = array("a", "b", "c")
		self.a2 = array({"a", "b", "c"})
	end;

	["test: Should add a value to an empty array when assigning at 1"] = function ()
		local a1 = array()
		a1[1] = "a"
		luaunit.assertEquals(a1.__data, {"a"})
		local a2 = array({})
		a2[1] = "a"
		luaunit.assertEquals(a2.__data, {"a"})
	end;

	["test: Should add a value to an empty array when assigning at -1"] = function ()
		local a1 = array()
		a1[-1] = "a"
		luaunit.assertEquals(a1.__data, {"a"})
		local a2 = array({})
		a2[-1] = "a"
		luaunit.assertEquals(a2.__data, {"a"})
	end;
	
	["test: Should increase \"__data\" table length at specified index when assigning in an empty array"] = function ()
		local a = array()
		a[4] = "d"
		luaunit.assertEquals(#a, 4)
	end;

	["test: Should do nothing when assigning at 0"] = function (self)
		self.a1[0] = "d"
		luaunit.assertEquals(self.a1.__data, {"a", "b", "c"})
		self.a2[0] = "d"
		luaunit.assertEquals(self.a2.__data, {"a", "b", "c"})
	end;

	["test: Should do nothing when assigning at non numeric index"] = function (self)
		self.a1["string"] = "d"
		luaunit.assertEquals(self.a1.__data, {"a", "b", "c"})
		self.a2["string"] = "d"
		luaunit.assertEquals(self.a2.__data, {"a", "b", "c"})
	end;

	["test: Should do nothing when assigning at index with existing method name"] = function (self)
		self.a1["len"] = "d"
		luaunit.assertEquals(self.a1.__data, {"a", "b", "c"})
		self.a2["len"] = "d"
		luaunit.assertEquals(self.a2.__data, {"a", "b", "c"})
	end;

	["test: Should not override a method when assigning at index with existing method name"] = function (self)
		self.a1["len"] = "d"
		luaunit.assertEquals(type(self.a1.len), "function")
		self.a2["len"] = "d"
		luaunit.assertEquals(type(self.a2.len), "function")
	end;

	["test: Should assign a value and increase \"__data\" table length when assigning at large positive index"] = function (self)
		self.a1[10] = "j"
		luaunit.assertEquals(#self.a1, 10)
		luaunit.assertEquals(self.a1.__data, {"a", "b", "c", nil, nil, nil, nil, nil, nil, "j"})
		self.a2[10] = "j"
		luaunit.assertEquals(#self.a2, 10)
		luaunit.assertEquals(self.a2.__data, {"a", "b", "c", nil, nil, nil, nil, nil, nil, "j"})
	end;

	["test: Should assign a value and increase \"__data\" table length when assigning at large negative index"] = function (self)
		self.a1[-10] = "j"
		luaunit.assertEquals(#self.a1, 10)
		luaunit.assertEquals(self.a1.__data, {"j", nil, nil, nil, nil, nil, nil, "a", "b", "c"})
		self.a2[-10] = "j"
		luaunit.assertEquals(#self.a2, 10)
		luaunit.assertEquals(self.a2.__data, {"j", nil, nil, nil, nil, nil, nil, "a", "b", "c"})
	end;

	["test: Should assign a value and increase \"__data\" table length when assigning nil at large negative index"] = function (self)
		self.a1[-10] = nil
		luaunit.assertEquals(#self.a1, 10)
		luaunit.assertEquals(self.a1.__data, {nil, nil, nil, nil, nil, nil, nil, "a", "b", "c"})
		self.a2[-10] = nil
		luaunit.assertEquals(#self.a2, 10)
		luaunit.assertEquals(self.a2.__data, {nil, nil, nil, nil, nil, nil, nil, "a", "b", "c"})
	end;

	["test: Should override a value when assigning at existing positive index"] = function (self)
		self.a1[2] = "B"
		luaunit.assertEquals(self.a1.__data, {"a", "B", "c"})
		self.a2[2] = "B"
		luaunit.assertEquals(self.a2.__data, {"a", "B", "c"})
	end;

	["test: Should override a value when assigning at existing negative index"] = function (self)
		self.a1[-2] = "B"
		luaunit.assertEquals(self.a1.__data, {"a", "B", "c"})
		self.a2[-2] = "B"
		luaunit.assertEquals(self.a2.__data, {"a", "B", "c"})
	end;

	["test: Should override the first value when assigning at positive min index"] = function (self)
		self.a1[1] = "A"
		luaunit.assertEquals(self.a1.__data, {"A", "b", "c"})
		self.a2[1] = "A"
		luaunit.assertEquals(self.a2.__data, {"A", "b", "c"})
	end;

	["test: Should override the first value when assigning at negative max index"] = function (self)
		self.a1[-3] = "A"
		luaunit.assertEquals(self.a1.__data, {"A", "b", "c"})
		self.a2[-3] = "A"
		luaunit.assertEquals(self.a2.__data, {"A", "b", "c"})
	end;

	["test: Should override the last value when assigning at positive max index"] = function (self)
		self.a1[3] = "C"
		luaunit.assertEquals(self.a1.__data, {"a", "b", "C"})
		self.a2[3] = "C"
		luaunit.assertEquals(self.a2.__data, {"a", "b", "C"})
	end;

	["test: Should override the last value when assigning at negative min index"] = function (self)
		self.a1[-1] = "C"
		luaunit.assertEquals(self.a1.__data, {"a", "b", "C"})
		self.a2[-1] = "C"
		luaunit.assertEquals(self.a2.__data, {"a", "b", "C"})
	end;

	["test: Should add a value to the end when assigning at length + 1 index"] = function (self)
		self.a1[4] = "d"
		luaunit.assertEquals(self.a1.__data, {"a", "b", "c", "d"})
		self.a2[4] = "d"
		luaunit.assertEquals(self.a2.__data, {"a", "b", "c", "d"})
	end;

	["test: Should add a value to the start when assigning at -length - 1 index"] = function (self)
		self.a1[-4] = "d"
		luaunit.assertEquals(self.a1.__data, {"d", "a", "b", "c"})
		self.a2[-4] = "d"
		luaunit.assertEquals(self.a2.__data, {"d", "a", "b", "c"})
	end;

	["test: Should set a value at the start when there is nil at 1"] = function ()
		local a1 = array(nil, "b", "c")
		a1[1] = "a"
		luaunit.assertEquals(a1.__data, {"a", "b", "c"})
		local a2 = array({nil, "b", "c"})
		a2[1] = "a"
		luaunit.assertEquals(a2.__data, {"a", "b", "c"})
	end;

	["test: Should set a value at the start when there is nil at that negative index"] = function ()
		local a1 = array(nil, "b", "c")
		a1[-3] = "a"
		luaunit.assertEquals(a1.__data, {"a", "b", "c"})
		local a2 = array({nil, "b", "c"})
		a2[-3] = "a"
		luaunit.assertEquals(a2.__data, {"a", "b", "c"})
	end;

	["test: Should set a value at the middle when there is nil at that positive index"] = function ()
		local a1 = array("a", nil, "c")
		a1[2] = "b"
		luaunit.assertEquals(a1.__data, {"a", "b", "c"})
		local a2 = array({"a", nil, "c"})
		a2[2] = "b"
		luaunit.assertEquals(a2.__data, {"a", "b", "c"})
	end;

	["test: Should set a value at the middle when there is nil at that negative index"] = function ()
		local a1 = array("a", nil, "c")
		a1[-2] = "b"
		luaunit.assertEquals(a1.__data, {"a", "b", "c"})
		local a2 = array({"a", nil, "c"})
		a2[-2] = "b"
		luaunit.assertEquals(a2.__data, {"a", "b", "c"})
	end;

	["test: Should set a value at the end when there is nil at that positive index"] = function ()
		local a1 = array("a", "b", nil)
		a1[3] = "c"
		luaunit.assertEquals(a1.__data, {"a", "b", "c"})
		local a2 = array({"a", "b", nil})
		a2[3] = "c"
		luaunit.assertEquals(a2.__data, {"a", "b", "c"})
	end;

	["test: Should override the last value at the end when there is nil at -1"] = function ()
		local a1 = array("a", "b", nil)
		a1[-1] = "c"
		luaunit.assertEquals(a1.__data, {"a", "c"})
		local a2 = array({"a", "b", nil})
		a2[-1] = "c"
		luaunit.assertEquals(a2.__data, {"a", "c"})
	end;
}
