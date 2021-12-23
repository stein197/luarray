-- TODO: Add test case for each tested method that modifies an array
Test__len = {
	setUp = function (self)
		self.a1 = array("a", "b", "c")
		self.a2 = array("d", "e", "f")
	end;
	
	["test: Should return 0 when empty table"] = function ()
		luaunit.assertEquals(#array(), 0)
		luaunit.assertEquals(array():len(), 0)
	end;

	["test: Should be 1 when an array was instantiated with only nil"] = function ()
		luaunit.assertEquals(#array(nil), 1)
		luaunit.assertEquals(array(nil):len(), 1)
	end;

	["test: Should be 1 when assigning a value in an empty array at 1"] = function ()
		local a1 = array()
		a1[1] = "a"
		luaunit.assertEquals(#a1, 1)
		luaunit.assertEquals(a1:len(), 1)
	end;

	["test: Should be 1 when assigning a value in an empty array at -1"] = function ()
		local a1 = array()
		a1[-1] = "a"
		luaunit.assertEquals(#a1, 1)
		luaunit.assertEquals(a1:len(), 1)
	end;

	["test: Should not change when assigning at 0"] = function (self)
		self.a1[0] = "d"
		luaunit.assertEquals(#self.a1, 3)
		luaunit.assertEquals(self.a1:len(), 3)
	end;

	["test: Should not change when assigning at non numeric index"] = function (self)
		self.a1["string"] = "d"
		luaunit.assertEquals(#self.a1, 3)
		luaunit.assertEquals(self.a1:len(), 3)
	end;

	["test: Should not change when assigning at index with existing method name"] = function (self)
		self.a1["len"] = "d"
		luaunit.assertEquals(#self.a1, 3)
		luaunit.assertEquals(self.a1:len(), 3)
	end;

	["test: Should be equal to a new index when assigning a value at large positive index"] = function (self)
		self.a1[10] = "j"
		luaunit.assertEquals(#self.a1, 10)
		luaunit.assertEquals(self.a1:len(), 10)
	end;

	["test: Should be equal to a new index when assigning a value at large negative index"] = function (self)
		self.a1[-10] = "j"
		luaunit.assertEquals(#self.a1, 10)
		luaunit.assertEquals(self.a1:len(), 10)
	end;

	["test: Should be equal to a new index when assigning nil at large positive index"] = function (self)
		self.a1[10] = nil
		luaunit.assertEquals(#self.a1, 10)
		luaunit.assertEquals(self.a1:len(), 10)
	end;

	["test: Should be equal to a new index when assigning nil at large negative index"] = function (self)
		self.a1[-10] = nil
		luaunit.assertEquals(#self.a1, 10)
		luaunit.assertEquals(self.a1:len(), 10)
	end;

	["test: Should not change when reassigning a value at existing positive index"] = function (self)
		self.a1[2] = "B"
		luaunit.assertEquals(#self.a1, 3)
		luaunit.assertEquals(self.a1:len(), 3)
	end;

	["test: Should not change when reassigning a value at existing negative index"] = function (self)
		self.a1[-2] = "B"
		luaunit.assertEquals(#self.a1, 3)
		luaunit.assertEquals(self.a1:len(), 3)
	end;

	["test: Should not change when reassigning the first value at 1"] = function (self)
		self.a1[1] = "A"
		luaunit.assertEquals(#self.a1, 3)
		luaunit.assertEquals(self.a1:len(), 3)
	end;

	["test: Should not change when reassigning the first at negative max index"] = function (self)
		self.a1[-3] = "A"
		luaunit.assertEquals(#self.a1, 3)
		luaunit.assertEquals(self.a1:len(), 3)
	end;

	["test: Should not change when reassigning the last value at positive max index"] = function (self)
		self.a1[3] = "C"
		luaunit.assertEquals(#self.a1, 3)
		luaunit.assertEquals(self.a1:len(), 3)
	end;

	["test: Should not change when reassigning the last value at -1"] = function (self)
		self.a1[-1] = "C"
		luaunit.assertEquals(#self.a1, 3)
		luaunit.assertEquals(self.a1:len(), 3)
	end;

	["test: Should be increased by 1 when assigning a value at length + 1 index"] = function (self)
		self.a1[4] = "d"
		luaunit.assertEquals(#self.a1, 4)
		luaunit.assertEquals(self.a1:len(), 4)
	end;

	["test: Should be increased by 1 when assigning a value at -length - 1 index"] = function (self)
		self.a1[-4] = "d"
		luaunit.assertEquals(#self.a1, 4)
		luaunit.assertEquals(self.a1:len(), 4)
	end;

	["test: Should not change when assigning a value at the start and there is nil at that negative index"] = function ()
		local a1 = array(nil, "b", "c")
		a1[-3] = "a"
		luaunit.assertEquals(#a1, 3)
		luaunit.assertEquals(a1:len(), 3)
	end;

	["test: Should not change when assigning a value at the middle and there is nil at that positive index"] = function ()
		local a1 = array("a", nil, "c")
		a1[2] = "b"
		luaunit.assertEquals(#a1, 3)
		luaunit.assertEquals(a1:len(), 3)
	end;

	["test: Should not change when assigning a value at the middle and there is nil at that negative index"] = function ()
		local a1 = array("a", nil, "c")
		a1[-2] = "b"
		luaunit.assertEquals(#a1, 3)
		luaunit.assertEquals(a1:len(), 3)
	end;

	["test: Should not change when assigning a value at the end and there is nil at that positive index"] = function ()
		local a1 = array("a", "b", nil)
		a1[3] = "c"
		luaunit.assertEquals(#a1, 3)
		luaunit.assertEquals(a1:len(), 3)
	end;

	["test: Should not change when assigning a value at the start and there is nil at 1"] = function ()
		local a1 = array(nil, "b", "c")
		a1[1] = "a"
		luaunit.assertEquals(#a1, 3)
		luaunit.assertEquals(a1:len(), 3)
	end;

	["test: Should not change when assigning a value at the end and there is nil at -1"] = function ()
		local a1 = array("a", "b", nil)
		a1[-1] = "c"
		luaunit.assertEquals(#a1, 3)
		luaunit.assertEquals(a1:len(), 3)
	end;

	["test: Should be 0 when concatenating empty arrays"] = function ()
		luaunit.assertEquals(#(array()..array()), 0)
		luaunit.assertEquals((array()..array()):len(), 0)
	end;

	["test: Should be 1 when concatenating an array with single element with empty one"] = function ()
		luaunit.assertEquals(#(array()..array("a")), 1)
		luaunit.assertEquals((array()..array("a")):len(), 1)
	end;

	["test: Should be 1 when concatenating an array with nil with empty one"] = function ()
		luaunit.assertEquals(#(array()..array(nil)), 1)
		luaunit.assertEquals((array()..array(nil)):len(), 1)
	end;

	["test: Should be a sum of two arrays' lengths when concatenating arrays with intersecting values"] = function ()
		luaunit.assertEquals(#(array("a", "b", "c")..array("a", "c")), 5)
		luaunit.assertEquals((array("a", "b", "c")..array("a", "c")):len(), 5)
	end;

	["test: Should be increased 2 times when concatenating with self"] = function (self)
		luaunit.assertEquals(#(self.a1..self.a1), 6)
		luaunit.assertEquals((self.a1..self.a1):len(), 6)
	end;

	["test: Should be a sum of two arrays' lengths when concatenating arbitrary arrays"] = function (self)
		luaunit.assertEquals(#(self.a1..self.a2), 6)
		luaunit.assertEquals((self.a1..self.a2):len(), 6)
	end;

	["test: Should be a sum of two arrays' lengths when concatenating arrays with nils"] = function ()
		luaunit.assertEquals(#(array("a", nil, "c")..array(nil, "e", "f")), 6)
		luaunit.assertEquals((array("a", nil, "c")..array(nil, "e", "f")):len(), 6)
	end;

	["test: Should be a sum of two arrays' lengths when concatenating arrays of nils"] = function ()
		luaunit.assertEquals(#(array(nil)..array(nil, nil, nil)), 4)
		luaunit.assertEquals((array(nil)..array(nil, nil, nil)):len(), 4)
	end;

	["test: Should be a sum of arrays' lengths when concatenating more than two arrays"] = function (self)
		luaunit.assertEquals(#(self.a1..self.a2..array("g", "h", "i")), 9)
		luaunit.assertEquals((self.a1..self.a2..array("g", "h", "i")):len(), 9)
	end;

	["test: Should be a sum of two arrays' lengths when concatenating array of booleans"] = function ()
		luaunit.assertEquals(#(array(false, true, false)..array(false, true, false)), 6)
		luaunit.assertEquals((array(false, true, false)..array(false, true, false)):len(), 6)
	end;

	-- TODO: Add test cases for __band, __bor, addafter, addbefore, addend, addstart, clone, delat, delend, delstart, diff, filter, intersect, map, padend, padstart, reverse, shuffle, slice, union, uniq methods
}