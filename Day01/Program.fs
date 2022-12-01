open Part1
open Part2

let input = "input.txt"

[<EntryPoint>]
let main argv = 
    printfn "%d" (Part1.findMax input)
    0