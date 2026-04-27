#include <algorithm>
#include <iostream>
#include <map>
#include <unordered_set>
#include <vector>

int main()
{
    std::string n;
    std::getline(std::cin, n);
    
    while (!n.empty()) 
    {
        auto& lastDigit = n.back();
        if (lastDigit == '1')
            n.pop_back();
        else if (lastDigit == '3')
            n.pop_back();
        else if (lastDigit == '5')
            n.pop_back();
        else if (lastDigit == '7')
            n.pop_back();
        else if (lastDigit == '9')
            n.pop_back();
        else
            break;
    };
    
    for (const char c : n)
    {
        if (c == '0')
        {
            std::cout << "YES" << std::endl << c;
            return 0;
        }
        else if (c == '8')
        {
            std::cout << "YES" << std::endl << c;
            return 0;
        }
    }
    
    std::map<char, std::vector<char>> charMap;
    charMap['1'] = {'6'};
    charMap['2'] = {'4'};
    charMap['3'] = {'2'};
    charMap['5'] = {'6'};
    charMap['6'] = {'4'};
    charMap['7'] = {'2'};
    charMap['9'] = {'6'};
    
    for (int i = 0; i < n.length(); i++)
    {
        if (n[i] == '4')
        {
            continue;
        }
        
        std::vector<char> expectedDigits = charMap.find(n[i])->second;
        for (int j = i+1; j < n.length(); j++)
        {
            if (std::find(expectedDigits.begin(), expectedDigits.end(), n[j]) != expectedDigits.end()) 
            {
                std::cout << "YES" << std::endl << n[i] << n[j];
                return 0;
            }
        }
    }
    
    for (int i = 0; i < n.length(); i++)
    {
        for (int j = i+1; j < n.length(); j++)
        {
            std::unordered_set<char> uncheckedLastDigits = { '2', '4', '6' };
            for (int k = j+1; k < n.length(); k++)
            {
                if (std::find(uncheckedLastDigits.begin(), uncheckedLastDigits.end(), n[k]) != uncheckedLastDigits.end()) 
                {
                    int number = (n[i] - '0')*100 + (n[j] - '0')*10 + (n[k] - '0');
                    if (number % 8 == 0)
                    {
                        std::cout << "YES" << std::endl << number;
                        return 0;
                    }
                    
                    uncheckedLastDigits.erase(n[k]);
                    if (uncheckedLastDigits.empty())
                    {
                        continue;
                    }
                }
            }
        }
    }
    
    std::cout << "NO";
    return 0;
}