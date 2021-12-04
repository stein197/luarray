TestJoin = {
	["test: join(): Joining empty array returns empty string"] = function ()
		luaunit.assertEquals(array():join(" "), "")
	end;

	["test: join(): Joining array with single elements returns that elements in string format"] = function ()
		luaunit.assertEquals(array(1):join(" "), "1")
	end;

	["test: join(): Joining array with multiple values"] = function ()
		luaunit.assertEquals(array(1, "string", false):join(", "), "1, string, false")
	end;
}
