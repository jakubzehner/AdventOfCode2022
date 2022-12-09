read_input <- function(file_name) {
    result <- c()
    file <- file(file_name, "r")

    while (TRUE) {
        line <- readLines(file, n = 1)
        if (length(line) == 0) {
            break
        }

        splitted_line <- c(strsplit(line, " +")[[1]])
        result <- append(
            result,
            rep(splitted_line[1], as.numeric(splitted_line[2]))
        )
    }

    close(file)
    return(result)
}

move_knot <- function(knot, prev_knot) {
    if ((abs(knot[1] - prev_knot[1]) < 2) &&
        (abs(knot[2] - prev_knot[2]) < 2)) {
        return(knot)
    }

    if (abs(knot[1] - prev_knot[1]) != 0) {
        if (knot[1] < prev_knot[1]) {
            knot[1] <- knot[1] + 1
        } else {
            knot[1] <- knot[1] - 1
        }
    }
    if (abs(knot[2] - prev_knot[2]) != 0) {
        if (knot[2] < prev_knot[2]) {
            knot[2] <- knot[2] + 1
        } else {
            knot[2] <- knot[2] - 1
        }
    }

    return(knot)
}

count_tail_positions <- function(motions, knots_number) {
    knots <- list()

    for (i in 1:knots_number) {
        knots[[i]] <- c(0, 0)
    }

    tail_positions <- c(list(knots[[knots_number]]))

    for (motion in motions) {
        knots[[1]] <- switch(motion,
            R = {
                c(knots[[1]][1] + 1, knots[[1]][2])
            },
            L = {
                c(knots[[1]][1] - 1, knots[[1]][2])
            },
            U = {
                c(knots[[1]][1], knots[[1]][2] + 1)
            },
            D = {
                c(knots[[1]][1], knots[[1]][2] - 1)
            }
        )

        for (i in 2:knots_number) {
            knots[[i]] <- move_knot(knots[[i]], knots[[i - 1]])
        }
        tail_positions <- append(tail_positions, list(knots[[knots_number]]))
    }
    return(length(unique(tail_positions)))
}
