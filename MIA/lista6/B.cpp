#include <iostream>

int main()
{
    unsigned int T, n, m, minCost, currentCost;
    std::cin >> T;

    for (unsigned int outer = 0; outer < T; outer++)
    {
        std::cin >> n >> m;
        if (n != m || n == 2)
        {
            for (unsigned int i = 0; i < n; i++)
            {
                std::cin >> minCost;
            }
            std::cout << "-1\n";
            continue;
        }

        minCost = 0;
        for (unsigned int i = 0; i < n; i++)
        {
            std::cin >> currentCost;
            minCost += 2*currentCost;
        }
        std::cout << minCost << std::endl;

        // 1->2->3->4->...->n->1
        for (unsigned int i = 1; i < n; i++)
        {
            std::cout << i << " " << i+1 << std::endl;
        }
        std::cout << n << " 1\n";
    }
    return 0;
}