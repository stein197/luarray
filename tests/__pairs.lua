Test__pairs = {
	["test: Should be an empty loop when the array is empty"] = function ()
		local indices, values = {}, {}
		for i, v in pairs(array()) do
			table.insert(indices, i)
			values[i] = v
		end
		luaunit.assertEquals(indices, {})
		luaunit.assertEquals(values, {})
	end;

	["test: Should be correct"] = function ()
		local indices, values = {}, {}
		for i, v in pairs(array("a", "b", "c")) do
			table.insert(indices, i)
			values[i] = v
		end
		luaunit.assertEquals(indices, {1, 2, 3})
		luaunit.assertEquals(values, {"a", "b", "c"})
	end;

	["test: Should be correct when there are nils in array"] = function ()
		local indices, values = {}, {}
		for i, v in pairs(array(nil, "b", nil, "d", nil)) do
			table.insert(indices, i)
			values[i] = v
		end
		luaunit.assertEquals(indices, {1, 2, 3, 4, 5})
		luaunit.assertEquals(values, {nil, "b", nil, "d", nil})
	end;
}
