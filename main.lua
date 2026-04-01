require("makedrfile")
require("cmdargs")
local running = true --so the terminal ACTUALLY runs
local arg1 = nil
local tempvar = nil
local useros = "nil"
local sep = package.config:sub(1,1)
if sep == '\\' then
    useros = "windows"
else
    useros = "unix"
end

local function get_home()
  return os.getenv("HOME")                -- Unix/macOS
      or os.getenv("USERPROFILE")         -- Windows
end

local home = get_home()


local file = io.open("startingdir.txt", "r") --filename

if not file then --if the file doesnt exist
    MAKEDRFILE(useros,home)
end --time for the REAL code


file = io.open("startingdir.txt","r")
if not file then
    return
end
local directory = file:read("*l")
file:close()

while running do --ACTUAL CODE

    if useros == "windows" then
        io.write(directory .. "> ")--the directory thing
    else
         io.write(directory .. "$ ")
    end

    local command = io.read("*l")
    if command:lower() == "exit" then
        running = false
    end

    command, arg1 = FORMAT(command,arg1,tempvar)
    tempvar = nil

    if command == "cd" then
        directory = arg1

    elseif command == "cdr" then --cd but saves the directory inside of startingdir
        io.open("startingdir.txt", "w"):close()
        file = io.open("startingdir.txt", "w")
        if not file then
            return
        end
        directory = arg1
        file:write(directory)
        file:close()

    elseif command == "dlt" then --delete cmd
        if useros == "windows" then -- SUPPORT ARG1 ADD LATER
           os.execute("del " .. directory) 
        else
            os.execute("sudo rm " .. directory)
        end

    elseif command == "ls" then --list command
        if arg1 == nil then
            os.execute("ls " .. directory)
        else
            os.execute("ls " .. arg1)
        end
    end

end