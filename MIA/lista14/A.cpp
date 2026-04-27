#include <iostream>
#include <vector>
#include <std::string>

int minReplacements(std::string aiName, std::string phoneName)
{
    const int n = aiName.length();
    const int m = phoneName.length();
    std::vector<int> dp(n + 1, 0);
    std::vector<int> nextState(m, 0);

    // Build nextState array using KMP algorithm
    int j = 0;
    for (int i = 1; i < m; ++i)
    {
        while (j > 0 && phoneName[i] != phoneName[j])
        {
            j = nextState[j - 1];
        }
        if (phoneName[i] == phoneName[j])
        {
            j++;
        }
        nextState[i] = j;
    }

    // Fill dp array
    for (int i = 1; i <= n; ++i)
    {
        dp[i] = dp[i - 1] + 1;
        int k = 0;
        for (int j = i - 1; j >= 0; --j)
        {
            if (k < m && aiName[j] == phoneName[k])
            {
                k++;
                if (k == m)
                {
                    dp[i] = min(dp[i], dp[j] + 1);
                    break;
                }
            }
            else if (k > 0)
            {
                k = nextState[k - 1];
            }
        }
    }
    return dp[n];
}

int main()
{
    std::string aiName, phoneName;
    std::cin >> aiName >> phoneName;
    std::cout << minReplacements(aiName, phoneName) << endl;
    return 0;
}
