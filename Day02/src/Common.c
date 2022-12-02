#ifndef COMMON
#define COMMON

enum Shape
{
    Rock = 0,
    Paper = 1,
    Scissor = 2
};

int getPointsForResult(enum Shape enemyShape, enum Shape yourShape)
{
    int difference = ((int)enemyShape - (int)yourShape + 3) % 3;

    switch (difference)
    {
    case 0:
        return 3;
    case 1:
        return 0;
    case 2:
        return 6;
    }
}

int getPointsForShape(enum Shape shape)
{
    return (int)shape + 1;
}

#endif // COMMON