#include <algorithm>
#include <iostream>

void solve()
{ 
    int n;
    std::cin >> n;
    
    if (n == 1)
    {
        std::cout << "-1\n";
        return;
    }
    
    int a[n];
    int b[n];
    
    for (int i = 0; i < n; i++)
    {
        std::cin >> a[i];
        b[i] = a[i];
    }

    std::sort(b, b+n);
    
    for (int i = 0; i < n; i++)
    {
        if( a[i] != b[i])
            continue;
        if (i+1 < n)
            std::swap(b[i], b[i+1]);
        else
            std::swap(b[i], b[i-1]);
    }
    
    for (int i = 0; i < n; i++)
        std::cout << b[i] << " ";
    std::cout << std::endl;
}

int main()
{
    std::cin.tie(0);
    std::cout.tie(0);
    std::ios::sync_with_stdio(0);
    
    int t;
    std::cin >> t;
    while (--t >= 0)
    {
        solve();
    }
    return 0;
}