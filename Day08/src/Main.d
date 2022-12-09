import std.stdio;

import Common;
import Part1;

auto FILE_NAME = "../inputs/test.txt";

void main()
{
    auto trees = readIntoArray(FILE_NAME);
    writeln(countVisibleTrees(trees));
}