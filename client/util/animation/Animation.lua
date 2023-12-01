--- @class Animation
Animation = {name = "", time = 1.0, infinite = false, run = false}

--- @param name string|nil
--- @param time number|nil
--- @param infinite boolean|nil
---@return Animation
function Animation:New(name, time, infinite)
    local animation = {}
    aniamtion.name = name or self.name
    animation.time = time or self.time
    animation.infinite = infinite or self.infinite
    animation.Play = self.Play
    animation.Stop = self.Stop
    return animation
end

--- @param self Animation
--- @param cb function|nil
function Animation.Play(self, cb)
    local animData = string.split(self.name, " ");
    local dict = animData[1]
    local name = animData[2]
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
    if self.infinite then
        CreateThread(function()
            TaskPlayAnim(PlayerPedId(), dict, name, 8, -8, self.time, 0, 1.0, 0, 0, 0, 0)
            Wait(self.time)
            if cb then
                cb()
            end
        end)
    else
        self.run = true
        CreateThread(function()
            while self.run do
                TaskPlayAnim(PlayerPedId(), dict, name, 8, -8, self.time, 1, 1.0, 0, 0, 0, 0)
                Wait(self.time)
            end
            if cb then
                cb()
            end
        end)
    end
end

--- @param self Animation
--- @param interrupt boolean|nil
function Animation.Stop(self, interrupt)
    interrupt = interrupt or false
    self.run = false
    if interrupt then
        local animData = string.split(self.name, " ");
        local dict = animData[1]
        local name = animData[2]
        StopAnimTask(PlayerPedId(), dict, name, -1.0)
    end
end