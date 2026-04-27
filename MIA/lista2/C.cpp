#include <iostream>
#include <string>

using namespace std;

int main() 
{
    int n, t1, t2;
    cin >> n >> t1;
    t2 = t1;
    
    string s1, s2;
    cin >> s1 >> s2;

    int diffCount = 0;
    for (int i = 0; i < n; ++i) 
    {
        if (s1[i] != s2[i])
            ++diffCount;
    }

    if (diffCount > t1 + t2) 
    {
        cout << -1 << endl;
        return 0;
    }

    string s3(n, ' ');

    for (int i = 0; i < n; ++i) 
    {
        if (s1[i] != s2[i]) 
        {
            if (t1 + t2 > diffCount) // use character different than both s1 and s2
            {
                for (char c : "abc") 
                {
                    if (c != s1[i] && c != s2[i]) 
                    {
                        s3[i] = c;
                        t1--;
                        t2--;
                        break;
                    }
                }
            }
            else // use character equal to either s1 or s2
            {
                if (t1 == t2)
                {
                    s3[i] = s2[i];
                    t2--;
                } 
                else // t1 > t2, case t1 < t2 not possible
                {
                    s3[i] = s1[i];
                    t1--;
                }
            }
            diffCount--;
        } 
        else // s1[i] = s2[i]
        {
            if (t1 > diffCount) // s3 will be different to s1 and s2
            {
                for (char c : "ab") 
                {
                    if (c != s1[i]) 
                    {
                        s3[i] = c;
                        t1--;
                        t2--;
                        break;
                    }
                }
            } 
            else // s1[i] = s2[i] = s3[i]
            {
                s3[i] = s1[i];
            }
        }
    }

    cout << s3 << endl;
    return 0;
}
