local clua = setmetatable({}, {
	__index = function(_, i)
		local function index(header, i)
			return function()
				return terralib.includec(header)[i]
			end
		end
		local ok, f = pcall(index("lua.h", i))
		if not ok and f then
			ok, f = pcall(index("lauxlib.h", i))
		end
		if not ok and f then
			ok, f = pcall(index("lualib.h", i))
		end
		if ok and f then
			return f
		end
	end
})

print(clua.LUA_VERSION_NUM)
