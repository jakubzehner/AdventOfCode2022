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
    return (((int)yourShape - (int)enemyShape + 4) % 3) * 3;
}

int getPointsForShape(enum Shape shape)
{
    return (int)shape + 1;
}

#endif // COMMON