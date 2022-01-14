TestIntegration = {
	test = function ()
		local a = array("a", "b", "c", "d", "e", "f")
		a[7] = "g"
		a = a..array("h", "i", "j", "k", "l")
		a = a * array("a", "b", "c", "d", "e", "f", "g")
		a = a + array("h", "i", "j", "k", "l")
		a = a - array("f", "g")
		a = a:filter(function (i, elt) return 97 <= elt:byte() and elt:byte() <= 102 end):map(function (i, elt) return elt:upper() end):clone():sort(function (a, b)
			return a > b
		end)
		luaunit.assertEquals(a:join(""), "EDCBA")
		a = a:reverse()
		a:addend("f")
		a:addend("A")
		a = a:uniq()
		a:del(-2)
		a = a:chunk(2):flat()
		a:addbefore(1, "a")
		luaunit.assertEquals(a:totable(), {"a", "A", "B", "C", "D", "f"})
	end;
}