#include <iostream>
#include <map>

struct NumberInfo 
{
    NumberInfo() : frequency{1}
    { }

    // warning: doesn't keep bestWithCurrent updated
    NumberInfo& operator++()
    { 
        ++frequency;
        return *this;
    }

    // warning: only call for element which key isn't incrementing compared to all others
    void updateBestInfo(const unsigned int key)
    {
        bestWithCurrent = static_cast<unsigned long long>(key)*frequency;
    }

    // warning: only call if keys are incrementing
    void updateBestInfo(
        const unsigned long long bestWithPrevious, 
        const unsigned long long bestWithoutPrevious,
        const unsigned int key)
    {
        bestWithCurrent = bestWithoutPrevious + static_cast<unsigned long long>(key)*frequency;
        
        bestWithoutCurrent = 
            bestWithPrevious > bestWithoutPrevious ? 
                bestWithPrevious :
                bestWithoutPrevious;
    }

    unsigned long long getBestWith() const
    {
        return bestWithCurrent;
    }

    unsigned long long getBestWithout() const
    {
        return bestWithoutCurrent;
    }

private:
    unsigned int frequency;
    unsigned long long bestWithCurrent;
    unsigned long long bestWithoutCurrent;
};

unsigned long long findPartialSum(std::map<unsigned int, NumberInfo>& numberMap, unsigned int currentIndex)
{
    const NumberInfo& numberInfo = numberMap.find(currentIndex)->second;
    const unsigned long long bestWithSum = numberInfo.getBestWith();
    const unsigned long long bestWithoutSum = numberInfo.getBestWithout();
    
    return bestWithSum > bestWithoutSum ? 
                bestWithSum :
                bestWithoutSum;
}

int main()
{
    unsigned int n, elem;
    std::cin >> n;
    
    std::map<unsigned int, NumberInfo> numberMap {};
    
    for (int i = 0; i < n; i++)
    {
        std::cin >> elem;
        
        auto it = numberMap.find(elem);
        if (it == numberMap.end())
        {
            numberMap.insert({elem, NumberInfo()});
        }
        else
        {
            ++it->second;
        }
    }
    
    unsigned long long sum = 0;

    for (auto& it : numberMap)
    {
        it.second.updateBestInfo(it.first);
    }
    
    for (auto& it : numberMap)
    {
        auto nextIt = numberMap.find(it.first+1);
        
        if (nextIt == numberMap.end())
        {
            sum += findPartialSum(numberMap, it.first);
        }
        else
        {
            nextIt->second.updateBestInfo(it.second.getBestWith(), it.second.getBestWithout(), nextIt->first);   
        }
    }
    
    std::cout << sum << std::endl;
    return 0;
}