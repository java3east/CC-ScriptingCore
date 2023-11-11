SC.ESX = {}
ESX = nil

function SC.ESX:GetCoreObject()
    ESX = exports[SC.Functions:GetResourceName()]:getSharedObject()
    return ESX
end

function SC.ESX:RegisterServerCallback(name, cb)
    ESX.RegisterServerCallback(name, cb)
end

function SC.ESX:GetJob(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    return xPlayer.getJob()
end

function SC.ESX:GetPlayers()
    return ESX.GetPlayers()
end

function SC.ESX:AddAccountMoney(source, account, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addAccountMoney(account, amount)
end