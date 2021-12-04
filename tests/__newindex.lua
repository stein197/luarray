Test__newindex = {
	["test: __newindex(): Setting at numberic index"] = function ()
		local a = array()
		a[1] = "a"
		luaunit.assertEquals(a[1], "a")
	end;

	["test: __newindex(): Setting at string index"] = function ()
		local a = array()
		a.a = 1
		luaunit.assertEquals(a.a, 1)
	end;

	["test: __newindex(): Setting at complex type index"] = function ()
		local a = array()
		local i = {1}
		a[i] = 1
		luaunit.assertEquals(a[i], 1)
	end;

	["test: __newindex(): Setting at meta index will write the value to __data field"] = function ()
		local a = array()
		a.__index = 1
		luaunit.assertEquals(a.__data, {__index = 1})
	end;

	["test: __newindex(): Setting at proto index will write the value to __data field"] = function ()
		local a = array()
		a.len = 1
		luaunit.assertEquals(a.__data, {len = 1})
	end;

	["test: __newindex(): Setting table value will wrap it"] = function ()
		local a = array()
		a.t = {}
		luaunit.assertEquals(a.__data, {t = {}})
		luaunit.assertEquals(getmetatable(a.t), getmetatable(a))
		a = array()
		a.t = {1}
		luaunit.assertEquals(a.__data, {t = {1}})
		luaunit.assertEquals(getmetatable(a.t), getmetatable(a))
	end;

	["test: __newindex(): Setting array value will assign it"] = function ()
		local a = array()
		a.t = array()
		luaunit.assertEquals(a.t.__data, {})
		a = array()
		a.t = {1}
		luaunit.assertEquals(a.t.__data, {1})
	end;

	["test: __newindex(): Can access values through direct __data access"] = function ()
		luaunit.assertEquals(array({a = 1}).__data.a, 1)
	end;
}