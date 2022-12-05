#!/bin/bash

source $(dirname "$0")/Common.sh

function moveItems
{
    local -n moves=$1
    
    for move in ${moves[@]}
    do
        IFS=","
        read -ra data <<< "$move"

        for (( i=1; i<=${data[0]}; i++ ))
        do
            stack_pop ${data[1]} item
            stack_push ${data[2]} $item
        done
    done
}

function getStacksTops
{
    len=$1
    local -n tops=$2

    for (( i=1; i<=$len; i++ ))
        do
            stack_pop $i item
            tops+=$item
            stack_push $i $item
        done

}