Test__pairs = {
	["test: __pairs(): Iterating through an array"] = function ()
		local rs = {}
		for k, v in pairs(array("a", "b", "c")) do
			rs[k] = v
		end;
		luaunit.assertEquals(rs, {"a", "b", "c"})
	end;

	["test: __pairs(): Iterating through an empty array"] = function ()
		local rs = {}
		for k, v in pairs(array()) do
			rs[k] = v
		end;
		luaunit.assertEquals(rs, {})
	end;

	["test: __pairs(): Iterating through an associated array"] = function ()
		local rs = {}
		for k, v in pairs(array({a = 1, b = 2, c = 3})) do
			rs[k] = v
		end;
		luaunit.assertEquals(rs, {a = 1, b = 2, c = 3})
	end;
}