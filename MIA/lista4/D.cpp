#include <algorithm>
#include <iostream>
#include <vector>
#include <map>
#include <set>
#include <functional>

using ll = long long;
#define FOR(i, start, end) for (ll i = start; i <= end; ++i)
#define FORD(i, start, end) for (ll i = start; i >= end; --i)
#define vec(type) std::vector<type>
#define pb push_back
#define p std::pair

void printVector(const std::vector<ll>& v) {
    for (const auto& elem : v) {
        std::cout << elem << " ";
    }
    std::cout << std::endl;
}

int main() {
    ll numMonocarpItems, numOpponentItems, numQueries;
    std::cin >> numMonocarpItems >> numOpponentItems >> numQueries;

    vec(ll) allPrices;
    std::map<ll, ll> itemCount, firstOccurrence, lastOccurrence;
    ll totalMonocarpValue = 0;

    FOR(i, 0, numMonocarpItems - 1) {
        ll price;
        std::cin >> price;
        totalMonocarpValue += price;
        allPrices.pb(price);
        itemCount[price]++;
    }
    FOR(i, 0, numOpponentItems - 1) {
        ll price;
        std::cin >> price;
        allPrices.pb(price);
    }

    std::sort(allPrices.begin(), allPrices.end());
    FOR(i, 0, allPrices.size() - 1) lastOccurrence[allPrices[i]] = i;
    FORD(i, allPrices.size() - 1, 0) firstOccurrence[allPrices[i]] = i;

    vec(ll) prefixSum = allPrices;
    FOR(i, 1, prefixSum.size() - 1) prefixSum[i] += prefixSum[i - 1];

    std::set<std::vector<ll>> sortByDistance;
    std::set<std::vector<ll>> sortByFirstElement;

    FOR(i, 0, allPrices.size() - 2) {
        if (allPrices[i] == allPrices[i + 1]) continue;
        ll price = allPrices[i];
        sortByDistance.insert({allPrices[i + 1] - allPrices[i], itemCount[price], lastOccurrence[price], firstOccurrence[price]});
        sortByFirstElement.insert({firstOccurrence[price], lastOccurrence[price], itemCount[price], allPrices[i + 1] - allPrices[i]});
    }

    sortByDistance.insert({(ll)1e18, itemCount[allPrices.back()], lastOccurrence[allPrices.back()], firstOccurrence[allPrices.back()]});
    sortByFirstElement.insert({firstOccurrence[allPrices.back()], lastOccurrence[allPrices.back()], itemCount[allPrices.back()], (ll)1e18});

    vec(ll) queryResults(numQueries);
    std::vector<p<ll, ll>> queries(numQueries);
    FOR(i, 0, numQueries - 1) {
        std::cin >> queries[i].first;
        queries[i].second = i;
    }

    std::sort(queries.begin(), queries.end());

    std::function<ll(ll, ll)> calculateSum = [&](ll lastIndex, ll itemCount) {
        ll startIdx = lastIndex - itemCount;
        ll sum = 0;
        if (startIdx == -1) {
            sum += prefixSum[0];
            startIdx = 0;
        }
        sum += prefixSum[lastIndex] - prefixSum[startIdx];
        return sum;
    };

    for (auto query : queries) {
        std::vector<ll> currentInterval = *sortByDistance.begin();
        while (currentInterval[0] <= query.first) {
            std::vector<ll> reversedInterval = currentInterval;
            std::reverse(reversedInterval.begin(), reversedInterval.end());
            std::vector<ll> nextInterval = *sortByFirstElement.upper_bound(reversedInterval);
            std::vector<ll> nextReversedInterval = nextInterval;
            std::reverse(nextReversedInterval.begin(), nextReversedInterval.end());
            sortByDistance.erase(currentInterval);
            sortByDistance.erase(nextReversedInterval);
            sortByFirstElement.erase(reversedInterval);
            sortByFirstElement.erase(nextInterval);
            totalMonocarpValue -= calculateSum(reversedInterval[1], reversedInterval[2]);
            totalMonocarpValue -= calculateSum(nextInterval[1], nextInterval[2]);
            totalMonocarpValue += calculateSum(nextInterval[1], reversedInterval[2] + nextInterval[2]);
            nextInterval[2] = reversedInterval[2] + nextInterval[2];
            nextInterval[0] = reversedInterval[0];
            sortByFirstElement.insert(nextInterval);
            std::reverse(nextInterval.begin(), nextInterval.end());
            sortByDistance.insert(nextInterval);
            currentInterval = *sortByDistance.begin();
        }
        queryResults[query.second] = totalMonocarpValue;
    }

    printVector(queryResults);

    return 0;
}
