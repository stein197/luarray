Test__index = {
	["test: __index(): Accessing by number"] = function ()
		luaunit.assertEquals(array("a")[1], "a")
	end;

	["test: __index(): Accessing by string"] = function ()
		luaunit.assertEquals(array({a = 1}).a, 1)
	end;

	["test: __index(): Accessing by complex type"] = function ()
		local k = {1}
		luaunit.assertEquals(array({[k] = "a"})[k], "a")
	end;

	["test: __index(): Access methods will return one"] = function ()
		luaunit.assertEquals(type(array({1, 2, 3}).len), "function")
	end;
}
