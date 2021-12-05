TestHasKey = {
	["test: An array does not have nonexistent key"] = function ()
		luaunit.assertFalse(array():haskey("a"))
	end;

	["test: haskey()"] = function ()
		luaunit.assertTrue(array({a = 1}):haskey("a"))
	end;
}