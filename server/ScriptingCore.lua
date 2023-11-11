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

--- Get the name of the used framework
--- @return string frameworkname
--- @author Java3east
function SC.Functions:GetFramework()
    return Config.framework or "CUSTOM"
end

--- get the resource name  of the used framework
--- @return string|nil
--- @author Java3east
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

--- Run a function on the 'CUSTOM' and the used framework
--- @param fkt function
--- @param ... any
--- @return any result
--- @author Java3east
function SC.Functions:Run(fkt, ...)
    local result = table.pack(SC.CUSTOM[fkt](SC.CUSTOM, ...))
    if SC.CUSTOM.USED then
        SC.CUSTOM.USED = false
        return table.unpack(result or {})
    end
    return SC[self:GetFramework()][fkt](SC[self:GetFramework()], ...)
end

--- Debug a message
--- @param ... any
--- @author Java3east
function SC.Functions:Debug(...)
    if Config.debug then
        local invoker = GetInvokingResource()
        print(("[^5%s^7] " .. ...):format(invoker))
    end
end

--- Wait for an event to be triggered
--- @param name string
--- @return any result
--- @author Java3east
function SC.Functions:AwaitEvent(name)
    local promise = Promise:new()
    RegisterNetEvent(name)
    AddEventHandler(name, function(...)
        promise:resolve(...)
    end)
    return promise:await(-1)
end

--- Register a new server callback
--- @param name string
--- @param cb function
--- @author Java3east
function SC.Functions:RegisterServerCallback(name, cb)
    self:Run("RegisterServerCallback", name, cb)
end

--- Get the core object of the used framework
--- @return table|nil
--- @author Java3east
function SC.Functions:GetCoreObject()
    return self:Run("GetCoreObject")
end

--- Get a players job
--- @param source integer
--- @return table job
--- @author Java3east
function SC.Functions:GetJob(source)
    return self:Run("GetJob", source)
end

--- Trigger a event on all online players
--- @param event string
--- @param ... any
--- @author Java3east
function SC.Functions:ToAllOnlinePlayers(event, ...)
    for _, source in pairs(self:GetPlayers()) do
        TriggerClientEvent(event, source, ...)
    end
end

--- Get a list of online players
--- @return table array
--- @author Java3east
function SC.Functions:GetPlayers()
    return self:Run("GetPlayers")
end

--- Get the players default colors
--- @return table
--- @author Java3east
function SC.Functions:GetDefaultColors()
    return Config.server.colors
end

--- Add money to a players account
--- @param source integer
--- @param account string
--- @param amount interger
--- @author Java3east
function SC.Functions:AddAccountMoney(source, account, amount)
    self:Run("AddAccountMoney", source, account, amount)
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