#include <iostream>

int main()
{
    int rows, cols, minWidth, maxWidth;
    std::cin >> rows >> cols >> minWidth >> maxWidth;

    char c;

    // how many white/black fields are in each column
    int whiteCounter[1002];
    int blackCounter[1002];

    for (int col = 1; col <= cols; col++) 
    {
        whiteCounter[col] = blackCounter[col] = 0;
    }

    for (int row = 0; row < rows; row++)
    {
        for (int col = 0; col < cols; col++)
        {
            std::cin >> c;
            if (c == '.')
            {
                whiteCounter[col]++;
            }
            else
            {
                blackCounter[col]++;
            }
        }
        
    }
    
    // costs of going always white or always black from column c1 to column c2
    int whitePartialSum[1002];
    int blackPartialSum[1002];

    whitePartialSum[0] = whiteCounter[0];
    blackPartialSum[0] = blackCounter[0];

    for (int col = 1; col <= cols; col++)
    {
        whitePartialSum[col] = whitePartialSum[col-1] + whiteCounter[col-1];
        blackPartialSum[col] = blackPartialSum[col-1] + blackCounter[col-1];
    }

    // costs of cheapest paths that end at i-th column being white/black
    int lastWhiteCost[1002];
    int lastBlackCost[1002];
    
    lastWhiteCost[0] = lastBlackCost[0] = 0;
    for (int col = 1; col <= cols; col++) 
    {
        lastWhiteCost[col] = lastBlackCost[col] = 1e9;
    }

    for (int col = 1; col <= cols; col++)
    {
        for (int diff = minWidth; diff <= maxWidth && col - diff >= 0; diff++)
        {
            lastWhiteCost[col] = std::min(
                lastWhiteCost[col], 
                lastBlackCost[col-diff] + whitePartialSum[col] - whitePartialSum[col-diff]);
            lastBlackCost[col] = std::min(
                lastBlackCost[col], 
                lastWhiteCost[col-diff] + blackPartialSum[col] - blackPartialSum[col-diff]);
        }
    }
    
    std::cout << std::min(lastWhiteCost[cols], lastBlackCost[cols]) << std::endl;

    return 0;
}