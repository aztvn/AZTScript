local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer

        for _, func in ipairs(getgc(true)) do
            if type(func) == "function" and (isluaclosure and isluaclosure(func) or true) then
                local success, upvalues = pcall(function()
                    return debug.getupvalues(func)
                end)
                
                if success and upvalues then
                    for i, val in pairs(upvalues) do
                        if type(val) == "number" and val > 0 and val <= 100 then
                            local successConst, constants = pcall(debug.getconstants, func)
                            if successConst then
                                for _, c in ipairs(constants) do
                                    if hookfunction and (tostring(c):find("Stamina") or tostring(c):find("Run")) then
                                        pcall(function()
                                            hookfunction(func, function(...)
                                                return
                                            end)
                                        end)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
