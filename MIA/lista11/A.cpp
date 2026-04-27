#include <iostream>

void solve()
{
    int n;
    std::cin >> n;

    if (n % 4 != 0)
    {
        std::cout << "NO\n";
        return;
    }
    std::cout << "YES\n";
    
    for (int x = 2; x <= n; x+=2)
    {
        std::cout << x << " ";
    }
    for (int x = 1; x <= n-3; x+=2)
    {
        std::cout << x << " ";
    }

    int lastNumber = n + (n/2) - 1;
    std::cout << lastNumber << "\n";
}

int main()
{
    int t;
    std::cin >> t;
    while (--t >= 0)
    {
        solve();
    }
    return 0;
}