SC.QB = {}
QBCore = nil

function SC.QB:GetCoreObject()
    QBCore = exports[SC.Functions:GetResourceName()]:GetCoreObject()
    return QBCore
end

function SC.QB:RegisterServerCallback(name, cb)
    QBCore.Functions.RegisterServerCallback(name, cb)
end

function SC.QB:GetJob(source)
    local qPlayer = QBCore.Functions.GetPlayer(source)
    return qPlayer.PlayerData.job
end

function SC.QB:GetPlayers()
    return QBCore.Functions.GetPlayers()
end

function SC.QB:AddAccountMoney(source, account, amount)
    local qPlayer = QBCore.Functions.GetPlayer(source)
    if account == "money" then
        account = "cash"
    end
    qPlayer.Functions.AddMoney(account, amount)
end