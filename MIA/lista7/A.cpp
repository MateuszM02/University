#include <algorithm>
#include <iostream>
#include <queue>
#include <vector>

#define FOR(n) for(unsigned int i = 0; i < n; i++)
#define ITER(vec) vec.begin(), vec.end()
#define IngredientVector std::vector<IngredientInfo>

struct IngredientInfo
{
    IngredientInfo(const unsigned int ng, const unsigned int og)
    : index{instances++}
    , neededGrams{ng}
    , ownedGrams{og}
    , bakedCookies{og/ng}
    { 
        ownedGrams = ownedGrams - bakedCookies * neededGrams;
    }
    
    // copy constructor & assignment
    IngredientInfo(const IngredientInfo& other)
    : index{other.index}
    , neededGrams{other.neededGrams}
    , ownedGrams{other.ownedGrams}
    , bakedCookies{other.bakedCookies}
    { }

    IngredientInfo& operator=(const IngredientInfo& other) 
    { 
        if (this != &other) 
        {
            index = other.index;
            neededGrams = other.neededGrams;
            ownedGrams = other.ownedGrams; 
            bakedCookies = other.bakedCookies; 
        } 
        return *this; 
    }

    // std::greater comparison operator
    bool operator>(const IngredientInfo& other) const 
    { 
        return bakedCookies == other.bakedCookies 
                ? neededGrams > other.neededGrams
                : bakedCookies > other.bakedCookies; 
    }

    unsigned int getBakedCookies() const { return bakedCookies; }

    // must be neededGrams >= ownedGrams to work!
    unsigned int getMissingGrams() const 
    { 
        return neededGrams - ownedGrams; 
    }

    void bakeOneCookie()
    {
        bakedCookies++;
        ownedGrams = ownedGrams < neededGrams ? 0 : ownedGrams - neededGrams;
    }

private:
    unsigned int index;
    unsigned int neededGrams;
    unsigned int ownedGrams;
    unsigned int bakedCookies;

    static unsigned int instances;
};
unsigned int IngredientInfo::instances = 0;

int main()
{
    unsigned int n, magicGrams, gramsOwned;
    std::cin >> n >> magicGrams;

    IngredientVector ingredients;
    ingredients.reserve(n);

    unsigned int gramsNeededTempArray[n];

    FOR(n)
    {
        std::cin >> gramsNeededTempArray[i];
    }
    
    FOR(n)
    {
        std::cin >> gramsOwned;
        ingredients.emplace_back(gramsNeededTempArray[i], gramsOwned);
    }

    std::make_heap(ITER(ingredients), std::greater<IngredientInfo>());
    std::priority_queue<IngredientInfo, IngredientVector, std::greater<IngredientInfo>> 
        minHeap(ITER(ingredients));

    while (magicGrams != 0)
    {
        IngredientInfo ingredient = minHeap.top();
        minHeap.pop();

        const unsigned int missingGrams = ingredient.getMissingGrams();
        if (magicGrams < missingGrams)
        {
            std::cout << ingredient.getBakedCookies() << std::endl;
            return 0;
        }
        
        ingredient.bakeOneCookie();
        magicGrams -= missingGrams;
        minHeap.emplace(ingredient);
    }

    std::cout << minHeap.top().getBakedCookies() << std::endl;
    return 0;
}