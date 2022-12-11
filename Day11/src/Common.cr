class Monkey
    @activity = 0
    @lcm = 1
    @items = [] of Int64
    def initialize(@id : Int32, @items, @operator : String, @operation : String, @testVal : Int32, @trueIndex : Int32, @falseIndex : Int32)
    end

    def set_lcm(lcm)
        @lcm = lcm
    end

    def activity
        @activity
    end

    def addItem(item)
        @items.push(item)
    end

    def inspects(stress_divider)
        actions = [] of {Int32, Int64}
        while !@items.empty?
            actions.push(inspect(stress_divider))
        end
        actions
    end

    def inspect(stress_divider)
        @activity += 1

        inspected = @items.shift()
        new_inspected = (operation(inspected) / stress_divider).to_i64
        new_inspected = new_inspected % @lcm
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

    def testVal
        @testVal
    end
end

def buildMonkey(lines)
    id = lines[0][7..].rstrip(':').to_i
    items = lines[1].strip()[16..].split(", ").map{|item| item.to_i64}
    operations = lines[2].strip()[21..].split(' ')
    testVal = lines[3].strip()[19..].to_i
    trueIndex = lines[4].strip()[25..].to_i
    falseIndex = lines[5].strip()[26..].to_i

    Monkey.new(id, items, operations[0], operations[1], testVal, trueIndex, falseIndex)
end

def gcd(a, b)
    if a == 0
        return b
    end
    gcd(b % a, a)
end

def lcmOfArray(arr, idx)
    if idx == arr.size - 1
        return arr[idx]
    end

    a = arr[idx]
    b = lcmOfArray(arr, idx + 1)

    (a * b / gcd(a, b)).to_i
end

def set_lcms(monkeys)
    testVals = monkeys.map{|monkey| monkey.testVal}
    lcm = lcmOfArray(testVals, 0)
    monkeys.each{|monkey| monkey.set_lcm(lcm)}
end

def readInput(fileName)
    monkeys = File.read_lines(fileName).in_groups_of(7, "").map{|lines| buildMonkey(lines)}
    set_lcms(monkeys)
    monkeys
end

def round(monkeys, stress_divider)
    monkeys.each { |monkey|
        monkey.inspects(stress_divider).each { |result| monkeys[result[0]].addItem(result[1]) }
    }
    monkeys
end

def calculateMonkeyBusiness(monkeys)
    monkeyActivities = monkeys.map{|monkey| monkey.activity}
    sorted = monkeyActivities.sort{ |a, b| b <=> a }
    sorted[0].to_i64 * sorted[1].to_i64
end

def monkeyBusinessAfterRounds(monkeys, rounds, stress_divider)
    while rounds > 0
        monkeys = round(monkeys, stress_divider)
        rounds -= 1
    end
    calculateMonkeyBusiness(monkeys)
end
