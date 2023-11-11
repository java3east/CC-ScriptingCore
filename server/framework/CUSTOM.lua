SC.CUSTOM = {}
SC.CUSTOM.USED = false

--- get this frameworks core object
--- @return table|nil
--- @author Java3east
function SC.CUSTOM:GetCoreObject()
    SC.CUSTOM.USED = false
    return nil
end

--- Register a server callback
--- @param name string
--- @param cb function
--- @author Java3east
function SC.CUSTOM:RegisterServerCallback(name, cb)
    SC.CUSTOM.USED = false
end

--- Get the job of the a player
--- @param source integer
--- @return table|nil job
--- @author Java3east
function SC.CUSTOM:GetJob(source)
    SC.CUSTOM.USED = false
    return nil
end

--- Get all the players currently online
--- @return table|nil array of sources
--- @author Java3east
function SC.CUSTOM:GetPlayers()
    SC.CUSTOM.USED = false
    return nil
end

--- Add money to a players account
--- @param source integer
--- @param account string
--- @param amount number
--- @author Java3east
function SC.CUSTOM:AddAccountMoney(source, account, amount)
    SC.CUSTOM.USED = false
end