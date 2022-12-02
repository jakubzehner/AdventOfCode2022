#ifndef COMMON
#define COMMON

enum Shape
{
    Rock = 1,
    Paper = 2,
    Scissor = 3
};

int getPointsForResult(enum Shape enemyShape, enum Shape yourShape)
{
    int difference = (int)enemyShape - (int)yourShape;

    if (difference == 0)
    {
        return 3;
    }
    else if (difference == -1 || difference == 2)
    {
        return 6;
    }
    else
    {
        return 0;
    }
}

int getPointsForShape(enum Shape shape)
{
    return (int)shape;
}

#endif // COMMON