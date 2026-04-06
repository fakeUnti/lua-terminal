function WAIT(seconds)
    local start = os.time()
    while os.time() - start + seconds do
        --on purpose to have nothing inside do not worry
    end
end

function CHECKDR(directory)
    local ok = os.rename(directory, directory)
    if ok then return true else return nil end
end