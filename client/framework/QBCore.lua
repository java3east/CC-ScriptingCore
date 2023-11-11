SC.QB = {}
QBCore = nil

function SC.QB:GetCoreObject()
    QBCore = exports[SC.Functions:GetResourceName()]:GetCoreObject()
    return QBCore
end

function SC.QB:TriggerServerCallback(name, cb, ...)
    QBCore.Functions.TriggerServerCallback(name, cb, ...)
end

function SC.QB:IsPlayerLoaded()
    return QBCore.Functions.GetPlayerData() ~= nil
end

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

function SC.QB:Notify(text)
    QBCore.Functions.Notify(text)
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    TriggerEvent('jb_scriptingCore:CLIENT:playerLoaded')
end)