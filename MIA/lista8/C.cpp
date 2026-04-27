#include <iostream>
#include <map>
#include <optional>

#define KEY(x) x >> 9
#define innerMap std::map<unsigned int, unsigned int>
#define middleMap std::map<unsigned int, innerMap>
#define outerMap std::map<unsigned int, middleMap>

class MapOfMaps
{
public:
    void insert(const unsigned int start, const unsigned int end)
    {
        const unsigned int startKey = KEY(start);
        starts[startKey][start][end]++;

        const unsigned int endKey = KEY(end);
        ends[endKey][end][start]++;

        checkPair();
    }

    void remove(const unsigned int start, const unsigned int end) 
    {
        auto startOuterIt = starts.find(KEY(start));
        if (startOuterIt == starts.end()) return;

        auto startMiddleIt = startOuterIt->second.find(start);
        if (startMiddleIt == startOuterIt->second.end()) return;

        auto startInnerIt = startMiddleIt->second.find(end);
        if (startInnerIt == startMiddleIt->second.end()) return;

        if (--startInnerIt->second == 0) 
        {
            startMiddleIt->second.erase(startInnerIt);
            if (startMiddleIt->second.empty())
            {
                startOuterIt->second.erase(startMiddleIt);
            }
        }

        auto endOuterIt = ends.find(KEY(end));
        auto endMiddleIt = endOuterIt->second.find(end);
        auto endInnerIt = endMiddleIt->second.find(start);

        if (--endInnerIt->second == 0) 
        {
            endMiddleIt->second.erase(endInnerIt);
            if (endMiddleIt->second.empty())
            {
                endOuterIt->second.erase(endMiddleIt);
            }
        }

        checkPair();
    }

private:
    void checkPair() const
    {
        const auto maybeFirstEnd = getFirstEnd();
        const auto maybeLastStart = getLastStart();

        if (!maybeFirstEnd.has_value() || !maybeLastStart.has_value()
            || maybeFirstEnd.value() >= maybeLastStart.value()) 
            std::cout << "NO\n";
        else 
            std::cout << "YES\n";
    }

    std::optional<unsigned int> getFirstEnd() const
    {
        auto endMap = ends.begin()->second;
        if (endMap.empty()) return std::nullopt;
        return endMap.begin()->first;
    }

    std::optional<unsigned int> getLastStart() const
    {
        auto startMap = starts.rbegin()->second;
        if (startMap.empty()) return std::nullopt;
        return startMap.rbegin()->first;
    }

    outerMap starts;
    outerMap ends;
};

int main()
{
    unsigned int q, l, r;
    char op;
    MapOfMaps maps;

    std::cin >> q;
    for (unsigned int i = 0; i < q; i++)
    {
        std::cin >> op >> l >> r;

        if (op == '+') maps.insert(l, r);
        else           maps.remove(l, r);
    }
    return 0;
}