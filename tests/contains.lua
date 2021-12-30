TestContains = {
	setUp = function (self)
		self.a = array("a", "b", "c")
	end;
	
	["test: Should return false when the array is empty"] = function ()
		luaunit.assertFalse(array():contains("a"))
	end;

	["test: Should return true when the array contains value"] = function (self)
		luaunit.assertTrue(self.a:contains("c"))
	end;

	["test: Should return false when the array does not contain value"] = function (self)
		luaunit.assertFalse(self.a:contains("f"))
	end;

	["test: Should return true for nested array when the array contains an array"] = function ()
		luaunit.assertTrue(array("a", "b", "c", array("d", "e", "f")):contains(array("d", "e", "f")))
	end;

	["test: Should return true for nil when the array contains nil"] = function ()
		luaunit.assertTrue(array("a", nil, "c"):contains(nil))
	end;

	["test: Should return true for nil when the array is full of nils"] = function ()
		luaunit.assertTrue(array(nil):contains(nil))
	end;

	["test: Should return false for nil when the array does not contain nil"] = function (self)
		luaunit.assertFalse(self.a:contains(nil))
	end;

	["test: Should return true for nil when nil is at the end of the array"] = function ()
		luaunit.assertTrue(array("a", "b", nil):contains(nil))
	end;

	["test: Should return true for nil when nil is at the start of the array"] = function ()
		luaunit.assertTrue(array(nil, "b", "c"):contains(nil))
	end;

	["test: Should return false fpr nil when the array is empty"] = function ()
		luaunit.assertFalse(array():contains(nil))
	end;
}