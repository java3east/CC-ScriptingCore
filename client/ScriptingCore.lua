-- ################################################################## --
-- #                                                                # --
-- #                         Scripting Core                         # --
-- #                            (CLIENT)                            # --
-- #                       Made by Java3east                        # --
-- #                                                                # --
-- ################################################################## --
--- @type boolean true if this script is done loading
local loaded = false


SC = {}
SC.Functions = {}

--- Get the name of the used framework
--- @return string frameworkname
--- @author Java3east
function SC.Functions:GetFramework()
    return Config.framework or "CUSTOM"
end

--- Get the resource name of the used framework
--- @return string resourcename
--- @author Java3east
function SC.Functions:GetResourceName()
    if Config.resource then
        return Config.resource
    elseif self:GetFramework() == "ESX" then
        return "es_extended"
    elseif self:GetFramework() == "QB" then
        return "qb-core"
    else
        error("Unknown framework name '" .. tostring(self:GetFramework()) .. "' expected 'ESX', 'QB' or 'CUSTOM' with defined resource.")
    end
end

--- Run a framework related function on the currently used framework
--- @param fkt string function name
--- @param ... any function parameters
--- @return any result the result of the function call
--- @author Java3east
function SC.Functions:Run(fkt, ...)
    local result = table.pack(SC.CUSTOM[fkt](SC.CUSTOM, ...))
    if SC.CUSTOM.USED then
        SC.CUSTOM.USED = false
        return table.unpack(result or {})
    end
    return SC[self:GetFramework()][fkt](SC[self:GetFramework()], ...)
end

--- print a debug message, if debugging is enabled
--- @param ... any
--- @author Java3east
function SC.Functions:Debug(...)
    if Config.debug then
        local invoker = GetInvokingResource()
        print(("[^5%s^7] " .. ...):format(invoker))
    end
end

--- Trigger a server callback
--- @param name string
--- @param ... any
--- @return action action
--- @author Java3east
function SC.Functions:ServerCallback(name, ...)
    local args = table.pack(... or {})
    return Action:new(function(cb)
        self:Run("TriggerServerCallback", name, cb, table.unpack(args))
    end)
end

--- Wait for an event to be called
--- @param name string
--- @return any result of the event
--- @author Java3east
function SC.Functions:AwaitEvent(name)
    local promise = Promise:new()
    RegisterNetEvent(name)
    AddEventHandler(name, function(...)
        promise:resolve(...)
    end)
    return promise:await(-1)
end

--- Get the core object of the used framework
--- @return table coreobject the core object
--- @author Java3east
function SC.Functions:GetCoreObject()
    return self:Run("GetCoreObject")
end

--- Get the servers default colors
--- @return table colors
--- @author Java3east
function SC.Functions:GetDefaultColors()
    return Config.server.colors
end

--- Get the servers default marker
--- @return table defaultMarker
--- @author Java3east
function SC.Functions:GetDefaultMarker()
    return Config.server.marker
end

--- Draw a marker
--- @deprecated
--- @param viewDistance number
--- @param type integer
--- @param x number
--- @param y number
--- @param z number
--- @param rotX number
--- @param rotY number
--- @param rotZ number
--- @param diameter number
--- @param scaleZ number
--- @param r integer
--- @param g integer
--- @param b integer
--- @param a integer
--- @param blobUpAndDown boolean
--- @param rotate boolean
--- @return boolean draw
--- @return boolean interact
--- @author Java3east
function SC.Functions:DrawMarker(viewDistance, type, x, y, z, rotX, rotY, rotZ, diameter, scaleZ, r, g, b, a, blobUpAndDown, rotate)
    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)
    local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, x, y, z, true) - 1.0
    if distance <= viewDistance then
        DrawMarker(type, x, y, z, 0.0, 0.0, 0.0, rotX, rotY, rotZ, diameter, diameter, scaleZ, r, g, b, a, blobUpAndDown, false, 2, rotate, nil, nil, false)
        return true, distance <= diameter / 2
    end
    return false, false
end

--- Draw the servers default marker
--- @deprecated
--- @param x number
--- @param y number
--- @param z number
--- @param diameter number
--- @return boolean draw
--- @return boolean interact
--- @author Java3east
function SC.Functions:DrawDefaultMarker(x, y, z, diameter)
    local playerPed = PlayerPedId()
    local defaultMarker = Config.server.marker
    local pos = GetEntityCoords(playerPed)
    local color = defaultMarker.color
    local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, x, y, z, true) - 1.0
    if distance < defaultMarker.viewDistance then
        DrawMarker(1, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, diameter, diameter, 1.0, color.r, color.g, color.b, defaultMarker.alpha)
        return true, distance <= diameter / 2
    end
    return false, false
end

