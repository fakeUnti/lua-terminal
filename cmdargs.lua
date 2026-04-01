function FORMAT(command,arg1,tempvar) 
    for i = 1, #command do
        if command:sub(i,i) == " " then
            arg1 = string.sub(command, i + 1)
            tempvar = i
            break
        end
    end    
    command = command:sub(1,tempvar - 1)
    return command,arg1
end