#include <algorithm>
#include <array>
#include <iostream>

int main()
{
    int t;
    std::array<int, 3> xs;
    std::cin >> t;

    while (--t >= 0)
    {
        std::cin >> xs[0] >> xs[1] >> xs[2];
        std::sort(xs.begin(), xs.end());
        std::cout << xs[2] - xs[0] << std::endl;
    }
    return 0;
}