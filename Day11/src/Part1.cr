require "./Common"

def round(monkeys)
    monkeys.each { |monkey|
        monkey.inspects.each { |result| monkeys[result[0]].addItem(result[1]) }
    }
    monkeys
end

def calculateMonkeyBusiness(monkeys)
    monkeyActivities = monkeys.map{|monkey| monkey.activity}
    sorted = monkeyActivities.sort{ |a, b| b <=> a }
    sorted[0] * sorted[1]
end

def monkeyBusinessAfterRounds(monkeys, rounds)
    while rounds > 0
        monkeys = round(monkeys)
        rounds -= 1
    end
    calculateMonkeyBusiness(monkeys)
end
