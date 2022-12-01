module Part1

open Common

let findMax filePath =
    List.max (getCaloriesPerElf filePath)