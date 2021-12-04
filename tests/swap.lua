TestSwap = {
	["test: swap(): Swapping empty array returns empty one"] = function ()
		luaunit.assertEquals(array():swap(), {})
	end;

	["test: swap(): Swapping does not modifies an initial array"] = function ()
		local a = array {a = 1, b = 2, c = 3}
		a:swap()
		luaunit.assertEquals(a, {a = 1, b = 2, c = 3})
	end;

	["test: swap(): Swapping returns new array"] = function ()
		local a = array {a = 1, b = 2, c = 3}
		luaunit.assertNotEquals(a:swap(), a)
	end;

	["test: swap(): Returned type is an array"] = function ()
		luaunit.assertEquals(getmetatable(array():swap()), getmetatable(array()))
	end;

	["test: swap()"] = function ()
		luaunit.assertEquals(array {a = 1, b = 2, c = 3}: swap(), {[1] = "a", [2] = "b", [3] = "c"})
	end;
}
