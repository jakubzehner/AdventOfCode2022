module Part1

open Common

let findMax filePath =
    let rec findMaxRec current maxNumber lines =
        match lines with
        | [] -> maxNumber
        | ""::t -> findMaxRec 0 (max current maxNumber) t
        | number::t -> findMaxRec (current + (number |> int)) maxNumber t

    findMaxRec 0 0 (List.ofSeq (readLines filePath))