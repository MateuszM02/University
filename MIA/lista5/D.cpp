#include <iostream>
#include <vector>
#include <algorithm>

int main() {
    int n;
    std::cin >> n;

    std::vector<std::vector<int>> grid(n, std::vector<int>(n));
    for (int i = 0; i < n; ++i) 
    {
        for (int j = 0; j < n; ++j) 
        {
            std::cin >> grid[i][j];
        }
    }

    std::vector<std::vector<std::vector<int>>> dp(2*n-1, 
        std::vector<std::vector<int>>(n, 
            std::vector<int>(n, INT32_MIN)));
    dp[0][0][0] = grid[0][0];

    for (int step = 1; step < 2*n-1; ++step) 
    {
        for (int row1 = std::max(0, step - (n-1)); row1 <= std::min(n-1, step); ++row1) 
        {
            for (int row2 = std::max(0, step - (n-1)); row2 <= std::min(n-1, step); ++row2) 
            {
                const int col1 = step - row1;
                const int col2 = step - row2;

                if (col1 >= n || col2 >= n) continue;

                int currentValue = grid[row1][col1];
                if (row1 != row2 || col1 != col2) 
                {
                    currentValue += grid[row2][col2];
                }

                int& cell = dp[step][row1][row2];

                // from (row1-1, col1) and (row2-1, col2)
                cell = std::max(cell, dp[step-1][row1][row2] + currentValue); 

                // from (row1-1, col1) and (row2, col2-1)
                if (row1 > 0) 
                    cell = std::max(cell, dp[step-1][row1-1][row2] + currentValue); 
                
                // from (row1, col1-1) and (row2-1, col2)
                if (row2 > 0) 
                    cell = std::max(cell, dp[step-1][row1][row2-1] + currentValue);
                
                // from (row1-1, col1) and (row2-1, col2)
                if (row1 > 0 && row2 > 0) 
                    cell = std::max(cell, dp[step-1][row1-1][row2-1] + currentValue);
            }
        }
    }

    std::cout << dp[2*n-2][n-1][n-1] << std::endl;
    return 0;
}
