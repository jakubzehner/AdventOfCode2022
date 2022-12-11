class Monkey
    @activity = 0
    @items = [] of Int32
    def initialize(@id : Int32, @items, @operator : String, @operation : String, @testVal : Int32, @trueIndex : Int32, @falseIndex : Int32)
    end

    def activity
        @activity
    end

    def addItem(item)
        @items.push(item)
    end

    def inspects
        actions = [] of {Int32, Int32}
        while !@items.empty?
            actions.push(inspect)
        end
        actions
    end

    def inspect
        @activity += 1

        inspected = @items.shift()
        new_inspected = (operation(inspected) / 3).to_i
        next_monkey = test(new_inspected)

        {next_monkey, new_inspected}
    end
        
    def operation(item)
        if @operator == "*"
            if @operation == "old"
                return item * item
            else
                return item * @operation.to_i
            end

        elsif @operator == "+"
            if @operation == "old"
                return item + item
            else
                return item + @operation.to_i
            end
        end
        raise "Incorrect operator or operation"
    end

    def test(item)
        if item % @testVal == 0
            return @trueIndex
        else
            return @falseIndex
        end
    end
end

def buildMonkey(lines)
    id = lines[0][7..].rstrip(':').to_i
    items = lines[1].strip()[16..].split(", ").map{|item| item.to_i}
    operations = lines[2].strip()[21..].split(' ')
    testVal = lines[3].strip()[19..].to_i
    trueIndex = lines[4].strip()[25..].to_i
    falseIndex = lines[5].strip()[26..].to_i

    Monkey.new(id, items, operations[0], operations[1], testVal, trueIndex, falseIndex)
end



def readInput(fileName)
    File.read_lines(fileName).in_groups_of(7, "").map{|lines| buildMonkey(lines)}
end