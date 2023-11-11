Action = {fkt = function(...) end}
Action.__index = Action

function Action:new(fkt)
    local object = {}
    object.fkt = fkt
    object.Async = Action.Async
    object.Sync = Action.Sync
    return object
end

function Action:Async(cb, ...)
    self.fkt(cb, ...)
end

function Action:Sync(...)
    local promise = Promise:new()
    self.fkt(function(...)
        promise:resolve(...)
    end, ...)
    return promise:await(-1)
end