TestOnly = {
	setUp = function (self)
		self.max = function (a, b) return a < b and b or a end
	end;
	
	["test: Should return nil when the array is empty"] = function (self)
		luaunit.assertNil(array():only(self.max))
	end;

	["test: Should return the only element when the array has only one element"] = function (self)
		luaunit.assertEquals(array(1):only(self.max), 1)
	end;

	["test: Should return correct result"] = function (self)
		luaunit.assertEquals(array(1, 10, 100):only(self.max), 100)
	end;
}
