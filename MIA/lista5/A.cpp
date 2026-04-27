#include <iostream>
#include <unordered_set>

int main()
{
    std::string s;
    std::cin >> s;
    
    const int len = s.length();
    std::unordered_set<char> legalChars {};
    
    for (int i = 1; i < len-1; i++)
    {
        if (s[i] == s[i-1])
        {
            legalChars = {'a', 'b', 'c'};
            legalChars.erase(s[i]);
            legalChars.erase(s[i+1]);

            s[i] = *legalChars.begin();
        }
    }
    
    if (s[len-2] == s[len-1])
    {
        if (s[len-1] != 'a')
        {
            s[len-1] = 'a';
        }
        else
        {
            s[len-1] = 'b';
        }
    }
    
    std::cout << s << std::endl;
    return 0;
}