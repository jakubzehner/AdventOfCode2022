open Part1
open Part2

let input = "inputs/test.txt"

[<EntryPoint>]
let main argv = 
    printfn "%d" (findMax input)
    printfn "%d" (findSumOfThreeMax input)
    0