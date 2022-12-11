class Monkey
  @activity = 0
  @lcm = 1
  @items = [] of Int64

  setter lcm
  getter activity
  getter testVal

  def initialize(@items, @operator : String, @operation : String, @testVal : Int32, @trueIndex : Int32, @falseIndex : Int32)
  end

  def addItem(item)
    @items.push(item)
  end

  def inspects(stress_divider)
    @items.size.times.map { inspect(stress_divider) }
  end

  def inspect(stress_divider)
    @activity += 1

    inspected = @items.shift
    new_inspected = (operation(inspected) / stress_divider).to_i64 % @lcm
    next_monkey = test(new_inspected)

    {next_monkey, new_inspected}
  end

  def operation(item)
    number = @operation == "old" ? item : @operation.to_i
    @operator == "*" ? item * number : item + number
  end

  def test(item)
    item % @testVal == 0 ? @trueIndex : @falseIndex
  end
end

def buildMonkey(lines)
  items = lines[1].strip[16..].split(", ").map { |item| item.to_i64 }
  operations = lines[2].strip[21..].split(' ')
  testVal = lines[3].strip[19..].to_i
  trueIndex = lines[4].strip[25..].to_i
  falseIndex = lines[5].strip[26..].to_i

  Monkey.new(items, operations[0], operations[1], testVal, trueIndex, falseIndex)
end

def set_lcms(monkeys)
  monkeys.each { |monkey|
    monkey.lcm = monkeys.map { |monkey| monkey.testVal }.reduce { |acc, val| acc.lcm(val) }
  }
end

def readInput(fileName)
  monkeys = File.read_lines(fileName)
    .in_groups_of(7, "")
    .map { |lines| buildMonkey(lines) }
  set_lcms(monkeys)
  monkeys
end

def round(monkeys, stress_divider)
  monkeys.each { |monkey|
    monkey.inspects(stress_divider).each { |result|
      monkeys[result[0]].addItem(result[1])
    }
  }
end

def calculateMonkeyBusiness(monkeys)
  monkeys.map { |monkey| monkey.activity.to_i64 }
    .sort { |a, b| b <=> a }
    .first(2)
    .product
end

def monkeyBusinessAfterRounds(monkeys, rounds, stress_divider)
  rounds.times { round(monkeys, stress_divider) }
  calculateMonkeyBusiness(monkeys)
end
