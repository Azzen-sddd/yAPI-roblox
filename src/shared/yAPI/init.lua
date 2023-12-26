--[[
	Made by @GramGramGaming123 on Roblox
	@rustyspotted on Discord
	@zzen_a on the Twitter
	
	-- // 
	
        MIT License

        Copyright (c) 2023 @GramGramGaming123

        Permission is hereby granted, free of charge, to any person obtaining a copy
        of this software and associated documentation files (the "Software"), to deal
        in the Software without restriction, including without limitation the rights
        to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
        copies of the Software, and to permit persons to whom the Software is
        furnished to do so, subject to the following conditions:

        The above copyright notice and this permission notice shall be included in all
        copies or substantial portions of the Software.

        THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
        IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
        FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
        AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
        LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
        OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
        SOFTWARE.
	
	\\ --
]]

export type Metadata = table

local src : Folder = script:FindFirstChild("src")
local components : Folder = src:FindFirstChild("components")
local dependencies : Folder = src:FindFirstChild("dependencies")
local functions : Folder = src:FindFirstChild("functions")

local promise = require(dependencies:FindFirstChild("evaera_promise@4.0.0"):FindFirstChild("promise"))
local enum = require(components:FindFirstChild("enum"))

local yAPI = setmetatable({}, {
    ClassName = "Metamain",
    ModuleStatus = enum.makeEnum("yAPI.ModuleStatus", {"Started", "Stopped"}),
    __index = function(tbl, key)
        local function generateMethod(methodName)
            return function(...)
                local func = require(functions:FindFirstChild(methodName))
                local args = {select(2, ...)}
 
                return func(unpack(args)) 
            end
        end

        if key == "Promise" then
            return function()
                local promiseObj = promise.new(function(resolve, reject)
                    resolve("Initial Promise Resolved")
                end)

                local promiseMethods = {
                    fetchFromAPI = function(self, API_URL, API_HEADERS)
                        return promise.new(function(resolve, reject)
                            local success, response = require(functions:FindFirstChild("fetchFromAPI"))(API_URL, API_HEADERS)
                            if success then
                                resolve(response)
                            else
                                reject(response)
                            end
                        end)
                    end,
                    getStatus = function(self)
                        return promise.new(function(resolve, reject)
                            local success = require(functions:FindFirstChild("getStatus"))()
                            if success then
                                resolve(success)
                            else
                                reject(success)
                            end
                        end)
                    end,
                }

                return setmetatable(promiseObj, {
                    __index = function(_, k)
                        local method = promiseMethods[k]
                        if method then
                            return function(self, ...)
                                return method(self, ...)
                            end
                        else
                            return rawget(_, k)
                        end
                    end
                })
            end
        else
            return generateMethod(key)
        end
    end,
})

return yAPI