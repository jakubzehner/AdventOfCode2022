#!/bin/bash

source $(dirname "$0")/Stack.sh

function read_input {
    input=$1
    local -n moves=$2
    local -n length=$3
    
    first_line=1
    building_stacks=1
    first_moves_line=1
    
    while IFS= read -r line
    do
        # create stacks
        if [ $first_line -eq 1 ]
        then
            length=${#line}
            length=$((length / 4))
            
            for (( i=1; i<=$length; i++ ))
            do
                stack_new $i
                stack_new $((i+length))
            done
            first_line=0
        fi
        
        # add elems to stacks
        if [ $building_stacks -eq 1 ]
        then
            # check if still building stacks
            if [[ "$line" != *"["* ]]
            then
                building_stacks=0
                continue
            fi
            
            for (( i=1; i<=$length; i++ ))
            do
                idx=$(((i-1) * 4 + 1))
                char=${line:$idx:1}
                
                if [ "$char" != " " ]
                then
                    stack_push $((i+length)) $char
                fi
            done
            
            continue
        fi
        
        # create array and skip empty line
        if [ $first_moves_line -eq 1 ]
        then
            moves=()
            first_moves_line=0
            continue
        fi
        
        # add moves to array
        [[ ${line:6:1} == " " ]] && offset=0 || offset=1
        
        firstN=${line:5:$((1 + $offset))}
        secondN=${line:$((12 + $offset)):1}
        thirdN=${line:$((17 + $offset)):1}
        
        moves+=("$firstN,$secondN,$thirdN")
        
    done < "$input"
    
    # reverse stacks
    for (( i=1; i<=$length; i++ ))
    do
        stack_size $((i+length)) size
        for (( j=1; j<=$size; j++ ))
        do
            stack_pop $((i+length)) poped_elem
            stack_push $i $poped_elem
        done
    done
}
