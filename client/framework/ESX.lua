SC.ESX = {}
ESX = nil

function SC.ESX:GetCoreObject()
    ESX = exports[SC.Functions:GetResourceName()]:getSharedObject()
    return ESX
end

function SC.ESX:TriggerServerCallback(name, cb, ...)
    ESX.TriggerServerCallback(name, cb, ...)
end

function SC.ESX:IsPlayerLoaded()
    return ESX.IsPlayerLoaded()
end

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

function SC.ESX:Notify(text)
    ESX.ShowNotification(text)
end

RegisterNetEvent('esx:playerLoaded', function()
    TriggerEvent('jb_scriptingCore:CLIENT:playerLoaded')
end)