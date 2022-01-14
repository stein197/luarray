-- TODO
TestIntegration = {
	test = function ()
		local a = array("a", "b", "c")
		a = a:map(function (i, elt) return elt:upper() end)
		
	end;
}