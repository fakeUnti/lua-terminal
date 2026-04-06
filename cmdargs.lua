function FORMAT(command,arg1) --ADD SUPPORT FOR MULTI ARGUMENT COMMANDS 
    local hasspace = string.find(command, " ")
    if hasspace then
        for i = 1, #command do
            if command:sub(i,i) == " " then
                arg1 = string.sub(command, i + 1)
                TEMPVAR = i
                break
            end
        end 
        command = command:sub(1,TEMPVAR - 1)
        return command, arg1
    else
        return command, nil
    end
end