local ReplicatedStorage = game:GetService("ReplicatedStorage")
local yAPI = require(ReplicatedStorage.Shared.yAPI)

yAPI:Promise():fetchFromAPI("catalog/api/v2/search/items/details?Category=1&CreatorType=Group&CreatorTargetId=32397047", nil)
    :andThen(function(response)
        print("Data from API:", response)
    end)
    :catch(function(error)
        warn("Error fetching data:", error)
    end)

yAPI:Promise():getStatus()
    :andThen(function(response)
        print("Status from API:", response)
    end)
    :catch(function(error)
        warn("Error getting status:", error)
    end)
