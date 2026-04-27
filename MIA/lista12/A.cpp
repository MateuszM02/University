#include <iostream>
#include <cmath>

double expectedMaximum(int m, int n)
{
    double expectedValue = 0.0;
    for (int k = 1; k <= m; ++k)
    {
        double kDouble = k;
        double probK = pow(kDouble / m, n) - pow((kDouble - 1.0) / m, n);
        expectedValue += k * probK;
    }
    return expectedValue;
}

int main()
{
    int m, n;
    std::cin >> m >> n;
    double result = expectedMaximum(m, n);
    std::cout.precision(6);
    std::cout << std::fixed << result << std::endl;
    return 0;
}
