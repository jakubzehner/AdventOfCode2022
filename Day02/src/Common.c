#ifndef COMMON
#define COMMON

#define NUMBER_OF_SHAPES 3
#define RESULT_POINTS_MULTIPLIER 3

enum Shape
{
    Rock = 0,
    Paper = 1,
    Scissor = 2
};

int getPointsForResult(enum Shape enemyShape, enum Shape yourShape)
{
    return (((int)yourShape - (int)enemyShape + NUMBER_OF_SHAPES + 1) % NUMBER_OF_SHAPES) * RESULT_POINTS_MULTIPLIER;
}

int getPointsForShape(enum Shape shape)
{
    return (int)shape + 1;
}

#endif // COMMON