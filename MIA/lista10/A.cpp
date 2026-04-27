#include <iostream>

int main()
{
    std::ios::sync_with_stdio(0);
    std::cin.tie(0);
    std::cout.tie(0);
    
    std::string a, b;
    std::cin >> a >> b;
    
    int lengthA = a.size(), lengthB = b.size();
    int windowCount = lengthB - lengthA + 1;
    long long currentSum = 0, totalHammingDistance = 0;

    // Initial sum of '1's in the first window of b
    for (int i = 0; i < windowCount; i++)
    {
        if (b[i] == '1') currentSum++;
    }

    // Calculate Hamming distance sum
    for (int i = 0; i < lengthA; i++)
    {
        if (a[i] == '1')
        {
            totalHammingDistance += windowCount - currentSum;
        }
        else
        {
            totalHammingDistance += currentSum;
        }
        if (b[i] == '1')
            currentSum--;
        if (b[i + windowCount] == '1')
            currentSum++;
    }

    std::cout << totalHammingDistance << std::endl;
    return 0;
}
