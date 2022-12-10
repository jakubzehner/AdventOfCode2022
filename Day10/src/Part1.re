let signalStrengthsSum = (operations: list(Common.operation), cycles: list(int)) => {
    let rec calculate = (operations: list(Common.operation), cycle: int, value: int, sum: int) => {
        switch(operations, cycle){
        | ([Noop, ...t], c) when List.mem(c + 1, cycles) => calculate(t, c + 1, value, sum + (value * (c + 1)))
        | ([Noop, ...t], c) => calculate(t, c + 1, value, sum)
        | ([Addx(n), ...t], c) when List.mem(c + 2, cycles) => calculate(t, c + 2, value + n, sum + ((value + n) * (c + 2)))
        | ([Addx(n), ...t], c) when List.mem(c + 1, cycles) => calculate(t, c + 2, value + n, sum + (value * (c + 1)))
        | ([Addx(n), ...t], c) => calculate(t, c + 2, value + n, sum)
        | (_, _) => sum
        }
    }
    calculate(operations, 1, 1, 0);
};