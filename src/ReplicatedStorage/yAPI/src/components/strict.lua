--!strict
local function strict(t: { [any]: any }, name: string?)
	local newName = name or tostring(t)

	return setmetatable(t, {
		__index = function(_self, key)
			local message = ("%q (%s) is not a valid member of %s"):format(tostring(key), typeof(key), newName)

			error(message, 2)
		end,

		__newindex = function(_self, key, _value)
			local message = ("%q (%s) is not a valid member of %s"):format(tostring(key), typeof(key), newName)

			error(message, 2)
		end,
	})
end

return strict
