#include <iostream>

int main()
{
    std::ios_base::sync_with_stdio(0);
    std::cin.tie(0);
    std::cout.tie(0);

    unsigned int n, value = 0;
    std::cin >> n;

    const unsigned int nDiv4 = n / 4;
    unsigned int grid[n+1][n+1];
    
    for (unsigned int i = 0; i < nDiv4; i++)
    {
        const unsigned int i4 = 4 * i;

        for (unsigned int j = 0; j < nDiv4; j++)
        {
            const unsigned int j4 = 4 * j;

            for (unsigned int row = 0; row < 4; row++)
            {
                for (unsigned int col = 0; col < 4; col++)
                {
                    grid[i4 + row][j4 + col] = value++;
                }
            }
        }
    }
    for (unsigned int i = 0; i < n; i++)
    {
        for (unsigned int j = 0; j < n; j++)
        {
            std::cout << grid[i][j] << " ";
        }
        std::cout << std::endl;
    }
    return 0;
}
