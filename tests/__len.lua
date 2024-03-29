Test__len = {
	setUp = function (self)
		self.a0 = array("a")
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
	["test: Should be 1 when assigning a element in an empty array at 1"] = function ()
		local a1 = array()
		a1[1] = "a"
		luaunit.assertEquals(#a1, 1)
		luaunit.assertEquals(a1:len(), 1)
	end;

	["test: Should be 1 when assigning a element in an empty array at -1"] = function ()
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

	["test: Should be equal to a new index when assigning a element at large positive index"] = function (self)
		self.a1[10] = "j"
		luaunit.assertEquals(#self.a1, 10)
		luaunit.assertEquals(self.a1:len(), 10)
	end;

	["test: Should be equal to a new index when assigning a element at large negative index"] = function (self)
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

	["test: Should not change when reassigning a element at existing positive index"] = function (self)
		self.a1[2] = "B"
		luaunit.assertEquals(#self.a1, 3)
		luaunit.assertEquals(self.a1:len(), 3)
	end;

	["test: Should not change when reassigning a element at existing negative index"] = function (self)
		self.a1[-2] = "B"
		luaunit.assertEquals(#self.a1, 3)
		luaunit.assertEquals(self.a1:len(), 3)
	end;

	["test: Should not change when reassigning the first element at 1"] = function (self)
		self.a1[1] = "A"
		luaunit.assertEquals(#self.a1, 3)
		luaunit.assertEquals(self.a1:len(), 3)
	end;

	["test: Should not change when reassigning the first at negative max index"] = function (self)
		self.a1[-3] = "A"
		luaunit.assertEquals(#self.a1, 3)
		luaunit.assertEquals(self.a1:len(), 3)
	end;

	["test: Should not change when reassigning the last element at positive max index"] = function (self)
		self.a1[3] = "C"
		luaunit.assertEquals(#self.a1, 3)
		luaunit.assertEquals(self.a1:len(), 3)
	end;

	["test: Should not change when reassigning the last element at -1"] = function (self)
		self.a1[-1] = "C"
		luaunit.assertEquals(#self.a1, 3)
		luaunit.assertEquals(self.a1:len(), 3)
	end;

	["test: Should be increased by 1 when assigning a element at length + 1 index"] = function (self)
		self.a1[4] = "d"
		luaunit.assertEquals(#self.a1, 4)
		luaunit.assertEquals(self.a1:len(), 4)
	end;

	["test: Should be increased by 1 when assigning a element at -length - 1 index"] = function (self)
		self.a1[-4] = "d"
		luaunit.assertEquals(#self.a1, 4)
		luaunit.assertEquals(self.a1:len(), 4)
	end;

	["test: Should not change when assigning a element at the start and there is nil at that negative index"] = function ()
		local a1 = array(nil, "b", "c")
		a1[-3] = "a"
		luaunit.assertEquals(#a1, 3)
		luaunit.assertEquals(a1:len(), 3)
	end;

	["test: Should not change when assigning a element at the middle and there is nil at that positive index"] = function ()
		local a1 = array("a", nil, "c")
		a1[2] = "b"
		luaunit.assertEquals(#a1, 3)
		luaunit.assertEquals(a1:len(), 3)
	end;

	["test: Should not change when assigning a element at the middle and there is nil at that negative index"] = function ()
		local a1 = array("a", nil, "c")
		a1[-2] = "b"
		luaunit.assertEquals(#a1, 3)
		luaunit.assertEquals(a1:len(), 3)
	end;

	["test: Should not change when assigning a element at the end and there is nil at that positive index"] = function ()
		local a1 = array("a", "b", nil)
		a1[3] = "c"
		luaunit.assertEquals(#a1, 3)
		luaunit.assertEquals(a1:len(), 3)
	end;

	["test: Should not change when assigning a element at the start and there is nil at 1"] = function ()
		local a1 = array(nil, "b", "c")
		a1[1] = "a"
		luaunit.assertEquals(#a1, 3)
		luaunit.assertEquals(a1:len(), 3)
	end;

	["test: Should not change when assigning a element at the end and there is nil at -1"] = function ()
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

	["test: Should be a sum of two arrays' lengths when concatenating arrays with intersecting elements"] = function ()
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
		luaunit.assertEquals(#self.a1:filter(function (i, elt) return i % 2 == 1 end), 2)
		luaunit.assertEquals(self.a1:filter(function (i, elt) return i % 2 == 1 end):len(), 2)
	end;

	["test: Should be 0 when filtering an empty array"] = function ()
		luaunit.assertEquals(#array():filter(function (elt) end), 0)
		luaunit.assertEquals(array():filter(function (elt) end):len(), 0)
	end;

	["test: Should be correct when filtering an array with nils are allowed in predicate"] = function ()
		luaunit.assertEquals(#array("a", nil, "c"):filter(function (i, elt) return i >= 2 end), 2)
		luaunit.assertEquals(array("a", nil, "c"):filter(function (i, elt) return i >= 2 end):len(), 2)
	end;

	["test: Should be correct when filtering an array with only nils allowed in the predicate"] = function ()
		luaunit.assertEquals(#array("a", nil, "c"):filter(function (i, elt) return elt == nil end), 1)
		luaunit.assertEquals(array("a", nil, "c"):filter(function (i, elt) return elt == nil end):len(), 1)
	end;

	["test: Should be equal to the initial array's length when filtering by predicate that returns true for every element"] = function (self)
		luaunit.assertEquals(#self.a1:filter(function () return true end), 3)
		luaunit.assertEquals(self.a1:filter(function () return true end):len(), 3)
	end;

	["test: Should be 0 when filtering by predicate that returns false for every element"] = function (self)
		luaunit.assertEquals(#self.a1:filter(function () return false end), 0)
		luaunit.assertEquals(self.a1:filter(function () return false end):len(), 0)
	end;

	-- map()
	["test: Should be 0 when mapping an empty array"] = function ()
		luaunit.assertEquals(#array():map(function () return 1 end), 0)
		luaunit.assertEquals(array():map(function () return 1 end):len(), 0)
	end;

	["test: Should be 1 when mapping an array with single element"] = function ()
		luaunit.assertEquals(#array("a"):map(function (i, elt) return elt:upper() end), 1)
		luaunit.assertEquals(array("a"):map(function (i, elt) return elt:upper() end):len(), 1)
	end;

	["test: Should be equal to the initial array's length when mapping an arbitrary array"] = function (self)
		luaunit.assertEquals(#self.a1:map(function (i, elt) return elt:upper() end), 3)
		luaunit.assertEquals(self.a1:map(function (i, elt) return elt:upper() end):len(), 3)
	end;

	["test: Should be equal to the initial array's length when mapping an array with nil"] = function ()
		luaunit.assertEquals(#array("a", nil, "c"):map(function (i, elt) return elt ~= nil and elt:upper() or "nil" end), 3)
		luaunit.assertEquals(array("a", nil, "c"):map(function (i, elt) return elt ~= nil and elt:upper() or "nil" end):len(), 3)
	end;

	["test: Should be equal to the initial array's length when mapping an array full of nils"] = function ()
		luaunit.assertEquals(#array(nil, nil, nil):map(function (i, elt) return i * 2 end), 3)
		luaunit.assertEquals(array(nil, nil, nil):map(function (i, elt) return i * 2 end):len(), 3)
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

	["test: Should be 1 when uniqueizing an array with one element"] = function ()
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

	["test: Should be 1 when reversing an array with only one element"] = function ()
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

	["test: Should be 1 when slicing an array with only one element"] = function ()
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
		luaunit.assertEquals(#array("a", "b", "c", "d", "e", "f"):slice(0, 0), 6)
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):slice(0, 0):len(), 6)
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

	-- padstart()
	["test: Should be 0 when padding an empty array at the start"] = function ()
		luaunit.assertEquals(#array():padstart(0, "a"), 0)
		luaunit.assertEquals(array():padstart(0, "a"):len(), 0)
	end;

	["test: Should be equal to the first argument when padding an empty array at the start"] = function ()
		luaunit.assertEquals(#array():padstart(3, "a"), 3)
		luaunit.assertEquals(array():padstart(3, "a"):len(), 3)
	end;

	["test: Should be equal to the original array's length when padding an array to 0 at the start"] = function ()
		luaunit.assertEquals(#array("a"):padstart(0, "a"), 1)
		luaunit.assertEquals(array("a"):padstart(0, "a"):len(), 1)
	end;

	["test: Should be equal to the original array's length when padding an array to its length at the start"] = function ()
		luaunit.assertEquals(#array("a"):padstart(1, "a"), 1)
		luaunit.assertEquals(array("a"):padstart(1, "a"):len(), 1)
		luaunit.assertEquals(#array("a", "b", "c"):padstart(3, "a"), 3)
		luaunit.assertEquals(array("a", "b", "c"):padstart(3, "a"):len(), 3)
	end;

	["test: Should be equal to the original array's length when padding an array to negative length at the start"] = function ()
		luaunit.assertEquals(#array("a", "b", "c"):padstart(-3, "d"), 3)
		luaunit.assertEquals(array("a", "b", "c"):padstart(-3, "d"):len(), 3)
	end;

	["test: Should be equal to the original array's length when padding an array to a length lesser than the array's one at the start"] = function ()
		luaunit.assertEquals(#array("a", "b", "c"):padstart(2, "d"), 3)
		luaunit.assertEquals(array("a", "b", "c"):padstart(2, "d"):len(), 3)
	end;

	["test: Should be correct when padding an array at the start"] = function ()
		luaunit.assertEquals(#array("a"):padstart(3, "b"), 3)
		luaunit.assertEquals(array("a"):padstart(3, "b"):len(), 3)
		luaunit.assertEquals(#array("a", "b", "c"):padstart(5, "d"), 5)
		luaunit.assertEquals(array("a", "b", "c"):padstart(5, "d"):len(), 5)
	end;

	["test: Should be greater than the original one's when padding an array to a length greater than array's one by 1 at the start"] = function ()
		luaunit.assertEquals(#array("a"):padstart(2, "b"), 2)
		luaunit.assertEquals(array("a"):padstart(2, "b"):len(), 2)
		luaunit.assertEquals(#array("a", "b", "c"):padstart(4, "d"), 4)
		luaunit.assertEquals(array("a", "b", "c"):padstart(4, "d"):len(), 4)
	end;

	["test: Should be correct when padding an array and there are nils at the start"] = function ()
		luaunit.assertEquals(#array(nil, "b", "c"):padstart(4, "d"), 4)
		luaunit.assertEquals(array(nil, "b", "c"):padstart(4, "d"):len(), 4)
		luaunit.assertEquals(#array(nil, "b", "c"):padstart(6, "d"), 6)
		luaunit.assertEquals(array(nil, "b", "c"):padstart(6, "d"):len(), 6)
	end;

	["test: Should be correct when padding an array with nils at the start"] = function ()
		luaunit.assertEquals(#array("a", "b", "c"):padstart(4, nil), 4)
		luaunit.assertEquals(array("a", "b", "c"):padstart(4, nil):len(), 4)
		luaunit.assertEquals(#array("a", "b", "c"):padstart(6, nil), 6)
		luaunit.assertEquals(array("a", "b", "c"):padstart(6, nil):len(), 6)
	end;

	-- padend()
	["test: Should be 0 when padding an empty array at the end"] = function ()
		luaunit.assertEquals(#array():padend(0, "a"), 0)
		luaunit.assertEquals(array():padend(0, "a"):len(), 0)
	end;

	["test: Should be equal to the first argument when padding an empty array at the end"] = function ()
		luaunit.assertEquals(#array():padend(3, "a"), 3)
		luaunit.assertEquals(array():padend(3, "a"):len(), 3)
	end;

	["test: Should be equal to the original array's length when padding an array to 0 at the end"] = function ()
		luaunit.assertEquals(#array("a"):padend(0, "a"), 1)
		luaunit.assertEquals(array("a"):padend(0, "a"):len(), 1)
	end;

	["test: Should be equal to the original array's length when padding an array to its length at the end"] = function ()
		luaunit.assertEquals(#array("a"):padend(1, "a"), 1)
		luaunit.assertEquals(array("a"):padend(1, "a"):len(), 1)
		luaunit.assertEquals(#array("a", "b", "c"):padend(3, "a"), 3)
		luaunit.assertEquals(array("a", "b", "c"):padend(3, "a"):len(), 3)
	end;

	["test: Should be equal to the original array's length when padding an array to negative length at the end"] = function ()
		luaunit.assertEquals(#array("a", "b", "c"):padend(-3, "d"), 3)
		luaunit.assertEquals(array("a", "b", "c"):padend(-3, "d"):len(), 3)
	end;

	["test: Should be equal to the original array's length when padding an array to a length lesser than the array's one at the end"] = function ()
		luaunit.assertEquals(#array("a", "b", "c"):padend(2, "d"), 3)
		luaunit.assertEquals(array("a", "b", "c"):padend(2, "d"):len(), 3)
	end;

	["test: Should be correct when padding an array at the end"] = function ()
		luaunit.assertEquals(#array("a"):padend(3, "b"), 3)
		luaunit.assertEquals(array("a"):padend(3, "b"):len(), 3)
		luaunit.assertEquals(#array("a", "b", "c"):padend(5, "d"), 5)
		luaunit.assertEquals(array("a", "b", "c"):padend(5, "d"):len(), 5)
	end;

	["test: Should be greater than the original one's when padding an array to a length greater than array's one by 1 at the end"] = function ()
		luaunit.assertEquals(#array("a"):padend(2, "b"), 2)
		luaunit.assertEquals(array("a"):padend(2, "b"):len(), 2)
		luaunit.assertEquals(#array("a", "b", "c"):padend(4, "d"), 4)
		luaunit.assertEquals(array("a", "b", "c"):padend(4, "d"):len(), 4)
	end;

	["test: Should be correct when padding an array and there are nils at the end"] = function ()
		luaunit.assertEquals(#array("a", "b", nil):padend(4, "d"), 4)
		luaunit.assertEquals(array("a", "b", nil):padend(4, "d"):len(), 4)
		luaunit.assertEquals(#array("a", "b", nil):padend(6, "d"), 6)
		luaunit.assertEquals(array("a", "b", nil):padend(6, "d"):len(), 6)
	end;

	["test: Should be correct when padding an array with nils at the end"] = function ()
		luaunit.assertEquals(#array("a", "b", "c"):padend(4, nil), 4)
		luaunit.assertEquals(array("a", "b", "c"):padend(4, nil):len(), 4)
		luaunit.assertEquals(#array("a", "b", "c"):padend(6, nil), 6)
		luaunit.assertEquals(array("a", "b", "c"):padend(6, nil):len(), 6)
	end;

	-- addstart()
	["test: Should be 1 after adding an element to the start of an empty array"] = function ()
		local a = array()
		a:addstart("a")
		luaunit.assertEquals(#a, 1)
		luaunit.assertEquals(a:len(), 1)
	end;

	["test: Should be increased by 1 after adding an element to the start"] = function ()
		local a = array("a", "b", "c")
		a:addstart("d")
		luaunit.assertEquals(#a, 4)
		luaunit.assertEquals(a:len(), 4)
	end;

	["test: Should be 1 after adding nil to the start of empty array"] = function ()
		local a = array()
		a:addstart(nil)
		luaunit.assertEquals(#a, 1)
		luaunit.assertEquals(a:len(), 1)
	end;

	["test: Should be increased by 1 after adding nil to the start"] = function ()
		local a = array("a", "b", "c")
		a:addstart(nil)
		luaunit.assertEquals(#a, 4)
		luaunit.assertEquals(a:len(), 4)
	end;

	-- addend()
	["test: Should be 1 after adding an element to the end of an empty array"] = function ()
		local a = array()
		a:addend("a")
		luaunit.assertEquals(#a, 1)
		luaunit.assertEquals(a:len(), 1)
	end;

	["test: Should be increased by 1 after adding an element to the end"] = function ()
		local a = array("a", "b", "c")
		a:addend("d")
		luaunit.assertEquals(#a, 4)
		luaunit.assertEquals(a:len(), 4)
	end;

	["test: Should be 1 after adding nil to the end of empty array"] = function ()
		local a = array()
		a:addend(nil)
		luaunit.assertEquals(#a, 1)
		luaunit.assertEquals(a:len(), 1)
	end;

	["test: Should be increased by 1 after adding nil to the end"] = function ()
		local a = array("a", "b", "c")
		a:addend(nil)
		luaunit.assertEquals(#a, 4)
		luaunit.assertEquals(a:len(), 4)
	end;

	-- del()
	["test: Should be 0 when deleting an element from an empty array"] = function ()
		local a = array()
		a:del(1)
		a:del(-1)
		a:del(2)
		luaunit.assertEquals(#a, 0)
		luaunit.assertEquals(a:len(), 0)
	end;
	
	["test: Should be 0 after deleting the only element"] = function ()
		local a = array("a")
		a:del(1)
		luaunit.assertEquals(#a, 0)
		luaunit.assertEquals(a:len(), 0)
	end;
	
	["test: Should be 0 after deleting the only element with -1"] = function ()
		local a = array("a")
		a:del(-1)
		luaunit.assertEquals(#a, 0)
		luaunit.assertEquals(a:len(), 0)
	end;
	
	["test: Should not change after deleting an element with out of bounds index"] = function (self)
		self.a3:del(10)
		luaunit.assertEquals(#self.a3, 6)
		luaunit.assertEquals(self.a3:len(), 6)
	end;
	
	["test: Should not change after deleting an element with 0"] = function (self)
		self.a3:del(0)
		luaunit.assertEquals(#self.a3, 6)
		luaunit.assertEquals(self.a3:len(), 6)
	end;
	
	["test: Should decrease by 1 after deleting an element with 1"] = function (self)
		self.a3:del(1)
		luaunit.assertEquals(#self.a3, 5)
		luaunit.assertEquals(self.a3:len(), 5)
	end;
	
	["test: Should decrease by 1 after deleting an element with min negative index"] = function (self)
		self.a3:del(-6)
		luaunit.assertEquals(#self.a3, 5)
		luaunit.assertEquals(self.a3:len(), 5)
	end;
	
	["test: Should decrease by 1 after deleting nil with 1"] = function ()
		local a = array(nil, "b", "c")
		a:del(1)
		luaunit.assertEquals(#a, 2)
		luaunit.assertEquals(a:len(), 2)
	end;
	
	["test: Should decrease by 1 after deleting nil with min negative index"] = function ()
		local a = array(nil, "b", "c")
		a:del(-3)
		luaunit.assertEquals(#a, 2)
		luaunit.assertEquals(a:len(), 2)
	end;
	
	["test: Should decrease by 1 after deleting an element with #self"] = function (self)
		self.a3:del(6)
		luaunit.assertEquals(#self.a3, 5)
		luaunit.assertEquals(self.a3:len(), 5)
	end;
	
	["test: Should decrease by 1 after deleting an element with -1"] = function (self)
		self.a3:del(-1)
		luaunit.assertEquals(#self.a3, 5)
		luaunit.assertEquals(self.a3:len(), 5)
	end;
	
	["test: Should decrease by 1 after deleting nil with #self"] = function ()
		local a = array("a", "b", nil)
		a:del(3)
		luaunit.assertEquals(#a, 2)
		luaunit.assertEquals(a:len(), 2)
	end;
	
	["test: Should decrease by 1 after deleting nil with -1"] = function ()
		local a = array("a", "b", nil)
		a:del(-1)
		luaunit.assertEquals(#a, 2)
		luaunit.assertEquals(a:len(), 2)
	end;
	
	["test: Should decrease by 1 after deleting an element"] = function (self)
		self.a3:del(3)
		luaunit.assertEquals(#self.a3, 5)
		luaunit.assertEquals(self.a3:len(), 5)
	end;
	
	["test: Should decrease by 1 after deleting an element with negative index"] = function (self)
		self.a3:del(-3)
		luaunit.assertEquals(#self.a3, 5)
		luaunit.assertEquals(self.a3:len(), 5)
	end;
	
	["test: Should decrease by after deleting nil"] = function ()
		local a = array("a", nil, "c")
		a:del(2)
		luaunit.assertEquals(#a, 2)
		luaunit.assertEquals(a:len(), 2)
	end;
	
	["test: Should decrease by after deleting nil with negative index"] = function ()
		local a = array("a", nil, "c")
		a:del(-2)
		luaunit.assertEquals(#a, 2)
		luaunit.assertEquals(a:len(), 2)
	end;

	-- delstart()
	["test: Should be 0 after deleting the first element from an empty array"] = function ()
		local a = array()
		a:delstart()
		luaunit.assertEquals(#a, 0)
		luaunit.assertEquals(a:len(), 0)
	end;

	["test: Should be 0 after deleting the only first element"] = function ()
		local a = array("a")
		a:delstart()
		luaunit.assertEquals(#a, 0)
		luaunit.assertEquals(a:len(), 0)
	end;

	["test: Should decrease by 1 after deleting the first element"] = function ()
		local a = array("a", "b", "c")
		a:delstart()
		luaunit.assertEquals(#a, 2)
		luaunit.assertEquals(a:len(), 2)
	end;

	["test: Should decrease by 1 after deleting the first nil"] = function ()
		local a = array(nil, "b", "c")
		a:delstart()
		luaunit.assertEquals(#a, 2)
		luaunit.assertEquals(a:len(), 2)
	end;

	-- delend()
	["test: Should be 0 after deleting the last element from an empty array"] = function ()
		local a = array()
		a:delend()
		luaunit.assertEquals(#a, 0)
		luaunit.assertEquals(a:len(), 0)
	end;

	["test: Should be 0 after deleting the only last element"] = function ()
		local a = array("a")
		a:delend()
		luaunit.assertEquals(#a, 0)
		luaunit.assertEquals(a:len(), 0)
	end;

	["test: Should decrease by 1 after deleting the last element"] = function ()
		local a = array("a", "b", "c")
		a:delend()
		luaunit.assertEquals(#a, 2)
		luaunit.assertEquals(a:len(), 2)
	end;

	["test: Should decrease by 1 after deleting the last nil"] = function ()
		local a = array("a", "b", nil)
		a:delend()
		luaunit.assertEquals(#a, 2)
		luaunit.assertEquals(a:len(), 2)
	end;

	-- __mul(), __intersect()
	["test: Should be 0 after intersecting an empty array with empty one"] = function ()
		luaunit.assertEquals(#(array() * array()), 0)
		luaunit.assertEquals(array():intersect(array()):len(), 0)
	end;

	["test: Should be 0 after intersecting any array with empty one"] = function ()
		luaunit.assertEquals(#(array() * array("a")), 0)
		luaunit.assertEquals(array("a"):intersect(array()):len(), 0)
	end;

	["test: Should be equal to one of original arrays after intersecting when one of them is a subset of another"] = function ()
		luaunit.assertEquals(#(array("a", "b", "c") * array("a", "b", "c", "d", "e", "f")), 3)
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):intersect(array("a", "b", "c")):len(), 3)
	end;

	["test: Should be correct after intersecting"] = function ()
		luaunit.assertEquals(#(array("a", "b", "c", "d") * array("f", "e", "d", "c")), 2)
		luaunit.assertEquals(array("f", "e", "d", "c"):intersect(array("a", "b", "c", "d")):len(), 2)
	end;

	["test: Should be correct after intersecting when both arrays contain nil"] = function ()
		luaunit.assertEquals(#(array(nil, "b", "c") * array("c", nil, "d")), 2)
		luaunit.assertEquals(array("c", nil, "d"):intersect(array(nil, "b", "c")):len(), 2)
	end;

	["test: Should be correct after intersecting when both arrays contain nil and one of them has only one element"] = function ()
		luaunit.assertEquals(#(array(nil, "b", "c") * array(nil)), 1)
		luaunit.assertEquals(array(nil):intersect(array(nil, "b", "c")):len(), 1)
	end;

	["test: Should be 0 after intersecting when both arrays don't have overlapping elements"] = function ()
		luaunit.assertEquals(#(array("a", "b", "c") * array("d", "e", "f")), 0)
		luaunit.assertEquals(array("d", "e", "f"):intersect(array("a", "b", "c")):len(), 0)
	end;

	["test: Should be equal to the initial one's length after intersecting with itself"] = function ()
		local a = array("a", "b", "c")
		luaunit.assertEquals(#(a * a), 3)
		luaunit.assertEquals(a:intersect(a):len(), 3)
	end;

	["test: Should be correct after intersecting when the array to intersect with has duplicates"] = function ()
		luaunit.assertEquals(#(array("a") * array("a", "a", "b")), 1)
	end;

	["test: Should be correct after intersecting when the array has duplicates"] = function ()
		luaunit.assertEquals(array("a", "b", "b"):intersect(array("b")):len(), 2)
	end;

	-- __add(), unite()
	["test: Should be 0 after uniting empty arrays"] = function ()
		luaunit.assertEquals(#(array() + array()), 0)
		luaunit.assertEquals(array():unite(array()):len(), 0)
	end;

	["test: Should be equal to the longest array's length after uniting with empty array"] = function ()
		luaunit.assertEquals(#(array() + array("a")), 1)
		luaunit.assertEquals(array("a"):unite(array()):len(), 1)
	end;

	["test: Should be equal to the longest array's length after uniting when one of the arrays is a subset of another one"] = function ()
		luaunit.assertEquals(#(array("a", "b", "c") + array("a", "b", "c", "d", "e", "f")), 6)
		luaunit.assertEquals(array("a", "b", "c", "d", "e", "f"):unite(array("a", "b", "c")):len(), 6)
	end;

	["test: Should be correct after uniting"] = function ()
		luaunit.assertEquals(#(array("a", "b", "c", "d") + array("f", "e", "d", "c")), 6)
		luaunit.assertEquals(array("f", "e", "d", "c"):unite(array("a", "b", "c", "d")):len(), 6)
	end;

	["test: Should be correct after uniting when both arrays contain nil"] = function ()
		luaunit.assertEquals(#(array(nil, "b", "c") + array("c", nil, "d")), 4)
		luaunit.assertEquals(array("c", nil, "d"):unite(array(nil, "b", "c")):len(), 4)
	end;

	["test: Should be equal to the longest array's length after uniting when both arrays contain nil and one of them has only one element"] = function ()
		luaunit.assertEquals(#(array(nil, "b", "c") + array(nil)), 3)
		luaunit.assertEquals(array(nil):unite(array(nil, "b", "c")):len(), 3)
	end;

	["test: Should be a sum of both arrays' lengths after uniting when both arrays don't have overlapping elements"] = function ()
		luaunit.assertEquals(#(array("a", "b", "c") + array("d", "e", "f")), 6)
		luaunit.assertEquals(array("d", "e", "f"):unite(array("a", "b", "c")):len(), 6)
	end;

	["test: Should be equal to own length after uniting with itself"] = function ()
		local a = array("a", "b", "c")
		luaunit.assertEquals(#(a + a), 3)
		luaunit.assertEquals(a:unite(a):len(), 3)
	end;

	["test: Should be correct after uniting with an array with duplicates"] = function ()
		luaunit.assertEquals(#(array("a") + array("a", "b", "b")), 2)
	end;

	["test: Should be correct after uniting when the array has duplicates"] = function ()
		luaunit.assertEquals(array("a", "b", "b"):unite(array("a", "b")):len(), 3)
	end;

	-- __sub(), subtract()
	["test: Should be 0 after subtracting empty arrays"] = function ()
		luaunit.assertEquals(#(array() - array()), 0)
		luaunit.assertEquals(array():subtract(array()):len(), 0)
	end;

	["test: Should be 0 after subtracting from empty array"] = function ()
		luaunit.assertEquals(#(array() - array("a")), 0)
	end;

	["test: Should be equal to the original array after subtracting an empty one"] = function ()
		luaunit.assertEquals(#array("a"):subtract(array()), 1)
	end;

	["test: Should be 0 after subtracting superset of the array"] = function ()
		luaunit.assertEquals(#(array("a", "b", "c") - array("a", "b", "c", "d", "e", "f")), 0)
	end;

	["test: Should be correct after subtracting"] = function ()
		luaunit.assertEquals(#(array("a", "b", "c", "d") - array("f", "e", "d", "c")), 2)
		luaunit.assertEquals(array("f", "e", "d", "c"):subtract(array("a", "b", "c", "d")):len(), 2)
	end;

	["test: Should be correct after subtracting an array with nil"] = function ()
		luaunit.assertEquals(#(array(nil, "b", "c") - array("c", nil, "d")), 1)
		luaunit.assertEquals(array("c", nil, "d"):subtract(array(nil, "b", "c")):len(), 1)
	end;

	["test: Should be correct after subtracting an array with single nil element when the array contains nil"] = function ()
		luaunit.assertEquals(#(array(nil, "b", "c") - array(nil)), 2)
		luaunit.assertEquals(array(nil):subtract(array(nil, "b", "c")):len(), 0)
	end;

	["test: Should be equal to the original array's length after subtracting when both arrays don't have overlapping elements"] = function ()
		luaunit.assertEquals(#(array("a", "b", "c") - array("d", "e", "f")), 3)
		luaunit.assertEquals(array("d", "e", "f"):subtract(array("a", "b", "c")):len(), 3)
	end;

	["test: Should be 0 after subtracting with itself"] = function ()
		local a = array("a", "b", "c")
		luaunit.assertEquals(#(a - a), 0)
		luaunit.assertEquals(a:subtract(a):len(), 0)
	end;

	["test: Should be correct after subtracting when the array to subtract with has duplicates"] = function ()
		luaunit.assertEquals(#(array("a", "b") - array("a", "a")), 1)
	end;

	["test: Should be correct after subtracting when the array has duplicates"] = function ()
		luaunit.assertEquals(array("a", "b", "b"):subtract(array("a", "b")):len(), 0)
	end;

	-- chunk()
	["test: Should be after chunking an empty array"] = function ()
		luaunit.assertEquals(#array():chunk(1), 0)
		luaunit.assertEquals(array():chunk(1):len(), 0)
	end;

	["test: Should be 1 after chunking when the array has only one element"] = function ()
		luaunit.assertEquals(#array("a"):chunk(1), 1)
		luaunit.assertEquals(array("a"):chunk(1):len(), 1)
	end;

	["test: Should be 1 after chunking when the argument is greater than the array's length"] = function (self)
		luaunit.assertEquals(#self.a3:chunk(10), 1)
		luaunit.assertEquals(self.a3:chunk(10):len(), 1)
	end;

	["test: Should be correct after chunking when the array can be chunked in equal pieces"] = function (self)
		luaunit.assertEquals(#self.a3:chunk(2), 3)
		luaunit.assertEquals(self.a3:chunk(2):len(), 3)
	end;

	["test: Should be correct after chunking when the array cannot be chunked in equal pieces"] = function (self)
		luaunit.assertEquals(#self.a3:chunk(4), 2)
		luaunit.assertEquals(self.a3:chunk(4):len(), 2)
	end;

	-- flat()
	["test: Should be 0 after flattening an empty array"] = function ()
		luaunit.assertEquals(#array():flat(), 0)
		luaunit.assertEquals(#array():flat(0), 0)
		luaunit.assertEquals(#array():flat(1), 0)
		luaunit.assertEquals(#array():flat(10), 0)
	end;

	["test: Should be correct after flattening"] = function ()
		local a = array("a", "b", array("c", "d", array("e", "f")))
		luaunit.assertEquals(#a:flat(), 5)
		luaunit.assertEquals(#a:flat(1), 5)
		luaunit.assertEquals(#a:flat(2), 6)
	end;

	["test: Should be the same for both flattening with omitted and 1"] = function ()
		local a = array("a", "b", array("c", "d", array("e", "f")))
		luaunit.assertEquals(#a:flat(), #a:flat(1))
	end;

	["test: Should be equal to the original one after flattening  when the depth is 0"] = function ()
		luaunit.assertEquals(#array("a", "b", array("c", "d", array("e", "f"))):flat(0), 3)
	end;

	["test: Should be a sum of nested arrays after flattening when the depth is a large number"] = function (self)
		luaunit.assertEquals(#array("a", "b", array("c", "d", array("e", "f"))):flat(10), 6)
	end;

	-- addbefore()
	["test: Should not change after adding an element before index when the array is empty"] = function ()
		local a = array()
		a:addbefore(1, "a")
		luaunit.assertEquals(#a, 0)
		luaunit.assertEquals(a:len(), 0)
	end;

	["test: Should not change after adding an element before index when the index is not 1 nor -1 and the array contains only one element"] = function (self)
		self.a0:addbefore(2, "z")
		self.a0:addbefore(-2, "z")
		luaunit.assertEquals(#self.a0, 1)
		luaunit.assertEquals(self.a0:len(), 1)
	end;

	["test: Should be increased by 1 after adding an element before index when the array contains only one element and the index is 1"] = function (self)
		self.a0:addbefore(1, "z")
		luaunit.assertEquals(#self.a0, 2)
		luaunit.assertEquals(self.a0:len(), 2)
	end;

	["test: Should be increased by 1 after adding an element before index when the array contains only one element and the index is -1"] = function (self)
		self.a0:addbefore(-1, "z")
		luaunit.assertEquals(#self.a0, 2)
		luaunit.assertEquals(self.a0:len(), 2)
	end;

	["test: Should not change after adding an element before index when the index is 0 and the array has only one element"] = function (self)
		self.a0:addbefore(0, "z")
		luaunit.assertEquals(#self.a0, 1)
		luaunit.assertEquals(self.a0:len(), 1)
	end;

	["test: Should not change after adding an element before index when the index is 0"] = function (self)
		self.a1:addbefore(0, "z")
		luaunit.assertEquals(#self.a1, 3)
		luaunit.assertEquals(self.a1:len(), 3)
	end;

	["test: Should not change after adding an element before index when the index is > #self"] = function (self)
		self.a1:addbefore(10, "z")
		luaunit.assertEquals(#self.a1, 3)
		luaunit.assertEquals(self.a1:len(), 3)
	end;

	["test: Should not change after adding an element before index when the index is < -#self"] = function (self)
		self.a1:addbefore(-10, "z")
		luaunit.assertEquals(#self.a1, 3)
		luaunit.assertEquals(self.a1:len(), 3)
	end;

	["test: Should not change after adding an element before index when the index is #self + 1"] = function (self)
		self.a1:addbefore(4, "z")
		luaunit.assertEquals(#self.a1, 3)
		luaunit.assertEquals(self.a1:len(), 3)
	end;

	["test: Should not change after adding an element before index when the index is -#self - 1"] = function (self)
		self.a1:addbefore(-4, "z")
		luaunit.assertEquals(#self.a1, 3)
		luaunit.assertEquals(self.a1:len(), 3)
	end;

	["test: Should be increased by 1 after adding an element when the index is 1"] = function (self)
		self.a1:addbefore(1, "z")
		luaunit.assertEquals(#self.a1, 4)
		luaunit.assertEquals(self.a1:len(), 4)
	end;

	["test: Should be increased by 1 after adding an element before index when the index is the middle one"] = function (self)
		self.a1:addbefore(2, "z")
		luaunit.assertEquals(#self.a1, 4)
		luaunit.assertEquals(self.a1:len(), 4)
	end;

	["test: Should be increased by 1 after adding an element before index when the index is length of the array"] = function (self)
		self.a1:addbefore(3, "z")
		luaunit.assertEquals(#self.a1, 4)
		luaunit.assertEquals(self.a1:len(), 4)
	end;

	["test: Should be increased by 1 after adding an element before index when the index is -#self"] = function (self)
		self.a1:addbefore(-3, "z")
		luaunit.assertEquals(#self.a1, 4)
		luaunit.assertEquals(self.a1:len(), 4)
	end;

	["test: Should be increased by 1 after adding an element before index when the index is the middle one and it's < 0"] = function (self)
		self.a1:addbefore(-2, "z")
		luaunit.assertEquals(#self.a1, 4)
		luaunit.assertEquals(self.a1:len(), 4)
	end;

	["test: Should be increased by 1 after adding an element before index  when the index is -1"] = function (self)
		self.a1:addbefore(-1, "z")
		luaunit.assertEquals(#self.a1, 4)
		luaunit.assertEquals(self.a1:len(), 4)
	end;

	-- addafter()
	["test: Should not change after adding an element after index when the array is empty"] = function ()
		local a = array()
		a:addafter(1, "a")
		luaunit.assertEquals(#a, 0)
		luaunit.assertEquals(a:len(), 0)
	end;

	["test: Should not change after adding an element after index when the index is not 1 nor -1 and the array contains only one element"] = function (self)
		self.a0:addafter(2, "z")
		self.a0:addafter(-2, "z")
		luaunit.assertEquals(#self.a0, 1)
		luaunit.assertEquals(self.a0:len(), 1)
	end;

	["test: Should be increased by 1 after adding an element after index when the array contains only one element and the index is 1"] = function (self)
		self.a0:addafter(1, "z")
		luaunit.assertEquals(#self.a0, 2)
		luaunit.assertEquals(self.a0:len(), 2)
	end;

	["test: Should be increased by 1 after adding an element after index when the array contains only one element and the index is -1"] = function (self)
		self.a0:addafter(-1, "z")
		luaunit.assertEquals(#self.a0, 2)
		luaunit.assertEquals(self.a0:len(), 2)
	end;

	["test: Should not change after adding an element after index when the index is 0 and the array has only one element"] = function (self)
		self.a0:addafter(0, "z")
		luaunit.assertEquals(#self.a0, 1)
		luaunit.assertEquals(self.a0:len(), 1)
	end;

	["test: Should not change after adding an element after index when the index is 0"] = function (self)
		self.a1:addafter(0, "z")
		luaunit.assertEquals(#self.a1, 3)
		luaunit.assertEquals(self.a1:len(), 3)
	end;

	["test: Should not change after adding an element after index when the index is > #self"] = function (self)
		self.a1:addafter(10, "z")
		luaunit.assertEquals(#self.a1, 3)
		luaunit.assertEquals(self.a1:len(), 3)
	end;

	["test: Should not change after adding an element after index when the index is < -#self"] = function (self)
		self.a1:addafter(-10, "z")
		luaunit.assertEquals(#self.a1, 3)
		luaunit.assertEquals(self.a1:len(), 3)
	end;

	["test: Should not change after adding an element after index when the index is #self + 1"] = function (self)
		self.a1:addafter(4, "z")
		luaunit.assertEquals(#self.a1, 3)
		luaunit.assertEquals(self.a1:len(), 3)
	end;

	["test: Should not change after adding an element after index when the index is -#self - 1"] = function (self)
		self.a1:addafter(-4, "z")
		luaunit.assertEquals(#self.a1, 3)
		luaunit.assertEquals(self.a1:len(), 3)
	end;

	["test: Should be increased by 1 after adding an element after index when the index is 1"] = function (self)
		self.a1:addafter(1, "z")
		luaunit.assertEquals(#self.a1, 4)
		luaunit.assertEquals(self.a1:len(), 4)
	end;

	["test: Should be increased by 1 after adding an element after index when the index is the middle one"] = function (self)
		self.a1:addafter(2, "z")
		luaunit.assertEquals(#self.a1, 4)
		luaunit.assertEquals(self.a1:len(), 4)
	end;

	["test: Should be increased by 1 after adding an element after index when the index is length of the array"] = function (self)
		self.a1:addafter(3, "z")
		luaunit.assertEquals(#self.a1, 4)
		luaunit.assertEquals(self.a1:len(), 4)
	end;

	["test: Should be increased by 1 after adding an element after index when the index is -#self"] = function (self)
		self.a1:addafter(-3, "z")
		luaunit.assertEquals(#self.a1, 4)
		luaunit.assertEquals(self.a1:len(), 4)
	end;

	["test: Should be increased by 1 after adding an element after index when the index is the middle one and it's < 0"] = function (self)
		self.a1:addafter(-2, "z")
		luaunit.assertEquals(#self.a1, 4)
		luaunit.assertEquals(self.a1:len(), 4)
	end;

	["test: Should be increased by 1 after adding an element after index when the index is -1"] = function (self)
		self.a1:addafter(-1, "z")
		luaunit.assertEquals(#self.a1, 4)
		luaunit.assertEquals(self.a1:len(), 4)
	end;
}
