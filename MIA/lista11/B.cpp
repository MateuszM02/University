#include <algorithm>
#include <iostream>
#include <unordered_map>
#include <vector>

int main()
{
    int n;
    std::cin >> n;
    std::cin.ignore();

    std::unordered_map<char, int> charMap;
    char c;
    
    for (int i = 0; i < n; ++i)
    {
        std::cin.get(c);
        ++charMap[c];
    }

    std::vector<std::pair<char, int>> sortedCharVec;
    for (const auto& pair : charMap)
    {
        sortedCharVec.emplace_back(pair);
    }
    std::sort(sortedCharVec.begin(), sortedCharVec.end(),
        [](const auto& p1, const auto& p2) { return p1.second < p2.second; });

    std::string result;
    for (const auto& [c, freq] : sortedCharVec)
    {
        result += std::string(freq, c);
    }
    std::cout << result << "\n";
    return 0;
}