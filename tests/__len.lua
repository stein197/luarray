-- TODO: Add test case for each tested method that modifies an array
Test__len = {
	setUp = function (self)
		self.a1 = array("a", "b", "c")
		self.a2 = array("d", "e", "f")
		self.a3 = array("a", "b", "c", "d", "e", "f")
	end;
	
	-- array()
	["test: Should return 0 when empty table"] = function ()
		luaunit.assertEquals(#array(), 0)
		luaunit.assertEquals(array():len(), 0)
	end;

	["test: Should be 1 when an array was instantiated with only nil"] = function ()
		luaunit.assertEquals(#array(nil), 1)
		luaunit.assertEquals(array(nil):len(), 1)
	end;

	-- __newindex(), []
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

	-- __concat(), ..
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

	-- filter()
	["test: Should be correct when filtering an arbitrary array"] = function (self)
		luaunit.assertEquals(#self.a1:filter(function (i, v) return i % 2 == 1 end), 2)
		luaunit.assertEquals(self.a1:filter(function (i, v) return i % 2 == 1 end):len(), 2)
	end;

	["test: Should be 0 when filtering an empty array"] = function ()
		luaunit.assertEquals(#array():filter(function (v) end), 0)
		luaunit.assertEquals(array():filter(function (v) end):len(), 0)
	end;

	["test: Should be correct when filtering an array with nils are allowed in predicate"] = function ()
		luaunit.assertEquals(#array("a", nil, "c"):filter(function (i, v) return i >= 2 end), 2)
		luaunit.assertEquals(array("a", nil, "c"):filter(function (i, v) return i >= 2 end):len(), 2)
	end;

	["test: Should be correct when filtering an array with only nils allowed in the predicate"] = function ()
		luaunit.assertEquals(#array("a", nil, "c"):filter(function (i, v) return v == nil end), 1)
		luaunit.assertEquals(array("a", nil, "c"):filter(function (i, v) return v == nil end):len(), 1)
	end;

	["test: Should be equal to the initial array's length when filtering by predicate that returns true for every value"] = function (self)
		luaunit.assertEquals(#self.a1:filter(function () return true end), 3)
		luaunit.assertEquals(self.a1:filter(function () return true end):len(), 3)
	end;

	["test: Should be 0 when filtering by predicate that returns false for every value"] = function (self)
		luaunit.assertEquals(#self.a1:filter(function () return false end), 0)
		luaunit.assertEquals(self.a1:filter(function () return false end):len(), 0)
	end;

	-- map()
	["test: Should be 0 when mapping an empty array"] = function ()
		luaunit.assertEquals(#array():map(function () return 1 end), 0)
		luaunit.assertEquals(array():map(function () return 1 end):len(), 0)
	end;

	["test: Should be 1 when mapping an array with single element"] = function ()
		luaunit.assertEquals(#array("a"):map(function (i, v) return v:upper() end), 1)
		luaunit.assertEquals(array("a"):map(function (i, v) return v:upper() end):len(), 1)
	end;

	["test: Should be equal to the initial array's length when mapping an arbitrary array"] = function (self)
		luaunit.assertEquals(#self.a1:map(function (i, v) return v:upper() end), 3)
		luaunit.assertEquals(self.a1:map(function (i, v) return v:upper() end):len(), 3)
	end;

	["test: Should be equal to the initial array's length when mapping an array with nil"] = function ()
		luaunit.assertEquals(#array("a", nil, "c"):map(function (i, v) return v ~= nil and v:upper() or "nil" end), 3)
		luaunit.assertEquals(array("a", nil, "c"):map(function (i, v) return v ~= nil and v:upper() or "nil" end):len(), 3)
	end;

	["test: Should be equal to the initial array's length when mapping an array full of nils"] = function ()
		luaunit.assertEquals(#array(nil, nil, nil):map(function (i, v) return i * 2 end), 3)
		luaunit.assertEquals(array(nil, nil, nil):map(function (i, v) return i * 2 end):len(), 3)
	end;

	-- clone()
	["test: Should be 0 when cloning an empty one"] = function ()
		luaunit.assertEquals(#array():clone(), 0)
		luaunit.assertEquals(array():clone():len(), 0)
	end;

	["test: Should be 1 when cloning an array with single element"] = function ()
		luaunit.assertEquals(#array("a"):clone(), 1)
		luaunit.assertEquals(array("a"):clone():len(), 1)
	end;

	["test: Should be equal to the initial array's length when cloning an array with multuple elements"] = function (self)
		luaunit.assertEquals(#self.a1:clone(), 3)
		luaunit.assertEquals(self.a1:clone():len(), 3)
	end;
	
	["test: Should be equal to the initial array's length when cloning an array containing nil"] = function ()
		luaunit.assertEquals(#array("a", nil, "c"):clone(), 3)
		luaunit.assertEquals(array("a", nil, "c"):clone():len(), 3)
	end;

	["test: Should be equal to the initial array's length when cloning an array of nils"] = function ()
		luaunit.assertEquals(#array(nil, nil, nil):clone(), 3)
		luaunit.assertEquals(array(nil, nil, nil):clone():len(), 3)
	end;

	["test: Should be equal to the initial's nested array's length when cloning nested array and flag is set to true"] = function ()
		luaunit.assertEquals(#array("a", "b", "c", array("d", "e", "f")):clone(true).__data[4], 3)
		luaunit.assertEquals(array("a", "b", "c", array("d", "e", "f")):clone(true).__data[4]:len(), 3)
	end;

	["test: Should be equal to the initial's nested array's length when cloning nested array and flag is set to false"] = function ()
		luaunit.assertEquals(#array("a", "b", "c", array("d", "e", "f")):clone(false).__data[4], 3)
		luaunit.assertEquals(array("a", "b", "c", array("d", "e", "f")):clone(false).__data[4]:len(), 3)
	end;

	["test: Should be equal to the initial's nested array's length when cloning nested array and flag is not set"] = function ()
		luaunit.assertEquals(#array("a", "b", "c", array("d", "e", "f")):clone().__data[4], 3)
		luaunit.assertEquals(array("a", "b", "c", array("d", "e", "f")):clone().__data[4]:len(), 3)
	end;

	-- sort()
	["test: Should be 0 when sorting an empty array"] = function ()
		luaunit.assertEquals(#array():sort(), 0)
		luaunit.assertEquals(array():sort():len(), 0)
	end;

	["test: Should be 1 when sorting an array with single item"] = function ()
		luaunit.assertEquals(#array("a"):sort(), 1)
		luaunit.assertEquals(array("a"):sort():len(), 1)
	end;

	["test: Should be equal to the initial array's length when sorting an array with multiple items and omitted sorting function"] = function ()
		luaunit.assertEquals(#array("a", "c", "b"):sort(), 3)
		luaunit.assertEquals(array("a", "c", "b"):sort():len(), 3)
	end;

	["test: Should be equal to the initial array's length sorting an array with multiple items and custom sorting function"] = function ()
		luaunit.assertEquals(#array("a", "c", "b"):sort(function (a, b) return a > b end), 3)
		luaunit.assertEquals(array("a", "c", "b"):sort(function (a, b) return a > b end):len(), 3)
	end;

	["test: Should be equal to the initial array's length when sorting already sorted array"] = function ()
		luaunit.assertEquals(#array("a", "b", "c"):sort(), 3)
		luaunit.assertEquals(array("a", "b", "c"):sort():len(), 3)
	end;

	["test: Should be equal to the initial array's length when sorting nils to the start"] = function ()
		luaunit.assertEquals(#array("a", nil, "c"):sort(function (a, b) return a == nil or a < b end), 3)
		luaunit.assertEquals(array("a", nil, "c"):sort(function (a, b) return a == nil or a < b end):len(), 3)
	end;

	["test: Should be equal to the initial array's length when sorting nils to the end"] = function ()
		luaunit.assertEquals(#array("a", nil, "c"):sort(function (a, b)
			if a == nil then
				return false
			end
			return a < b
		end), 3)
		luaunit.assertEquals(array("a", nil, "c"):sort(function (a, b)
			if a == nil then
				return false
			end
			return a < b
		end):len(), 3)
	end;

	["test: Should be equal to the initial array's length when sorting an array of nils"] = function ()
		luaunit.assertEquals(#array(nil, nil, nil):sort(), 3)
		luaunit.assertEquals(array(nil, nil, nil):sort():len(), 3)
	end;

	-- shuffle()
	["test: Should be equal to the initial array's length when shuffling"] = function (self)
		luaunit.assertEquals(#self.a3:shuffle(), 6)
		luaunit.assertEquals(self.a3:shuffle():len(), 6)
	end;

	["test: Should be 0 when shuffling an empty array"] = function ()
		luaunit.assertEquals(#array():shuffle(), 0)
		luaunit.assertEquals(array():shuffle():len(), 0)
	end;

	["test: Should be 1 when shuffling an array with single element"] = function ()
		luaunit.assertEquals(#array("a"):shuffle(), 1)
		luaunit.assertEquals(array("a"):shuffle():len(), 1)
	end;

	["test: Should be equal to the initial array's length when shuffling an array with nils"] = function ()
		luaunit.assertItemsEquals(#array("a", nil, "c", nil, "e", nil):shuffle(), 6)
		luaunit.assertItemsEquals(array("a", nil, "c", nil, "e", nil):shuffle():len(), 6)
	end;

	["test: Should be equal to the initial array's length when shuffling an array of nils"] = function ()
		luaunit.assertItemsEquals(#array(nil, nil, nil):shuffle(), 3)
		luaunit.assertItemsEquals(array(nil, nil, nil):shuffle():len(), 3)
	end;

	-- uniq()
	["test: Should be 0 when uniqueizing an empty array"] = function ()
		luaunit.assertEquals(#array():uniq(), 0)
		luaunit.assertEquals(array():uniq():len(), 0)
	end;

	["test: Should be 1 when uniqueizing an array with one value"] = function ()
		luaunit.assertEquals(#array("a"):uniq(), 1)
		luaunit.assertEquals(array("a"):uniq():len(), 1)
	end;

	["test: Should be correct when uniqueizing an array with duplicates"] = function ()
		luaunit.assertEquals(#array("a", "b", "b", "c", "c", "c"):uniq(), 3)
		luaunit.assertEquals(array("a", "b", "b", "c", "c", "c"):uniq():len(), 3)
	end;

	["test: Should be equal to the original array's length when uniqueizing an array without duplicates"] = function (self)
		luaunit.assertEquals(#self.a1:uniq(), 3)
		luaunit.assertEquals(self.a1:uniq():len(), 3)
	end;

	["test: Should be correct when uniqueizing an array with nils"] = function ()
		luaunit.assertEquals(#array("a", nil, "c", nil):uniq(), 3)
		luaunit.assertEquals(array("a", nil, "c", nil):uniq():len(), 3)
	end;

	["test: Should be 1 when uniqueizing an array full of nils"] = function ()
		luaunit.assertEquals(#array(nil, nil, nil):uniq(), 1)
		luaunit.assertEquals(array(nil, nil, nil):uniq():len(), 1)
	end;

	-- reverse()
	["test: Should be 0 when reversing an empty array"] = function ()
		luaunit.assertEquals(#array():reverse(), 0)
		luaunit.assertEquals(array():reverse():len(), 0)
	end;

	["test: Should be 1 when reversing an array with only one value"] = function ()
		luaunit.assertEquals(#array("a"):reverse(), 1)
		luaunit.assertEquals(array("a"):reverse():len(), 1)
	end;

	["test: Should be equal to the original array's length when reversing an array"] = function (self)
		luaunit.assertEquals(#self.a1:reverse(), 3)
		luaunit.assertEquals(self.a1:reverse():len(), 3)
	end;

	["test: Should be equal to the original array's length when reversing an array with nils"] = function ()
		luaunit.assertEquals(#array("a", nil, "c"):reverse(), 3)
		luaunit.assertEquals(array("a", nil, "c"):reverse():len(), 3)
	end;

	["test: Should be equal to the original array's length when reversing an array with nil at the start"] = function ()
		luaunit.assertEquals(#array(nil, "b", "c"):reverse(), 3)
		luaunit.assertEquals(array(nil, "b", "c"):reverse():len(), 3)
	end;

	["test: Should be equal to the original array's length when reversing an array with nil at the end"] = function ()
		luaunit.assertEquals(#array("a", "b", nil):reverse(), 3)
		luaunit.assertEquals(array("a", "b", nil):reverse():len(), 3)
	end;

	-- slice()
	["test: Should be 0 when slicing an empty array"] = function ()
		luaunit.assertEquals(#array():slice(), 0)
		luaunit.assertEquals(array():slice():len(), 0)
		luaunit.assertEquals(#array():slice(0), 0)
		luaunit.assertEquals(array():slice(0):len(), 0)
		luaunit.assertEquals(#array():slice(0, 0), 0)
		luaunit.assertEquals(array():slice(0, 0):len(), 0)
		luaunit.assertEquals(#array():slice(0, 1), 0)
		luaunit.assertEquals(array():slice(0, 1):len(), 0)
	end;

	["test: Should be 1 when slicing an array with only one value"] = function ()
		luaunit.assertEquals(#array("a"):slice(), 1)
		luaunit.assertEquals(array("a"):slice():len(), 1)
		luaunit.assertEquals(#array("a"):slice(0), 1)
		luaunit.assertEquals(array("a"):slice(0):len(), 1)
		luaunit.assertEquals(#array("a"):slice(1), 1)
		luaunit.assertEquals(array("a"):slice(1):len(), 1)
		luaunit.assertEquals(#array("a"):slice(-1), 1)
		luaunit.assertEquals(array("a"):slice(-1):len(), 1)
		luaunit.assertEquals(#array("a"):slice(1, 1), 1)
		luaunit.assertEquals(array("a"):slice(1, 1):len(), 1)
		luaunit.assertEquals(#array("a"):slice(-1, -1), 1)
		luaunit.assertEquals(array("a"):slice(-1, -1):len(), 1)
		luaunit.assertEquals(#array("a"):slice(1, -1), 1)
		luaunit.assertEquals(array("a"):slice(1, -1):len(), 1)
		luaunit.assertEquals(#array("a"):slice(-1, 1), 1)
		luaunit.assertEquals(array("a"):slice(-1, 1):len(), 1)
	end;

	["test: Should be correct when slicing an array"] = function ()
		luaunit.assertEquals(#array("a", "b", "c", "d", "e", "f"):slice(), 6)
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):slice():len(), 6)
		luaunit.assertEquals(#array("a", "b", "c", "d", "e", "f"):slice(0), 6)
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):slice(0):len(), 6)
		luaunit.assertEquals(#array("a", "b", "c", "d", "e", "f"):slice(1), 6)
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):slice(1):len(), 6)
		luaunit.assertEquals(#array("a", "b", "c", "d", "e", "f"):slice(3), 4)
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):slice(3):len(), 4)
		luaunit.assertEquals(#array("a", "b", "c", "d", "e", "f"):slice(-3), 3)
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):slice(-3):len(), 3)
		luaunit.assertEquals(#array("a", "b", "c", "d", "e", "f"):slice(-8), 6)
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):slice(-8):len(), 6)
		luaunit.assertEquals(#array("a", "b", "c", "d", "e", "f"):slice(0, 0), 0)
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):slice(0, 0):len(), 0)
		luaunit.assertEquals(#array("a", "b", "c", "d", "e", "f"):slice(1, 4), 4)
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):slice(1, 4):len(), 4)
		luaunit.assertEquals(#array("a", "b", "c", "d", "e", "f"):slice(-5, 5), 4)
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):slice(-5, 5):len(), 4)
		luaunit.assertEquals(#array("a", "b", "c", "d", "e", "f"):slice(1, 6), 6)
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):slice(1, 6):len(), 6)
		luaunit.assertEquals(#array("a", "b", "c", "d", "e", "f"):slice(-6, -1), 6)
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):slice(-6, -1):len(), 6)
	end;

	["test: Should return correct result when slicing the array full of nils"] = function ()
		luaunit.assertEquals(#array(nil, nil, nil, nil, nil, nil):slice(2, -2), 4)
		luaunit.assertEquals(array(nil, nil, nil, nil, nil, nil):slice(2, -2):len(), 4)
	end;

	["test: Should return corrent result when slicing the array with nils"] = function ()
		luaunit.assertEquals(#array("a", "b", nil, nil, "e", "f"):slice(2, -2), 4)
		luaunit.assertEquals(array("a", "b", nil, nil, "e", "f"):slice(2, -2):len(), 4)
	end;

	["test: Should return corrent result when slicing the array after nil"] = function ()
		luaunit.assertEquals(#array("a", "b", nil, "e", "f"):slice(3), 3)
		luaunit.assertEquals(array("a", "b", nil, "e", "f"):slice(3):len(), 3)
	end;

	["test: Should return corrent result when slicing the array before nil"] = function ()
		luaunit.assertEquals(#array("a", "b", nil, "e", "f"):slice(1, 3), 3)
		luaunit.assertEquals(array("a", "b", nil, "e", "f"):slice(1, 3):len(), 3)
	end;
	-- TODO: Add test cases for __band, __bor, addafter, addbefore, addend, addstart, delat, delend, delstart, diff, intersect, padend, padstart, union, methods
}
