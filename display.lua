local stresso = peripheral.find("Create_Stressometer")
local monitor = peripheral.find("monitor")

local function formatNumber(num, chars)
    return string.format("%"..tostring(chars).."d", tostring(num))
end

local function showDisplay()
    local stress = stresso.getStress()
    local capacity = stresso.getStressCapacity()
    local left = capacity-stress

    monitor.clear()
    monitor.setTextScale(2)

    monitor.setCursorPos(1,1)
    if stress < 0.5 * capacity then
        monitor.setTextColour(colours.green)
    elseif stress >= 0.5 * capacity and stress < 0.75 * capacity then
        monitor.setTextColour(colours.yellow)
    elseif stress >= 0.75 * capacity and stress < 0.85 * capacity then
        monitor.setTextColour(colours.orange)
    else
        monitor.setTextColour(colours.red)
    end
    monitor.write("Used:"..formatNumber(stress,7).."su")

    monitor.setCursorPos(1,2)
    if capacity > 32768 then
        monitor.setTextColour(colours.green)
    elseif capacity >= 32768 and capacity < 16384 then
        monitor.setTextColour(colours.yellow)
    elseif capacity >= 16384 and capacity < 8192 then
        monitor.setTextColour(colours.orange)
    else
        monitor.setTextColour(colours.red)
    end
    monitor.write("Max:"..formatNumber(capacity,7).."su")

    monitor.setCursorPos(1,3)
    if left > 16384 then
        monitor.setTextColour(colours.green)
    elseif left <= 16384 and left > 8192 then
        monitor.setTextColour(colours.yellow)
    elseif left <= 8192 and left > 4096 then
        monitor.setTextColour(colours.orange)
    else
        monitor.setTextColour(colours.red)
    end
    monitor.write("Left:"..formatNumber(left, 7).."su")
end

showDisplay()