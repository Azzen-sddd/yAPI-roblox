local HttpService = game:GetService("HttpService")

local function getStatus() : boolean
	local success, _ = pcall(function()
		return HttpService:GetAsync("https://yapi-api.com/")
	end)

	return success :: boolean or false :: boolean
end


return getStatus