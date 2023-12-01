--- @class AnimationManager
AnimationManager = {animations = {}, transitions = {}, states = {}, state = nil}

--- @param animations table|nil
--- @param transitions table|nil
--- @return AnimationManager
function AnimationManager:New(animations, transitions)
    local manager = {}
    manager.animations = animations or self.animations
    manager.transitions = transitions or self.transitions
    manager.RegisterState = self.RegisterState
    manager.RegisterTransition = self.RegisterTransition
    manager.SetState = self.SetState
    manager.Transit = self.Transit
    return manager
end

--- @param self AnimationManager
--- @param name string
--- @param animation Animation|nil
function AnimationManager.RegisterState(self, name, animation)
    self.states[name] = animation
end

--- @param self AnimationManager
--- @param stateA string
--- @param stateB string
--- @param animation Animation|nil
function AnimationManager.RegisterTransition(self, stateA, stateB, animation)
    if not self.transitions[stateA] then
        self.transitions[stateA] = {}
    end
    self.transitions[stateA][stateB] = animation
end

--- @param self AnimationManager
--- @param state string
function AnimationManager.SetState(self, state)
    if self.states[self.state] then
        self.states[self.state]:Stop(true)
    end
    self.state = state
    if self.states[state] then
        self.states[state]:Play()
    end
end

--- @param self AnimationManager
--- @param state string
function AnimationManager.Transit(self, state)
    if self.states[self.state] then
        self.states[self.state]:Stop()
    end
    if self.transitions[self.state][state] then
        self.transitions[self.state][state]:Play(function()
            if self.states[state] then
                self.states[state]:Play()
            end
        end)
    else
        self.states[state]:Play()
    end
    self.state = state
end