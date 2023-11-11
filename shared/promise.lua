--- @class Promise
Promise = {done = false, result = nil}
Promise.__index = Promise

--- Create a new promise
--- @return Promise promise
--- @author Java3east
function Promise:new()
    local object = {}
    setmetatable(object, self)
    self.__index = self
    return object
end

--- resolve this promise
--- @param ... any
--- @author Java3east
function Promise:resolve(...)
    self.result = table.pack(...)
    self.done = true
end

--- wait for the promise to resolve
--- @param limit integer maximum time to wait before stop waiting
--- @return any
--- @author Java3east
function Promise:await(limit)
    if limit == -1 then
        while not self.done do
            Wait(10)
        end
    else
        while not self.done and limit > 0 do
            Wait(10)
            limit = limit - 10
        end
    end
    return table.unpack(self.result or {})
end