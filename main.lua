require("makedrfile")
require("cmdargs")
require("otherfunctions")
local running = true --useless variable
local arg1 = nil
local tempvar = nil
local useros = "nil"
local sep = package.config:sub(1,1) --getting the file system seperator
if sep == '\\' then
    useros = "windows"
else
    useros = "unix"
end

local function get_home()
  return os.getenv("HOME")                -- unix based systems aka linux mac etc
      or os.getenv("USERPROFILE")         -- windows
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
local isvalid = CHECKDR(directory)

if not isvalid then
    print(directory .. "is not a valid directory, the directory will be set to your home directory")
    directory = home
    file = io.open("startingdir.txt", "w")
    if not file then
        return
    end
    file:write(directory)
    file:close()
end



while running do --actual code // add error codes for functions that can fail 

    if useros == "windows" then
        io.write(directory .. "> ")--the directory thing
    else
         io.write(directory .. "$ ")
    end

    local command = io.read("*l")
    if command:lower() == "exit" then
        running = false
    end

    command, arg1 = FORMAT(command,arg1)
    TEMPVAR = nil

    if command == "cd" then
        directory = arg1
        print(directory)
        goto continue
        
    elseif command == "cdr" then --cd but saves the directory inside of startingdir
        io.open("startingdir.txt", "w"):close()
        file = io.open("startingdir.txt", "w")
        if not file then
            return
        end
        directory = arg1
        file:write(directory)
        file:close()
        goto continue

    elseif command == "dlt" then --sudo rm -rf 
        if arg1 == nil then
            if useros == "windows" then
                os.execute("del " .. directory) 
            else
                os.execute("sudo rm -rf " .. directory)
            end
        else
           if useros == "windows" then
                os.execute("del " .. arg1) 
            else
                os.execute("sudo rm -rf " .. arg1)
            end
        end
    
    elseif command == "ls" then --ls
        if arg1 == nil then
            os.execute("ls " .. directory)
        else
            os.execute("ls " .. arg1)
        end
        goto continue
    
    elseif command == "mf" then --touch / makes file
        if useros == "windows" then
            os.execute("type nul > " .. arg1)
	    else --unix
	        os.execute("touch " .. arg1)
	    end
        goto continue
    
    elseif command == "mkdir" then --mkdir 
        os.execute("cd ".. directory .." &&" .. "mkdir " .. arg1)
        goto continue
    elseif command == "dltapp" then --sudo remove app
        if useros == "unix" then
            os.execute("sudo remove " .. arg1)
        else
            os.execute("Get-AppxPackage ".. arg1 .. " | Remove-AppxPackage") --windows
        end
    end
    
    ::continue::
end