local enum = setmetatable({}, {
    _VERSION = "v0.0.1",
})

function enum.makeEnum(enumName : string, enumMembers : table?)
    local newEnum = {}

	for _, memberName in ipairs(enumMembers) do
		newEnum[memberName] = memberName
	end

	return setmetatable(newEnum, {
		__index = function(_, k)
			error(string.format("%s is not in %s!", k, enumName), 2)
		end,
		__newindex = function()
			error(string.format("Creating new members in %s is not allowed!", enumName), 2)
		end,
	})
end

return enum