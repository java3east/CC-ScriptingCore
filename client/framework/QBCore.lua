SC.QB = {}

--- @type table|nil
QBCore = nil

--- Get the frameworks core object
--- @return table|nil core the frameworks core object
--- @author Java3east
function SC.QB:GetCoreObject()
    QBCore = exports[SC.Functions:GetResourceName()]:GetCoreObject()
    return QBCore
end

--- Trigger a callback on the server
--- @param name string
--- @param cb function
--- @param ... any
--- @author Java3east
function SC.QB:TriggerServerCallback(name, cb, ...)
    QBCore.Functions.TriggerServerCallback(name, cb, ...)
end

--- Check if this player has loaded
--- @return boolean
--- @author Java3east
function SC.QB:IsPlayerLoaded()
    return QBCore.Functions.GetPlayerData() ~= nil
end

--- Get the players job
--- @return table|nil job
--- @author Java3east
function SC.QB:GetJob()
    local PlayerData = QBCore.Functions.GetPlayerData()
    if not PlayerData then
        return nil
    end

    local qJob = PlayerData.job
    if not qJob then
        return nil
    end

    return {
        name            = qJob.name,
        label           = qJob.label,
        grade           = qJob.grade.level,
        grade_name      = qJob.grade.name,
        grade_label     = qJob.grade.name,
        salary          = qJob.payment
    }
end

--- Display a notification
--- @param text string
--- @author Java3east
function SC.QB:Notify(text)
    QBCore.Functions.Notify(text)
end

--- Translate this frameworks player loaded event to the scripting core event
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    TriggerEvent('jb_scriptingCore:CLIENT:playerLoaded')
end)