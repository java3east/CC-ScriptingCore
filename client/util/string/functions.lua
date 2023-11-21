function string.split(string, delimiter)
    local result = {}
    for match in string..delimiter:gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end