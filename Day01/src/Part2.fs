module Part2

open Common

let getListOfMaxes oldMaxes number =
    let rec getNewListOfMaxes oldMaxes newMaxes number =
        match oldMaxes with
        | [] -> newMaxes
        | h::t when number > h -> getNewListOfMaxes t (number::newMaxes) h
        | h::t -> getNewListOfMaxes t (h::newMaxes) number
    
    getNewListOfMaxes oldMaxes [] number

let findSumOfThreeMax filePath =
    List.sum (List.fold getListOfMaxes [0; 0; 0] (getCaloriesPerElf filePath))
