//#include <stdio.h>

int getResult(char enemyShape, char yourShape)
{
    if ((enemyShape == 'A' && yourShape == 'Y') || (enemyShape == 'B' && yourShape == 'Z') || (enemyShape == 'C' && yourShape == 'X'))
    {
        return 2;
    }
    else if ((enemyShape == 'A' && yourShape == 'Z') || (enemyShape == 'B' && yourShape == 'X') || (enemyShape == 'C' && yourShape == 'Y'))
    {
        return 0;
    }
    else
    {
        return 1;
    }
}

int getPointsForResult(int result)
{
    return result * 3;
}

int getPointsForShape(char shape)
{
    return ((int)shape) - 87;
}

int getScore(char **lines, int strategyLength)
{
    int points = 0;

    for (int i = 0; i < strategyLength; i++)
    {
        points += getPointsForResult(getResult(lines[i][0], lines[i][1]));
        points += getPointsForShape(lines[i][1]);
    }

    return points;
}