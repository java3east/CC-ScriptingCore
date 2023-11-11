SC.QB = {}
QBCore = nil

--- Get the frameowkrs core object
--- @return table|nil
--- @author Java3east
function SC.QB:GetCoreObject()
    QBCore = exports[SC.Functions:GetResourceName()]:GetCoreObject()
    return QBCore
end

--- Register a server callback
--- @param name string
--- @param cb function
--- @author Java3east
function SC.QB:RegisterServerCallback(name, cb)
    QBCore.Functions.RegisterServerCallback(name, cb)
end

--- get the players job
--- @param source integer
--- @return table the players job
--- @author Java3east
function SC.QB:GetJob(source)
    local qPlayer = QBCore.Functions.GetPlayer(source)
    return qPlayer.PlayerData.job
end

--- Get a list of currently online players
--- @return table array
--- @author Java3east
function SC.QB:GetPlayers()
    return QBCore.Functions.GetPlayers()
end

--- Add money to a players account
--- @param source integer
--- @param account string
--- @param amount integer
--- @author Java3east
function SC.QB:AddAccountMoney(source, account, amount)
    local qPlayer = QBCore.Functions.GetPlayer(source)
    if account == "money" then
        account = "cash"
    end
    qPlayer.Functions.AddMoney(account, amount)
end