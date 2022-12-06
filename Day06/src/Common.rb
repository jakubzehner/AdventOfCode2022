def readInput(fileName)
    file = File.open(fileName)
    data = (file.read).scan /\w/
    file.close

    return data
end