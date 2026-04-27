#include <algorithm>
#include <iostream>
#include <map>
#include <vector>

int main() 
{
    unsigned short t;
    std::cin >> t;

    for (unsigned short outer = 0; outer < t; outer++) 
    {
        unsigned short n;
        std::cin >> n;
        std::vector<long int> numbers(n);
        for (unsigned short i = 0; i < n; i++) 
        {
            std::cin >> numbers[i];
        }

        std::map<long int, unsigned short> occurencesMap;
        for (unsigned short i = 0; i < n; i++) 
        {
            occurencesMap[numbers[i]]++;
        }

        bool arbitrarilyLarge = false;
        const unsigned short halfN = (n + 1) / 2;
        for (const auto& entry : occurencesMap) 
        {
            if (entry.second >= halfN) 
            {
                arbitrarilyLarge = true;
                break;
            }
        }

        if (arbitrarilyLarge) 
        {
            std::cout << "-1" << std::endl;
            continue;
        }

        std::map<long int, unsigned short> potentialKs;
        for (unsigned short i = 0; i < n; i++) 
        {
            for (unsigned short j = i + 1; j < n; j++) 
            {
                if (const long int diff = std::abs(numbers[i] - numbers[j]); diff != 0)
                {
                    potentialKs[diff]++;
                }
            }
        }

        std::vector<std::pair<long int, unsigned short>> potentialKsVector(potentialKs.begin(), potentialKs.end());
        std::sort(potentialKsVector.begin(), potentialKsVector.end());

        const unsigned short kSize = potentialKsVector.size();

        for (short i = kSize - 1; i >= 1; i--) 
        {
            for (short j = i - 1; j >= 0; j--) 
            {
                if (potentialKsVector[i].first % potentialKsVector[j].first == 0) 
                {
                    potentialKsVector[j].second++;
                }
            }
        }

        for (short i = kSize - 1; i >= 0; i--) 
        {
            if (potentialKsVector[i].second >= halfN) 
            {
                std::cout << potentialKsVector[i].first << std::endl;
                break;
            }
        }
    }

    return 0;
}
