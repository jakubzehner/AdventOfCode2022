﻿module Part2

open Common

let getListOfMaxes oldMaxes number =
    let rec getNewListOfMaxes oldMaxes newMaxes number =
        match oldMaxes with
        | [] -> newMaxes
        | h::t when number > h -> getNewListOfMaxes t (number::newMaxes) h
        | h::t -> getNewListOfMaxes t (h::newMaxes) number
    
    getNewListOfMaxes oldMaxes [] number

let findSumOfThreeMax filePath = 
    let rec findThreeMax current maxes lines =
        match lines with
        | [] -> maxes
        | ""::t -> findThreeMax 0 (getListOfMaxes maxes current) t
        | number::t -> findThreeMax (current + (number |> int)) maxes t

    List.sum (findThreeMax 0 [ 0; 0; 0 ] (List.ofSeq (readLines filePath)))