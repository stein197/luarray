TestJoin = {
	["test: Should return an empty string when joining an empty array"] = function ()
		luaunit.assertEquals(array():join(" "), "")
	end;

	["test: Should return the first element in string when joining an array with single element"] = function ()
		luaunit.assertEquals(array(1):join(" "), "1")
	end;

	["test: Should return correct string when joining array with single character"] = function ()
		luaunit.assertEquals(array(1, "string", false):join(" "), "1 string false")
	end;

	["test: Should return correct string when joining array with multicharacter string"] = function ()
		luaunit.assertEquals(array(1, "string", false):join(", "), "1, string, false")
	end;

	["test: Should return correct string when joining single element with empty string"] = function ()
		luaunit.assertEquals(array("a"):join(""), "a")
	end;

	["test: Should return correct string when joining multiple elements with empty string"] = function ()
		luaunit.assertEquals(array("a", "b", "c"):join(""), "abc")
	end;

	["test: Should omit nils when an array has nils"] = function ()
		luaunit.assertEquals(array("a", nil, "c"):join(""), "ac")
	end;

	["test: Should return empty string when an array contains only nils"] = function ()
		luaunit.assertEquals(array(nil, nil, nil):join(""), "")
	end;
}
