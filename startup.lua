--shell.run("delete input.lua")
--shell.run("delete output.lua")

if fs.exists("displayB.lua") then
    shell.run("delete display.lua")
    shell.run("rename displayB.lua display.lua")
end

--[[if fs.exists("outputB.lua") then
    shell.run("delete output.lua")
    shell.run("rename outputB.lua output.lua")
end]]

if fs.exists("display.lua") then
    local input = multishell.launch({}, "display.lua")
    multishell.setTitle(input, "")
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
    --shell.run("wget https://raw.githubusercontent.com/DeactivatedMan/CC-Storage/refs/heads/main/output.lua outputB.lua") -- Downloads output script
    write("Updated! (Or did absolutely nothing other than reset the files..)\nrun 'reboot' to initialise\n")
end