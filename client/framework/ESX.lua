SC.ESX = {}

--- @type table|nil
ESX = nil

--- Get this frameworks core
--- @return table|nil this frameworks core
--- @author Java3east
function SC.ESX:GetCoreObject()
    ESX = exports[SC.Functions:GetResourceName()]:getSharedObject()
    return ESX
end

--- Trigger a server callback
--- @param name string the name of the callback
--- @param cb function the callback function
--- @param ... any the callback arguments
--- @author Java3east
function SC.ESX:TriggerServerCallback(name, cb, ...)
    ESX.TriggerServerCallback(name, cb, ...)
end

--- Check if this player has loaded
--- @return boolean true if the player has loaded
--- @author Java3east
function SC.ESX:IsPlayerLoaded()
    return ESX.IsPlayerLoaded()
end

--- Get the players job
--- @return table|nil job the players job
--- @author Java3east
function SC.ESX:GetJob()
    local PlayerData = ESX.GetPlayerData()
    if not PlayerData then
        return nil
    end

    local xJob = PlayerData.job
    if not xJob then
        return nil
    end

    return {
        name            = xJob.name,
        label           = xJob.label,
        grade           = xJob.grade,
        grade_name      = xJob.grade_name,
        grade_label     = xJob.grade_label,
        salary          = xJob.grade_salary
    }
end

--- Display a notification
--- @param text string the notification
--- @author Java3east
function SC.ESX:Notify(text)
    ESX.ShowNotification(text)
end

--- Translate this frameworks playerLoaded event to the scripting core event
RegisterNetEvent('esx:playerLoaded', function()
    TriggerEvent('jb_scriptingCore:CLIENT:playerLoaded')
end)