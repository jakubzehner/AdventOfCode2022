module Part2;

int findViewDistance(ref int[][] trees, int x, int y, int xDiff, int yDiff) {
    auto viewDistance = 0;
    auto size = trees.length;
    auto treeHigh = trees[x][y];

    while (x > 0 && x < size - 1 && y > 0 && y < size - 1) {
        viewDistance++;
        x += xDiff;
        y += yDiff;

        if (trees[x][y] >= treeHigh)
            break;
    }

    return viewDistance;
}

int calculateScenicScore(ref int[][] trees, int x, int y) {
    auto viewUp = findViewDistance(trees, x, y, -1, 0);
    auto viewDown = findViewDistance(trees, x, y, 1, 0);
    auto viewLeft = findViewDistance(trees, x, y, 0, -1);
    auto viewRight = findViewDistance(trees, x, y, 0, 1);

    return viewUp * viewDown * viewLeft * viewRight;
}

int findHighestScenicScore(ref int[][] trees) {
    auto highestScenicScore = 0;
    auto size = trees.length;

    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            auto scenicScore = calculateScenicScore(trees, i, j);
            if (scenicScore > highestScenicScore)
                highestScenicScore = scenicScore;
        }
    }

    return highestScenicScore;
}