--- Draw the servers default marker with good performance.
--- @param x number
--- @param y number
--- @param z number
--- @param diameter number
--- @param time integer
--- @param key integer
--- @param infoTextId string
--- @param callback function triggered on interaction
--- @author Java3east
function SC.Functions:AsyncDrawDefaultMarker(x, y, z, diameter, time, key, infoTextId, callback)
    local playerPed = PlayerPedId()
    local defaultMarker = Config.server.marker
    local pos = GetEntityCoords(playerPed)
    local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, x, y, z, true) - 1.0
    if distance < defaultMarker.viewDistance then
        local color = defaultMarker.color
        local bool = true
        CreateThread(function()
            Wait(time)
            bool = false
        end)
        CreateThread(function()
            if key and callback and distance < diameter / 2 then
                while bool do
                    if distance < diameter / 2 then
                        DisplayHelpTextThisFrame(infoTextId, 0)
                    end
                    DrawMarker(1, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, diameter, diameter, 1.0, color.r, color.g, color.b, defaultMarker.alpha)
                    if IsControlJustReleased(0, key) then
                        callback()
                    end
                    Wait(0)
                end
            else
                while bool do
                    DrawMarker(1, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, diameter, diameter, 1.0, color.r, color.g, color.b, defaultMarker.alpha)
                    Wait(0)
                end
            end
        end)
    end
end

--- Spawn a vehilce
--- @return action action
--- @author Java3east
function SC.Functions:SpawnVehicle()
    return Action:new(function(cb, model, x, y, z, w)
        local hashModel = GetHashKey(model)
        RequestModel(hashModel)
        while not HasModelLoaded(model) do
            Wait(100)
        end
        cb(CreateVehicle(hashModel, x, y, z, w, true, true))
    end)
end

--- Check if the player has loaded
--- @return boolean
--- @author Java3east
function SC.Functions:IsPlayerLoaded()
    return self:Run("IsPlayerLoaded")
end

--- Get the players job
--- @return table job
--- @author Java3east
function SC.Functions:GetJob()
    return self:Run("GetJob")
end

--- Display a notification
--- @param text string
--- @author Java3east
function SC.Functions:Notify(text)
    self:Run("Notify", text)
end

--- Show a help notification
--- @param text string
--- @param loop boolean
--- @param sound boolean
--- @param duration integer
--- @author Java3east
function SC.Functions:ShowHelpNotification(text, loop, sound, duration)
    loop = loop or false
    sound = sound or false
    duration = duration or 0
    BeginTextCommandDisplayHelp("THREESTRINGS")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, loop, sound, duration)
end

--- Wait for the player to load
--- @return action action
--- @author Java3east
function SC.Functions:AwaitPlayerLoaded()
    return Action:new(function(cb)
        if SC.Functions:IsPlayerLoaded() then
            cb()
        else
            AddEventHandler('jb_scriptingCore:CLIENT:playerLoaded', function()
                cb()
            end)
        end
    end)
end

--- Check if the player is relative located to an object / entity
--- @param object integer
--- @param direction vector3|table
--- @param distance number
--- @param diameter number
--- @param time integer
--- @param key integer
--- @param infoTextId string
--- @param callback function
--- @param drawMarker boolean
--- @param checkDistance number
--- @author Java3east
function SC.Functions:AsyncCheckIsPlayerRelativeLocated(object, direction, distance, diameter, time, key, infoTextId, callback, drawMarker, checkDistance)
    local coords = GetOffsetFromEntityInWorldCoords(object, direction.x * distance, direction.y * distance, direction.z * distance)
    local player = PlayerPedId()
    local pCoords = GetEntityCoords(player)
    local distance = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, pCoords.x, pCoords.y, pCoords.z, true)
    if distance < (checkDistance or Config.server.marker.viewDistance) then
        if drawMarker then
            self:AsyncDrawDefaultMarker(coords.x, coords.y, coords.z - 1.0, diameter, time, key, infoTextId, callback)
        else
            local bool = true
            CreateThread(function()
                Wait(time)
                bool = false
            end)
            CreateThread(function()
                if callback and distance < diameter / 2 then
                    if key then
                        while bool do
                            if distance < diameter / 2 then
                                DisplayHelpTextThisFrame(infoTextId, 0)
                            end
                            if IsControlJustReleased(0, key) then
                                callback()
                            end
                            Wait(0)
                        end
                    end
                else
                    callback()
                end
            end)
        end
    end
end

exports("GetCore", function(advanced)
    local promise = Promise:new()
    CreateThread(function()
        while not loaded do
            Wait(10)
        end
        promise:resolve()
    end)
    promise:await(-1)
    if advanced then
        return SC
    else
        return SC.Functions
    end
end)

AddEventHandler('onClientResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        SC.Functions:GetCoreObject()
        loaded = true
    end
end)