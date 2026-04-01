function MAKEDRFILE(useros,home)
    print("no directory file found!\n do you want to make one? [Y/N]")
    if io.read("*l"):sub(1,1):lower() == "y" then
        if useros == "windows" then
           os.execute("type nul > startingdir.txt")--makes file windows
        else
            local script_dir = arg[0]:match("(.*/)") or "./"
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
        return
    end
end