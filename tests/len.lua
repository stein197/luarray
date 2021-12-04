TestLen = {
	["test: len(): Length of empty table is 0"] = function ()
		luaunit.assertEquals(array():len(), 0)
	end;

	["test: len()"] = function ()
		luaunit.assertEquals(array(1, 2, 3):len(), 3)
	end;
}