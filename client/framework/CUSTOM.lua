SC.CUSTOM = {}

--- true if the CUSTOM.Function was used
--- @type boolean
SC.CUSTOM.USED = false

--- Get this frameworks core object
--- @return table|nil core the core object
--- @author Java3east
function SC.CUSTOM:GetCoreObject()
    SC.CUSTOM.USED = false
    return nil
end

--- Trigger a server callback
--- @param name string the name of the callback
--- @param cb function a callback function
--- @param ... any callback arguments
--- @author Java3east
function SC.CUSTOM:TriggerServerCallback(name, cb, ...)
    SC.CUSTOM.USED = false
end

--- Check if this clients player has loaded
--- @return boolean|nil
--- @author Java3east
function SC.CUSTOM:IsPlayerLoaded()
    SC.CUSTOM.USED = false
    return nil
end

--- Get the job of this player
--- @return table|nil
--- @author Java3east
function SC.CUSTOM:GetJob()
    SC.CUSTOM.USED = false
    return nil
end

--- Display a notification
--- @param text string the text to display
function SC.CUSTOM:Notify(text)
    SC.CUSTOM.USED = false
end

--- Translate this frameworks playerLoaded event to the scripting core event
RegisterNetEvent('my_resource:playerLoaded', function()
    TriggerEvent('jb_scriptingCore:CLIENT:playerLoaded')
end)