move_tail <- function(tail, head) {
    if ((abs(tail[1] - head[1]) < 2) && (abs(tail[2] - head[2]) < 2)) {
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

count_long_tail_positions <- function(motions) {
    n_knots <- 10
    knots <- list()

    for (i in 1:n_knots) {
        knots[[i]] <- c(0, 0)
    }

    tail_positions <- c(list(knots[[n_knots]]))

    for (motion in motions) {
        if (motion == "R") {
            knots[[1]][1] <- knots[[1]][1] + 1
        } else if (motion == "L") {
            knots[[1]][1] <- knots[[1]][1] - 1
        } else if (motion == "U") {
            knots[[1]][2] <- knots[[1]][2] + 1
        } else {
            knots[[1]][2] <- knots[[1]][2] - 1
        }
        for (i in 2:n_knots) {
            knots[[i]] <- move_tail(knots[[i]], knots[[i - 1]])
        }
        tail_positions <- append(tail_positions, list(knots[[n_knots]]))
    }
    return(length(unique(tail_positions)))
}
