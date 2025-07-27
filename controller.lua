local selected = 1

local function formatText(str, chars)
    str = tostring(str)
    if #str > chars then
        return str:sub(1, chars)
    else
        return str .. string.rep(" ", chars - #str)
    end
end

local function showOptions()
    local file = fs.open("machines.json", "r")
    local jsonStr = file.readAll()
    file.close()

    local data = textutils.unserialiseJSON(jsonStr)

    for i,entry in ipairs(data) do
        term.setCursorPos((term.getSize()[1]-15)/2,4+i)
        term.setTextColour(colours.lime)
        term.write(formatText(entry.name,10))
        if entry.status then
            term.setTextColour(colours.green)
            term.write(" [ON]")
        else
            term.setTextColour(colours.red)
            term.write("[OFF]")
        end
    end
end

showOptions()