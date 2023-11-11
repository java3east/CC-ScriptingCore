SC.CUSTOM = {}
SC.CUSTOM.USED = false
function SC.CUSTOM:GetCoreObject()
    SC.CUSTOM.USED = false
end
function SC.CUSTOM:RegisterServerCallback(name, cb)
    SC.CUSTOM.USED = false
end
function SC.CUSTOM:GetJob(source)
    SC.CUSTOM.USED = false
end
function SC.CUSTOM:GetPlayers()
    SC.CUSTOM.USED = false
end

function SC.CUSTOM:AddAccountMoney(source, account, amount)
    SC.CUSTOM.USED = false
end