#include "Common.c"

enum Shape getEnemyShape(char codedEnemyShape)
{
    switch (codedEnemyShape)
    {
    case 'A':
        return Rock;
    case 'B':
        return Paper;
    case 'C':
        return Scissor;
    }
}

enum Shape getYourShape(enum Shape enemyShape, char codedYourShape)
{
    int enemyShapeValue = (int) enemyShape;

    switch (codedYourShape)
    {
    case 'Y':
        return enemyShape;
    case 'Z':
        return (enum Shape) ((enemyShapeValue + 1) % 3);
    case 'X':
        return (enum Shape) ((enemyShapeValue + 2) % 3);
    }
}

int getScore2(char **lines, int strategyLength)
{
    int points = 0;

    for (int i = 0; i < strategyLength; i++)
    {
        enum Shape enemyShape = getEnemyShape(lines[i][0]);
        enum Shape yourShape = getYourShape(enemyShape, lines[i][1]);

        points += getPointsForResult(enemyShape, yourShape);
        points += getPointsForShape(yourShape);
    }

    return points;
}