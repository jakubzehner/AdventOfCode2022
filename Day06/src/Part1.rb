require 'set'

def findStartMarkerPosition(input, sequence_length)
    for i in (sequence_length)..(input.size)
        uniqueChars = Set.new(input.slice(i - sequence_length, sequence_length))
        if uniqueChars.size == sequence_length
            return i
        end
    end
    return -1
end