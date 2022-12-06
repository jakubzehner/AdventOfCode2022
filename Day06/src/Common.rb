require 'set'

def readInput(fileName)
    File.open(fileName) do |file|
        data = file.read.scan(/\w/)
        return data
    end
end

def findStartMarkerPosition(input, sequence_length)
    for i in (sequence_length)..(input.size)
        uniqueChars = Set.new(input.slice(i - sequence_length, sequence_length))
        return i if uniqueChars.size == sequence_length
    end
    return -1
end