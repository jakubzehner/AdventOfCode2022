#!/bin/bash

source $(dirname "$0")/Common.sh

function moveItemsOneByOne
{
    local -n moves=$1

    for move in ${moves[@]}
    do
        IFS=","
        read -ra data <<< "$move"
        IFS=

        for (( i=1; i<=${data[0]}; i++ ))
        do
            stack_pop ${data[1]} item
            stack_push ${data[2]} $item
        done
    done
}
