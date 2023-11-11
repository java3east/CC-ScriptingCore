Promise = {done = false, result = nil}
Promise.__index = Promise

function Promise:new()
    local object = {}
    setmetatable(object, self)
    self.__index = self
    return object
end

function Promise:resolve(...)
    self.result = table.pack(...)
    self.done = true
end

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