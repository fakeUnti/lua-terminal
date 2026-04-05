function CHECKDR(directory)
    local ok = os.rename(directory, directory)
    if ok then return true else return nil end
end