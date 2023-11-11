SC.CUSTOM = {}
SC.CUSTOM.USED = false
function SC.CUSTOM:GetCoreObject()
    SC.CUSTOM.USED = false
    return nil
end

function SC.CUSTOM:TriggerServerCallback(name, cb, ...)
    SC.CUSTOM.USED = false
end

function SC.CUSTOM:IsPlayerLoaded()
    SC.CUSTOM.USED = false
    return nil
end

function SC.CUSTOM:GetJob()
    SC.CUSTOM.USED = false
    return nil
end

function SC.CUSTOM:Notify(text)
    SC.CUSTOM.USED = false
end

RegisterNetEvent('my_resource:playerLoaded', function()
    TriggerEvent('jb_scriptingCore:CLIENT:playerLoaded')
end)