#include <iostream>
#include <unordered_map>
#include <utility>

#define occurence_pair std::pair<unsigned int, unsigned int>
#define inner_map std::unordered_map<unsigned int, occurence_pair>
#define stations_map std::unordered_map<unsigned short, inner_map>

int main()
{
    unsigned int t, n, queries, station, a, b;
    std::cin >> t;
    
    for (int index = 0; index < t; index++)
    {
        std::cin >> n >> queries;
        
        stations_map stationsMap = {};
        
        for (int i = 1; i <= n; i++)
        {
            std::cin >> station;
            unsigned short outerKey = station >> 15;

            occurence_pair& occurencePair = stationsMap[outerKey][station];
            if (occurencePair.first == 0 && occurencePair.second == 0)
            {
                occurencePair.first = i;
            }

            occurencePair.second = i; 
        }

        for (int i = 1; i <= queries; i++)
        {
            std::cin >> a >> b;

            unsigned short outerKey = a >> 15;
            const inner_map& innerMapA = stationsMap[outerKey];
            const auto& iterA = innerMapA.find(a);

            if (iterA == innerMapA.end())
            {
                std::cout << "NO" << std::endl;
                continue;
            }
            else if (a == b)
            {
                std::cout << "YES" << std::endl;
                continue;
            }

            outerKey = b >> 15;
            const inner_map& innerMapB = stationsMap[outerKey];
            const auto& iterB = innerMapB.find(b);
            
            if (iterB == innerMapB.end())
            {
                std::cout << "NO" << std::endl;
                continue;
            }

            const unsigned int& firstAindex = iterA->second.first;
            const unsigned int& lastBindex = iterB->second.second;

            std::cout << (firstAindex < lastBindex ? "YES" : "NO") << std::endl;
        }
    }
    return 0;
}