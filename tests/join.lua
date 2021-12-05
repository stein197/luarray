TestJoin = {
	["test: Joining empty array returns empty string"] = function ()
		luaunit.assertEquals(array():join(" "), "")
	end;

	["test: Joining array with single elements returns that elements in string format"] = function ()
		luaunit.assertEquals(array(1):join(" "), "1")
	end;

	["test: Joining array with multiple values"] = function ()
		luaunit.assertEquals(array(1, "string", false):join(", "), "1, string, false")
	end;

	["test: Joining single element with empty string"] = function ()
		luaunit.assertEquals(array("a"):join(""), "a")
	end;

	["test: Joining multiple elements with empty string"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):join(""), "abc")
	end;
}
