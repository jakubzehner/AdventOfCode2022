let input = "input.txt"

let readLines filePath =
    System.IO.File.ReadLines(filePath)

let findMax filePath =
    let rec findMaxRec current maxNumber lines =
        match lines with
        | [] -> maxNumber
        | ""::t -> findMaxRec 0 (max current maxNumber) t
        | number::t -> findMaxRec (current + (number |> int)) maxNumber t

    findMaxRec 0 0 (List.ofSeq (readLines filePath))

[<EntryPoint>]
let main argv = 
    printfn "%d" (findMax input)
    0