let signalStrengthsSum = (values, cycles) => {
    let rec calculate = (values, cycle, sum) => {
        switch(values, cycle){
        | ([value, ...t], cycle) when List.mem(cycle, cycles) => calculate(t, cycle + 1, sum + (value * cycle))
        | ([value, ...t], cycle) => calculate(t, cycle + 1, sum)
        | ([], _) => sum
        }
    }
    calculate(values, 1, 0);
};