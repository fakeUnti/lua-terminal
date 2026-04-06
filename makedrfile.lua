require("otherfunctions")
function MAKEDRFILE(useros,home)
    print("no directory file found!\n do you want to make one? [Y/N]")
    if io.read("*l"):sub(1,1):lower() == "y" then
        if useros == "windows" then
           os.execute("type nul > startingdir.txt")--windows makes file
        else
            local script_dir = arg[0]:match("(.*/)") or "./" --i know this looks scary but its not dw it just detects where the file is run
            os.execute("touch " .. script_dir .. "startingdir.txt") --unix makes file
        end
        local file = io.open("startingdir.txt", "w") --opens
        if not file then
            return
        else
            file:write(home)--writes
        end
        file:close() --closes
        print("file created!")
    else 
        print("disclaimer: you will not be able to use the program if there is no directory file")
        WAIT(2)
        return
    end
end
--code in here is a *little* messy but its generally fine since this files practically useless 