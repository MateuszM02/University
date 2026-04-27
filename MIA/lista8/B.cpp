#include <iostream>

int main()
{
    unsigned int n, currentPower, maxPower;
    unsigned long long winsNeeded;
    std::cin >> n >> winsNeeded;

    std::cin >> maxPower;
    unsigned long long maxWins = 0;

    for (unsigned int i = 1; i < n; i++)
    {
        std::cin >> currentPower;
        if (currentPower > maxPower)
        {
            maxPower = currentPower;
            maxWins = 1;
        }
        else
        {
            maxWins++;
            if (maxWins == winsNeeded)
            {
                break;
            }
        }
    }
    
    std::cout << maxPower;
    return 0;
}