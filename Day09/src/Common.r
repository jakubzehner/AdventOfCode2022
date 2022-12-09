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
