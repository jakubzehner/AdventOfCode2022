#!/bin/bash

source $(dirname "$0")/Common.sh

function moveFewItemsAtOnce
{
    local -n moves=$1

    stack_new helper
    
    for move in ${moves[@]}
    do
        IFS=","
        read -ra data <<< "$move"
        IFS=

        for (( i=1; i<=${data[0]}; i++ ))
        do
            stack_pop ${data[1]} item
            stack_push helper $item
        done

        for (( i=1; i<=${data[0]}; i++ ))
        do
            stack_pop helper item
            stack_push ${data[2]} $item
        done

    done
}
