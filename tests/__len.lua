Test__len = {
	["test: __len(): Length of empty table is 0"] = function ()
		luaunit.assertEquals(#array(), 0)
	end;

	["test: __len()"] = function ()
		luaunit.assertEquals(#array(1, 2, 3), 3)
	end;
}