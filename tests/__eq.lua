Test__eq = {
	["test: Empty arrays are equal"] = function ()
		luaunit.assertTrue(array({}) == array({}))
	end;

	["test: Plain arrays with the same entries are equal"] = function ()
		luaunit.assertTrue(array({1}) == array({1}))
		luaunit.assertTrue(array({1, 2, 3}) == array({1, 2, 3}))
	end;

	["test: Arrays with mismatching lengths aren't equal"] = function ()
		luaunit.assertFalse(array({1}) == array({1, 2, 3}))
	end;

	["test: Arrays with unordered entries are equal"] = function ()
		luaunit.assertTrue(array({a = 1, b = 2, c = 3}) == array({c = 3, a = 1, b = 2}))
	end;

	["test: Arrays with the same values but different keys aren't equal"] = function ()
		luaunit.assertFalse(array({a = 1, b = 2, c = 3}) == array({a = 1, b = 2, d = 3}))
	end;

	["test: Arrays with the same imdeces but different values aren't equal"] = function ()
		luaunit.assertFalse(array({a = 1, b = 2, c = 3}) == array({a = 1, b = 2, c = 4}))
	end;

	["test: Array and the same plain table are equal"] = function ()
		luaunit.assertTrue(array({1, 2, 3, {3, {a = 1}}}) == {1, 2, 3, {3, {a = 1}}})
	end;

	["test: Nested arrays are equal"] = function ()
		luaunit.assertTrue(array(1, 2, {3, 4}) == array(1, 2, array(3, 4)))
	end;

	["test: Nested arrays accessed by index are equal"] = function ()
		luaunit.assertTrue(array(1, 2, {3, 4})[3] == array(1, 2, array(3, 4))[3])
	end;

	["test: Nested arrays with mismatching lengths aren't equal"] = function ()
		luaunit.assertFalse(array({1, 2, {3}}) == array({1, 2, {3, 4}}))
	end;

	["test: Arrays with the same object element are equal"] = function ()
		local o = Object()
		luaunit.assertTrue(array(o) == array({o}))
		luaunit.assertTrue(array(o) == array(o))
	end;

	["test: Arrays with the different objects as the elements aren't equal"] = function ()
		local o1 = Object()
		local o2 = Object()
		luaunit.assertFalse(array(o1) == array(o2))
	end;
}