local CHARS = "aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ0123456789"

function string.random(length)
    local str = ""
    for i = 1, length, 1 do
        local random = math.random(CHARS:len())
        str = str .. CHARS:sub(random, random)
    end
    return str
end