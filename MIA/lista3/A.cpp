#include <iostream>
#include <unordered_set>

int main()
{
    unsigned int t;
    std::string s;
    std::cin >> t;
    
    for (int i = 0; i < t; i++)
    {
        std::cin >> s;
        
        std::string currentString = "";
        unsigned int day = 1;
        std::unordered_set<char> todaysLetters = {};
        
        for (const char& c : s)
        {
            if (todaysLetters.find(c) == todaysLetters.end())
            {
                if (todaysLetters.size() == 3)
                {
                    day++;
                    todaysLetters = {};
                }
                todaysLetters.emplace(c);
            }
            currentString += c;
        }
        std::cout << day << std::endl;
    }
    return 0;
}