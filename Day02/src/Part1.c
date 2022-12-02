#include "Common.c"

enum Shape getShape(char codedShape)
{
    switch (codedShape)
    {
    case 'A':
        return Rock;
    case 'B':
        return Paper;
    case 'C':
        return Scissor;
    case 'X':
        return Rock;
    case 'Y':
        return Paper;
    case 'Z':
        return Scissor;
    }
}

int getScore1(char **lines, int strategyLength)
{
    int points = 0;

    for (int i = 0; i < strategyLength; i++)
    {
        enum Shape enemyShape = getShape(lines[i][0]);
        enum Shape yourShape = getShape(lines[i][1]);

        points += getPointsForResult(enemyShape, yourShape);
        points += getPointsForShape(yourShape);
    }

    return points;
}