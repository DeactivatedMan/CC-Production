if fs.exists("displayB.lua") then
    shell.run("delete display.lua")
    shell.run("rename displayB.lua display.lua")
end

if fs.exists("controllerB.lua") then
    shell.run("delete controller.lua")
    shell.run("rename controllerB.lua controller.lua")
end

if fs.exists("machinesB.json") then
    shell.run("delete machines.json")
    shell.run("rename machinesB.json machines.json")
end


if fs.exists("display.lua") then
    local input = multishell.launch({}, "display.lua")
    multishell.setTitle(input, "")
end

if fs.exists("controller.lua") then
    local input = multishell.launch({}, "controller.lua")
    multishell.setTitle(input, "Controller")
end

--[[if fs.exists("output.lua") then
    local output = multishell.launch({}, "output.lua")
    multishell.setTitle(output, "Output")
    multishell.setFocus(output)
end]]

write("Attempt update? Y // N\n > ")
local yn = string.lower(read())

if string.find(yn, "y") then
    shell.run("wget https://raw.githubusercontent.com/DeactivatedMan/CC-Production/refs/heads/main/display.lua displayB.lua")  -- Downloads display script
    shell.run("wget https://raw.githubusercontent.com/DeactivatedMan/CC-Production/refs/heads/main/controller.lua controllerB.lua")  -- Downloads controller script
    shell.run("wget https://raw.githubusercontent.com/DeactivatedMan/CC-Production/refs/heads/main/machines.json machinesB.json")  -- Downloads machines json
    write("Updated! (Or did absolutely nothing other than reset the files..)\nrun 'reboot' to initialise\n")
end