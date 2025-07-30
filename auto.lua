local prevTick = os.clock()
local delay = 1200 -- seconds between ticks
local rotaryTimer = 120 -- seconds which any rotary farm stays on for

local file = fs.open("machines.json", "r")
local jsonStr = file.readAll()
file.close()

local data = textutils.unserialiseJSON(jsonStr)

local function toggleRelay(relay, status)
    local relay = peripheral.wrap("redstone_relay_"..relay)
    if (relay.getInput("left") and not status) or (relay.getInput("left") == 0 and status) then
        relay.setOutput("right", true)
        sleep(.1)
        relay.setOutput("right", false)
    end
end

local function saveData()
    local file = fs.open("machines.json", "w")
    file.write(textutils.serialiseJSON(data))
    file.close()
end

for _,entry in ipairs(data) do
    if entry.name == "Iron" or entry.name == "Thorium" or entry.name == "Fuel" then
        entry.status = true
        saveData()
        toggleRelay(entry.relay, entry.status)
    elseif entry.name == "AUTO" then
        toggleRelay(entry.relay, entry.status)
    end
end

while fs.exists("runAuto") do
    -- This will have to be tweaked per person for their own use cases
    if os.clock() < prevTick or prevTick+delay <= os.clock() then
        prevTick = os.clock()

        for _,entry in ipairs(data) do
            if entry.name == "Tree" or entry.name == "Cow" or entry.name == "Wheat" or entry.name == "Flax" then
                entry.status = true
                saveData()
                toggleRelay(entry.relay, entry.status)

                sleep(120)
                entry.status = false
                saveData()
                toggleRelay(entry.relay, entry.status)
            end
        end
    end
    sleep( (prevTick+delay)-os.clock() )
end

for _,entry in ipairs(data) do
    if entry.name == "AUTO" then
        toggleRelay(entry.relay, entry.status)
    end
end