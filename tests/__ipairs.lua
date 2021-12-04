Test__ipairs = {
	["test: Iterating through an array"] = function ()
		local rs = {}
		for k, v in ipairs(array("a", "b", "c")) do
			rs[k] = v
		end;
		luaunit.assertEquals(rs, {"a", "b", "c"})
	end;

	["test: Iterating through an empty array"] = function ()
		local rs = {}
		for k, v in ipairs(array()) do
			rs[k] = v
		end;
		luaunit.assertEquals(rs, {})
	end;

	["test: Iterating through an associated array"] = function ()
		local rs = {}
		for k, v in ipairs(array({a = 1, b = 2, c = 3})) do
			rs[k] = v
		end;
		luaunit.assertEquals(rs, {})
	end;
}