TestFind = {
	["test: Finding value in empty array returns nil"] = function ()
		luaunit.assertNil(array():find(function () return true end))
	end;

	["test: Closure accepts key and value arguments"] = function ()
		local key, value, last
		array {a = 1}: find(function (k, v, l)
			key = k
			value = v
			last = l
		end)
		luaunit.assertEquals(key, "a")
		luaunit.assertEquals(value, 1)
		luaunit.assertNil(last)
	end;

	["test: Finding by value returns both key and value"] = function ()
		local k, v = array {a = 1, b = 2, c = 3} :find(function (k, v) return v == 2 end)
		luaunit.assertEquals(k, "b")
		luaunit.assertEquals(v, 2)
	end;

	["test: Finding by key returns both key and value"] = function ()
		local k, v = array {a = 1, b = 2, c = 3} :find(function (k, v) return k == "b" end)
		luaunit.assertEquals(k, "b")
		luaunit.assertEquals(v, 2)
	end;
}
