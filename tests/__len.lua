-- TODO: Add test case for each tested method that modifies an array
Test__len = {
	["test: Should return 0 when empty table"] = function ()
		luaunit.assertEquals(#array(), 0)
	end;
}