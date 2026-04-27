#include <iostream>
#include <unordered_set>

void solve()
{
    std::unordered_set<unsigned int> numbers;
    unsigned int value, n;
    std::cin >> n;
    
    for (unsigned int i = 0; i < n; i++)
    {
        std::cin >> value;
        numbers.emplace(value);
    }
    
    std::cout << numbers.size() << std::endl;
}

int main()
{
    unsigned int t;
    std::cin >> t;
    while (t-- > 0)
    {
        solve();
    }
    return 0;
}