#include <iostream>
#include <vector>
#include <algorithm>

std::string balance_ternary_string(int n, std::string s)
{
    std::vector<int> count(3, 0);
    for (char c : s)
    {
        count[c - '0']++;
    }

    const int target = n / 3;

    // Replace excess '2's with '0's or '1's
    for (int i = 0; i < n; ++i)
    {
        if (count[2] > target && s[i] == '2')
        {
            if (count[0] < target)
            {
                s[i] = '0';
                count[0]++;
                if (--count[2] == target) break;
            }
            else if (count[1] < target)
            {
                s[i] = '1';
                count[1]++;
                if (--count[2] == target) break;
            }
        }
    }

    // Replace excess '1's with '0's
    for (int i = 0; i < n; ++i)
    {
        if (count[1] > target && s[i] == '1')
        {
            if (count[0] < target)
            {
                s[i] = '0';
                count[0]++;
                if (--count[1] == target) break;
            }
        }
    }

    // Replace excess '1's with '2's
    for (int i = n-1; i >= 0; --i)
    {
        if (count[1] > target && s[i] == '1')
        {
            if (count[2] < target)
            {
                s[i] = '2';
                count[2]++;
                if (--count[1] == target) break;
            }
        }
    }

    // Replace excess '0's with '1's or '2's
    for (int i = n-1; i >= 0; --i)
    {
        if (count[0] > target && s[i] == '0')
        {
            if (count[2] < target)
            {
                s[i] = '2';
                count[2]++;
                if (--count[0] == target) break;
            }
            else if (count[1] < target)
            {
                s[i] = '1';
                count[1]++;
                if (--count[0] == target) break;
            }
        }
    }
    return s;
}

int main()
{
    int n;
    std::string s;
    std::cin >> n >> s;
    std::cout << balance_ternary_string(n, s) << std::endl;
}