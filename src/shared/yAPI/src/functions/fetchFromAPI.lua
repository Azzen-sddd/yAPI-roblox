local HttpService = game:GetService("HttpService")

local function fetchFromAPI(API_URL : string, API_HEADERS : string?) : (boolean, string)
	assert(type(API_URL) == "string", "`API_URL` must be a string")
    assert(pcall(HttpService.GetAsync, HttpService, 'https://google.com'), "Http requests are not enabled. Enable via game settings")
    if API_HEADERS then assert(type(API_HEADERS) == "string", "`API_HEADERS` must be a string") end

    local taskID : number = Random.new(math.randomseed(1000000)):NextInteger(10000, 99999)
    local API_URL_PARTS : table = {
        subdomain = API_URL:match("^([^?]*)"):match("^([^/]+)/"),
        pathWithQuery = API_URL:match("^[^/]+/(.*)")
    }

    local queryParams = API_URL:match("%?(.*)")
    local pathWithoutQuery = API_URL_PARTS.pathWithQuery

    if queryParams then
        pathWithoutQuery = API_URL_PARTS.pathWithQuery:match("^(.-)%?")
        API_URL_PARTS.queryParms = queryParams
    end

    local API_SUCCESS : boolean, API_RESPONSE : string? = pcall(function()
        return HttpService:GetAsync(string.format("https://%s.yapi-api.com/%s?%s", API_URL_PARTS.subdomain, pathWithoutQuery, API_URL_PARTS.queryParms or ""), false, API_HEADERS or nil)
    end)

    if not API_SUCCESS then
        warn(string.format([[ [fetchFromAPI :: TkID/%s] Failed to fetch from API 
        API_RESPONSE : %s
    ]], tostring(taskID), tostring(API_RESPONSE)))
        return API_SUCCESS :: boolean, API_RESPONSE :: string?
    else
        return API_SUCCESS :: boolean, API_RESPONSE :: string?
    end
end


return fetchFromAPI