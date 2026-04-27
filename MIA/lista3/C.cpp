//  “Work like there is someone working 24 hours a day to take it away from you.”

#include <bits/stdc++.h>
#include <ext/pb_ds/assoc_container.hpp>

using namespace __gnu_pbds;
using namespace std;

#define ll long long
#define el '\n'
#define pb push_back
#define all(x) x.begin(), x.end()
#define asc(x) sort(x.begin(), x.end())
#define des(x) sort(x.begin(), x.end(), greater<int>())
#define rep(i, n) for (int i = 0; i < n; i++)
#define rev(i, n) for (int i = n; i >= 0; i--)
#define rep_a(i, a, n) for (int i = a; i < n; i++)

typedef tree<int, null_type, less<int>, rb_tree_tag, tree_order_statistics_node_update> indexed_set;

const long long MOD = 998244353;
const long long INF = 1e9 + 10;
const long long INFLL = 1e18;

typedef pair<int, int> pi;
typedef pair<ll, ll> pl;

typedef set<int> si;
typedef set<ll> sll;

typedef map<int, int> mii;
typedef map<ll, ll> mll;

#define yes cout << "YES\n"
#define no cout << "NO\n"

#define popcount(x) __builtin_popcount(x)
#define popcountll(x) __builtin_popcountll(x)
#define fi first
#define se second
#define SUM(v) accumulate(all(v), 0LL)
#define MIN(v) *min_element(all(v))
#define MAXX(v) *max_element(all(v))
 
typedef vector<int> vi;
typedef vector<ld> vd;
typedef vector<ll> vl;
typedef vector<pi> vpi;
typedef vector<pl> vpl;

ll string_to_integer(string s) {
    ll num = stoi(s);
    return num;
}

ll ceil_div(ll a, ll b) {
    return a % b == 0 ? a / b : a / b + 1;
}

ll power(ll a, ll b) {
    ll res = 1;
    while (b > 0) {
        if (b & 1) res = res * a;
        a = a * a;
        b >>= 1;
    }
    return res;
}

const int MAX_N = 200005;

//------------------------------------------------------------------------

void solve() {
    int n, k; 
    cin >> n >> k;
    vi a(n); 
    rep(i, n) cin >> a[i];
    
    int answer = INF;
    for (int v = 0; v <= a[0]; v++) {
        int current_max = v;
        rep(i, n) {
            int max_divisor = min(k, (v ? (a[i] / v) : k));
            current_max = max(current_max, a[i] / max_divisor);
        }
        answer = min(answer, current_max - v);
    }
    cout << answer << "\n";
}

int32_t main() {
    ios_base::sync_with_stdio(0); 
    cin.tie(0);
    
    int test_cases;
    cin >> test_cases;
    while (test_cases--) {
        solve();
    }

    return 0;
}
