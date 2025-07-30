local function readWithTimeout(timeout, default)
    --term.write("> ")
    local input = ""
    local timer = os.startTimer(timeout)

    while true do
        local event, p1 = os.pullEvent()

        if event == "char" then
            input = input .. p1
            term.write(p1)
        elseif event == "key" and p1 == keys.backspace then
            input = input:sub(1, -2)
            local y = term.getCursorPos()[2]
            term.clearLine()
            term.setCursorPos(1,y)
            term.write(input)
        elseif event == "key" and p1 == keys.enter then
            print()
            return input -- User pressed Enter
        elseif event == "timer" and p1 == timer then
            print("\n[Timeout]")
            return default -- Timeout occurred
        end
    end
end

local branch = settings.get("branch.setting", "main")

-- Checks if first install and downloads files
if not fs.exists("startup.lua") then
    local branch = readWithTimeout(10, "main")
    settings.define("branch.setting", {
        description = "Which branch CC-Production is using",
        default = "main",
        type = "string"
    })
    settings.set("branch.setting", branch)
    shell.run("wget https://raw.githubusercontent.com/DeactivatedMan/CC-Production/refs/heads/"..branch.."/startup.lua")
end

if not fs.exists("machines.json") then
    local file = fs.open("machines.json", "w")
    file.write("{}")
    file.close()
end

if not fs.exists("display.lua") then
    shell.run("wget https://raw.githubusercontent.com/DeactivatedMan/CC-Production/refs/heads/" .. branch .. "/display.lua")
end

if not fs.exists("controller.lua") then
    shell.run("wget https://raw.githubusercontent.com/DeactivatedMan/CC-Production/refs/heads/" .. branch .. "/controller.lua")
end

if not fs.exists("auto.lua") then
    shell.run("wget https://raw.githubusercontent.com/DeactivatedMan/CC-Production/refs/heads/" .. branch .. "/auto.lua")
end

-- Executes main scripts
if fs.exists("display.lua") then
    shell.openTab("display")
end

if fs.exists("controller.lua") then
    shell.openTab("controller")
end

-- Asks end user if they wish to update
write("Attempt update? Y // N\n > ")
local yn = string.lower(readWithTimeout(15, ""))
if string.find(yn, "y") then
    shell.run("wget https://raw.githubusercontent.com/DeactivatedMan/CC-Production/refs/heads/" .. branch .. "/startup.lua")
    fs.delete("display.lua")
    fs.delete("controller.lua")

    write("\nUpdate complete! Restarting CC-Production.\n")

    shell.run("reboot")
end