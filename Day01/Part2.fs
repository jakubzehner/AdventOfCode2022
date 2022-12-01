module Part2

open Common

let getListOfMaxes number oldMaxes =
    let rec getNewListOfMaxes oldMaxes newMaxes number =
        match oldMaxes with
        | [] -> newMaxes
        | h::t when number > h -> getNewListOfMaxes t (number::newMaxes) h
        | h::t -> getNewListOfMaxes t (h::newMaxes) number
    
    getNewListOfMaxes oldMaxes [] number

let findSumOfThreeMax filePath = 
    let rec findThreeMax maxes calories =
        match calories with
        | [] -> maxes
        | h::t -> findThreeMax (getListOfMaxes h maxes) t

    List.sum (findThreeMax [0; 0; 0] (getCaloriesPerElf filePath))
