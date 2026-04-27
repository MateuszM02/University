#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

int main() {
    int n;
    unsigned long long a, b, k;
    cin >> n >> a >> b >> k;

    vector<unsigned long long> h(n);
    for (int i = 0; i < n; ++i) 
    {
        cin >> h[i];
    }

    vector<int> skips_needed;
    int points = 0;

    for (int i = 0; i < n; ++i) 
    {
        unsigned long long remainder = h[i] % (a + b);

        if (remainder == 0) 
        {
            remainder = a + b;
        }

        unsigned long long hits_needed = (remainder + a - 1) / a;

        if (hits_needed > 1) 
        {
            skips_needed.push_back(hits_needed - 1);
        } 
        else 
        {
            points++;
        }
    }

    sort(skips_needed.begin(), skips_needed.end());

    for (int i = 0; i < skips_needed.size() && k > 0; ++i) 
    {
        if (skips_needed[i] <= k) 
        {
            k -= skips_needed[i];
            points++;
        } 
        else 
        {
            break;
        }
    }

    cout << points << endl;
    return 0;
}
