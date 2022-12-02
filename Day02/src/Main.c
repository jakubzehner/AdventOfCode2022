#include <stdio.h>
#include <stdlib.h>

#include "Part1.c"

#define NUMBER_OF_LINES 3
#define NUMBER_OF_CHARS_IN_LINE 2
#define FILE_NAME "../inputs/test.txt"

void readStrategyGuide(char fileName[], char **lines)
{
    FILE *file;
    char *line = NULL;
    size_t len = 0;
    size_t read;
    file = fopen(fileName, "r");
    if (file == NULL)
        exit(EXIT_FAILURE);

    int i = 0;
    while ((read = getline(&line, &len, file)) != -1)
    {
        lines[i][0] = line[0];
        lines[i][1] = line[2];
        i++;
    }

    fclose(file);
    if (line)
        free(line);
}

int main()
{
    char **lines;
    lines = malloc(NUMBER_OF_LINES * sizeof(char*));
    for (int i = 0; i < NUMBER_OF_LINES; i++)
    {
        lines[i] = malloc(NUMBER_OF_CHARS_IN_LINE * sizeof(char));
    }

    readStrategyGuide(FILE_NAME, lines);
    
    //Part1
    printf("%d", getScore(lines, NUMBER_OF_LINES));

    
    for (int i = 0; i < NUMBER_OF_LINES; i++)
    {
        free(lines[i]);
    }
    free(lines);

    return 0;
}