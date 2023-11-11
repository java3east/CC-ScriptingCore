-- ################################################################## --
-- #                                                                # --
-- #                         Scripting Core                         # --
-- #                            (SERVER)                            # --
-- #                       Made by Java3east                        # --
-- #                                                                # --
-- ################################################################## --

local ASCII = [[
    
    ····································································
    :                                                                  :
    :                                                                  :
    :                                                                  :
    :    __   __   __     __  ___         __      __   __   __   ___   :
    :   /__` /  ` |__) | |__)  |  | |\ | / _`    /  ` /  \ |__) |__    :
    :   .__/ \__, |  \ | |     |  | | \| \__>    \__, \__/ |  \ |___   :
    :                                                                  :
    :                                                                  :
    :                                                                  :
    ····································································
]]

SC = {}
SC.Functions = {}

function SC.Functions:GetFramework()
    return Config.framework or "CUSTOM"
end

function SC.Functions:GetResourceName()
    if Config.resource then
        return Config.resource
    elseif self:GetFramework() == "ESX" then
        return "es_extended"
    elseif self:GetFramework() == "QB" then
        return "qb-core"
    else
        error("Unknown framework name '" .. tostring(self:GetFramework()) .. "' expected 'ESX', 'QB' or 'CUSTOM' with defined resource.")
    end
end

function SC.Functions:Run(fkt, ...)
    local result = table.pack(SC.CUSTOM[fkt](SC.CUSTOM, ...))
    if SC.CUSTOM.USED then
        SC.CUSTOM.USED = false
        return table.unpack(result or {})
    end
    return SC[self:GetFramework()][fkt](SC[self:GetFramework()], ...)
end

function SC.Functions:Debug(...)
    if Config.debug then
        local invoker = GetInvokingResource()
        print(("[^5%s^7] " .. ...):format(invoker))
    end
end

function SC.Functions:AwaitEvent(name)
    local promise = Promise:new()
    RegisterNetEvent(name)
    AddEventHandler(name, function(...)
        promise:resolve(...)
    end)
    return promise:await(-1)
end

function SC.Functions:RegisterServerCallback(name, cb)
    self:Run("RegisterServerCallback", name, cb)
end

function SC.Functions:GetCoreObject()
    return self:Run("GetCoreObject")
end

function SC.Functions:GetJob(source)
    return self:Run("GetJob", source)
end

function SC.Functions:ToAllOnlinePlayers(event, ...)
    for _, source in pairs(self:GetPlayers()) do
        TriggerClientEvent(event, source, ...)
    end
end

function SC.Functions:GetPlayers()
    return self:Run("GetPlayers")
end

function SC.Functions:GetDefaultColors()
    return Config.server.colors
end

function SC.Functions:AddAccountMoney(source, account, amount)
    self:Run("AddAccountMoney", source, account, amount)
end

function SC.Functions:SetWeather(weatherType)

end

exports("GetCore", function(advanced)
    SC.Functions:Debug("Loading core object...")
    if advanced then
        return SC
    else
        return SC.Functions
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    print(ASCII)
    SC.Functions:GetCoreObject()
end)