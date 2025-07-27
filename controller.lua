local selected = 1

local file = fs.open("machines.json", "r")
local jsonStr = file.readAll()
file.close()

local data = textutils.unserialiseJSON(jsonStr)

local count = #data

local function wrap(input, min,max)
    if input < min then
        return max
    elseif input > max then
        return min
    else
        return input
    end
end

wrap(1,2,3)

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

    term.clear()
    for i,entry in ipairs(data) do
        if entry.name == "AUTO" then
            term.setCursorPos((term.getSize()-15)/2,5+i)
            term.setTextColour(colours.white)
            term.write((i==selected and ">" or " ")..formatText(entry.name,10))
            if entry.status then
                term.setTextColour(colours.green)
                term.write(" [ON]")
            else
                term.setTextColour(colours.red)
                term.write("[OFF]")
            end
        else
            term.setCursorPos((term.getSize()-15)/2,4+i)
            term.setTextColour(colours.lime)
            term.write((i==selected and ">" or " ")..formatText(entry.name,10))
            if entry.status then
                term.setTextColour(colours.green)
                term.write(" [ON]")
            else
                term.setTextColour(colours.red)
                term.write("[OFF]")
            end
        end
        
    end
end

showOptions()

while true do
    local event, key, isHeld = os.pullEvent("key")
    if key == keys.w or key == keys.up then
        selected = wrap(selected - 1,1,count)
    elseif key == keys.s or key == keys.down then
        selected = wrap(selected + 1, 1, count)
    elseif key == keys.enter or key == keys.space then
        local file = fs.open("machines.json", "r")
        local jsonStr = file.readAll()
        file.close()

        local data = textutils.unserialiseJSON(jsonStr)

        data[selected].status = not data[selected].status

        local file = fs.open("machines.json", "w")
        file.write(textutils.serialiseJSON(data))
        file.close()
    end
    showOptions()
    if isHeld then
        sleep()
    end
end