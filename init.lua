return setmetatable({}, {
	__index = {};
	__call = function (self, ...)
		return setmetatable({}, {
			__index = getmetatable(self).__index
		})
	end
})
