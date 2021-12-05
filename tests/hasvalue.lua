TestHasValue = {
	["test: Empty array has no values"] = function ()
		luaunit.assertFalse(array():hasvalue(1))
	end;
	
	["test: Finding primitive type"] = function ()
		luaunit.assertTrue(array(1, 2, 3):hasvalue(3))
	end;
	
	["test: Finding table type"] = function ()
		luaunit.assertTrue(array(1, 2, array {c = 3}):hasvalue({c = 3}))
	end;
	
	["test: Finding array type"] = function ()
		luaunit.assertTrue(array(1, 2, array {c = 3}):hasvalue(array {c = 3}))
	end;
	
	["test: Finding reference type"] = function ()
		local o = Class()
		luaunit.assertTrue(array(1, 2, o):hasvalue(o))
	end;

	["test: Finding same object but with different reference ewturns false"] = function ()
		luaunit.assertFalse(array(1, 2, Class()):hasvalue(Class()))
	end;
	
	["test: Finding nonexistent value"] = function ()
		luaunit.assertFalse(array(1, 2, 3):hasvalue(32))
	end;
}