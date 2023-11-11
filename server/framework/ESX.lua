SC.ESX = {}
ESX = nil

--- Get the frameworks core object
--- @return table|nil
--- @author Java3east
function SC.ESX:GetCoreObject()
    ESX = exports[SC.Functions:GetResourceName()]:getSharedObject()
    return ESX
end

--- Register a server callback
--- @param name string
--- @param cb function
--- @author Java3east
function SC.ESX:RegisterServerCallback(name, cb)
    ESX.RegisterServerCallback(name, cb)
end

--- Get a players job
--- @param source integer
--- @return any
--- @author Java3east
function SC.ESX:GetJob(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    return xPlayer.getJob()
end

--- Get a list of currently online players
--- @return table array
--- @author Java3east
function SC.ESX:GetPlayers()
    return ESX.GetPlayers()
end

--- Add money to a players account
--- @param source integer
--- @param account string
--- @param amount integer
--- @author Java3east
function SC.ESX:AddAccountMoney(source, account, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addAccountMoney(account, amount)
end