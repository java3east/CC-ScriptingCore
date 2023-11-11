--- @class Action
Action = {fkt = function(...) end}
Action.__index = Action

--- Create a new action
--- @param fkt function
--- @return action action
--- @author Java3east
function Action:new(fkt)
    local object = {}
    object.fkt = fkt
    object.Async = Action.Async
    object.Sync = Action.Sync
    return object
end

--- excute this action Async
--- @param cb function
--- @param ... any
--- @author Java3east
function Action:Async(cb, ...)
    self.fkt(cb, ...)
end

--- execute this action Sync
--- @param ... any
--- @return any
--- @author Java3east
function Action:Sync(...)
    local promise = Promise:new()
    self.fkt(function(...)
        promise:resolve(...)
    end, ...)
    return promise:await(-1)
end