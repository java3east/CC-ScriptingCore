PartyManager = {}
PartyManager.Parties = {}
PartyManager.public = {}

--- create a new party
--- @param leader integer the source of the party leader
--- @return Party the party object
function PartyManager.Functions:CreateParty(leader)
    return Party:New(leader)
end

--- get a party by its id
--- @param id string the party id
--- @return Party|nil party the party or nil if no party with that id exists.
function PartyManager.Functions:GetParty(id)
    return PartyManager.Parties[id]
end

--- Get the party a player is currently part of
--- @param source integer the players source
--- @return Party|nil the party or nil if the player is in no party
function PartyManager.Functions:GetPartyOfPlayer(source)
    for _, party in pairs(PartyManager.Parties) do
        if party.leader == source then
           return party
        else
            for _, src in ipairs(party.members) do
                if src == source then
                    return party
                end
            end
        end
    end
    return nil
end


--- @class Party
Party = { id = 0, leader = 0, members = { }, max_size = -1 }

--- create a new Party with a leader
--- @param leader integer source of the leader
--- @param max_size integer|nil the maxium size of this party, -1 for infinite
--- @return Party party the created party
function Party:New(leader, max_size)
    local party = {}
    party.id = string.random(10)
    party.leader = leader
    party.members = {}
    party.max_size = max_size or self.max_size
    party.Broadcast = self.Broadcast
    party.Delete = self.Delete
    party.Size = self.Size
    party.Leave = self.Leave
    party.Join = self.Join
    PartyManager.Parties[party.id] = party
    return party
end

--- Broadcast an event to all members of the party
--- @param self Party the party object
--- @param event string the event name
--- @param ... any|nil the event data
function Party.Broadcast(self, event, ...)
    for _, source in ipairs(self.members) do
        TriggerClientEvent(event, source, ...)
    end
    TriggerClientEvent(event, self.leader, ...)
end

--- Delete this party and kick all members
--- @param self Party the party object
function Party.Delete(self)
    self:Broadcast('cc_scriptingCore:kicked', "party_deleted")
    PartyManager.Parties[self.id] = nil
    TriggerEvent('cc_scriptingCore:partyDeleted', self.id)
end

--- Get the size of this party.
--- @param self Party the party object
--- @return integer the size of the party
function Party.Size(self)
    return #self.members + 1
end

--- make a player leave the party
--- @param self Party the party object
--- @param source integer the players source who is leaving
--- @param reason string the reason the player left the party
function Party.Leave(self, source, reason)
    table.remove(self.members, source)
    if self.leader == source then
        if #self.members == 0 then
            self:Delete()
        end
    end
    TriggerEvent('cc_scriptingCore:playerPartyLeave', self.id, source, reason)
end

--- make a player join a party
--- @param self Party the party object
--- @param source integer the source of the player that is trying to join
--- @return boolean true if the player was added to the party, false if not
function Party.Join(self, source)
    if self.max_size ~= -1 and self:Size() >= self.max_size then
        return false
    else
        table.insert(self.members, source)
        TriggerEvent('cc_scriptingCore:playerPartyJoined', self.id, source)
        return true
    end
end


exports("GetPartyManager", function()
    return PartyManager.Functions
end)