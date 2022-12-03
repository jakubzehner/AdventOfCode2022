module Part1

open Common

let findMax filePath =
    getCaloriesPerElf filePath
    |> List.max