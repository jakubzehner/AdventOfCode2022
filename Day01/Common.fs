module Common

let readLines filePath =
    System.IO.File.ReadLines(filePath)

let getCaloriesPerElf filePath =
    let rec mapCalories lines result elfCalories =
        match lines with
        | [] -> result
        | ""::t -> mapCalories t (elfCalories::result) 0
        | calories::t -> mapCalories t result (elfCalories + (calories |> int))

    mapCalories (List.ofSeq (readLines filePath)) [] 0