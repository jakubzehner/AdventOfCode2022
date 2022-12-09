module Part1;

import std.stdio;
import std.typecons;

alias Unit = void[0];
enum unit = Unit.init;

int countVisibleTrees(ref int[][] trees) {
    alias Tree = Tuple!(int, "x", int, "y");
    Unit[Tree] treeSet;
    auto size = trees.length;

    for(auto i = 0; i < size; i++) {
        auto maxFromLeft = -1;
        auto maxFromRight = -1;

        for(int j = 0; j < size; j++) {
            if (trees[i][j] > maxFromLeft){
                maxFromLeft = trees[i][j];
                treeSet[Tree(i, j)] = unit;
            }
        }
        for(int j = size - 1; j >= 0; j--) {
            if (trees[i][j] > maxFromRight){
                maxFromRight = trees[i][j];
                treeSet[Tree(i, j)] = unit;
            }
        }
    }

    for(auto j = 0; j < size; j++) {
        auto maxFromTop = -1;
        auto maxFromBottom = -1;

        for(int i = 0; i < size; i++) {
            if (trees[i][j] > maxFromTop) {
                maxFromTop = trees[i][j];
                treeSet[Tree(i, j)] = unit;
            }
        }
        for(int i = size - 1; i >= 0; i--) {
            if (trees[i][j] > maxFromBottom) {
                maxFromBottom = trees[i][j];
                treeSet[Tree(i, j)] = unit;
            }
        }
    }

    return treeSet.length;
}