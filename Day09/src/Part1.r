move_tail <- function(tail, head) {
    if (abs(tail[1] - head[1]) < 2 && abs(tail[2] - head[2]) < 2) {
        return(tail)
    }

    if (abs(tail[1] - head[1]) != 0) {
        if (tail[1] < head[1]) {
            tail[1] <- tail[1] + 1
        } else {
            tail[1] <- tail[1] - 1
        }
    }
    if (abs(tail[2] - head[2]) != 0) {
        if (tail[2] < head[2]) {
            tail[2] <- tail[2] + 1
        } else {
            tail[2] <- tail[2] - 1
        }
    }

    return(tail)
}

count_tail_positions <- function(motions) {
    head <- c(0, 0)
    tail <- c(0, 0)

    tail_positions <- c(list(tail))

    for (motion in motions) {
        if (motion == "R") {
            head[1] <- head[1] + 1
        } else if (motion == "L") {
            head[1] <- head[1] - 1
        } else if (motion == "U") {
            head[2] <- head[2] + 1
        } else {
            head[2] <- head[2] - 1
        }
        tail <- move_tail(tail, head)
        tail_positions <- append(tail_positions, list(tail))
    }
    return(length(unique(tail_positions)))
}
