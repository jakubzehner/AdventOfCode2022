import std.stdio;

import Common;
import Part1;
import Part2;

auto FILE_NAME = "../inputs/test.txt";

void main()
{
    auto trees = readIntoArray(FILE_NAME);
    writeln(countVisibleTrees(trees));
    writeln(findHighestScenicScore(trees));
}