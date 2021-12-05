TestUniq = {
	["test: Filtering an empty array returns empty one"] = function ()
		luaunit.assertEquals(array():uniq(), {})
	end;

	["test: Filtering an array with no duplicates returns identical array"] = function ()
		luaunit.assertEquals(array({a = 1, b = 2, c = 3}):uniq(), {a = 1, b = 2, c = 3})
	end;

	["test: Filtering an array with numeric keys won't preserve keys"] = function ()
		luaunit.assertEquals(array(1, 2, 3, 4, 3, 5, 4, 6):uniq(), {[1] = 1, [2] = 2, [3] = 3, [4] = 4, [5] = 5, [6] = 6})
	end;
}