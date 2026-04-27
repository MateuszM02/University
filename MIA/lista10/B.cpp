#include <iostream>

unsigned long long binomialCoeff(unsigned int n, unsigned int k)
{
    unsigned long long C[k + 1] = {0};
    C[0] = 1;

    for (unsigned int i = 1; i <= n; i++)
    {
        for (unsigned int j = std::min(i, k); j > 0; j--)
        {
            C[j] = C[j] + C[j-1];
        }
    }

    return C[k];
}

int main()
{
    unsigned short n;
    std::cin >> n;

    // Calculate ways to distribute 5 "I fixed a critical bug" pennants
    unsigned long long waysBug = binomialCoeff(n + 4, 5);

    // Calculate ways to distribute 3 "I suggested a new feature" pennants
    unsigned long long waysFeature = binomialCoeff(n + 2, 3);

    // Total ways
    unsigned long long totalWays = waysBug * waysFeature;

    std::cout << totalWays << std::endl;
    return 0;
}
