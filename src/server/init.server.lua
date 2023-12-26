local yAPI = require(game.ReplicatedStorage.Shared.yAPI)

yAPI:Promise():fetchFromAPI("catalog/api/v2/search/items/details?Category=1&CreatorType=Group&CreatorTargetId=32397047", nil)
    :andThen(function(response)
        print("Data from API:", response)
    end)

    yAPI:Promise():getStatus()
    :andThen(function(response)
        print("Data from API:", response)
    end)
-- local success, response =  yAPI:fetchFromAPI("catalog/api/v2/search/items/details?Category=1&CreatorType=Group&CreatorTargetId=32397047", nil)

-- warn(response)
