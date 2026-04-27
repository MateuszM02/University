#include <iostream>
#include <map>
#include <optional>
#include <set>

#define FOR(n) for (int i = 0; i < n; i++)
#define KEY(n) n >> 17

#define ull unsigned long long 
#define maybeUll std::optional<ull>

struct IngredientInfo
{
    IngredientInfo(const ull ng, const ull og, const ull bk = 0)
    : neededGrams{ng}
    , ownedGrams{og%ng}
    , bakedCookies{bk + static_cast<ull>(og)/ng}
    { }

    // calculate amount of baked cookies if we use all remaining magic powder on current ingredient
    ull MaximumNewBakedCookies(ull remainingMagicPowder) const
    {
        const ull firstUpgradeCost = UpgradeCost();
        if (remainingMagicPowder < firstUpgradeCost) return bakedCookies;

        remainingMagicPowder -= firstUpgradeCost;
        return bakedCookies + 1 + remainingMagicPowder / neededGrams;
    }

    ull BakedCookies() const { return bakedCookies; }
    ull OwnedGrams() const { return ownedGrams; }
    ull NeededGrams() const { return neededGrams; }
    ull UpgradeCost() const { return neededGrams - ownedGrams; }

private:
    ull bakedCookies;
    ull ownedGrams;
    ull neededGrams;
};

struct IngredientMap
{
    // adds ingredient to map of ingredients in the first phase called ingredient insertion
    void AddIngredient(const IngredientInfo& newIngredient)
    {
        const ull newBakedCookies = newIngredient.BakedCookies();
        auto it = ingredients.find(newBakedCookies);
        
        // first ingredient with given amount of baked cookies, just add it
        if (it == ingredients.end())
        {
            ingredients.insert({newBakedCookies, newIngredient});
            return;
        }

        // merging multiple ingredients of same amount of baked cookies into one
        const IngredientInfo& oldIngredient = it->second;
        const ull neededGrams = oldIngredient.NeededGrams() + newIngredient.NeededGrams();
        const ull ownedGrams = oldIngredient.OwnedGrams() + newIngredient.OwnedGrams();

        it->second = {neededGrams, ownedGrams, newBakedCookies};
    }

    IngredientInfo GetFirstElement() const 
    { 
        return ingredients.begin()->second; 
    }

    bool WasEmptyAfterRemoval(const ull key)
    {
        ingredients.erase(key);
        return ingredients.empty();
    }

private:
    std::map<ull, IngredientInfo> ingredients;
};

struct OuterMap
{
    // adds ingredient to map of ingredients in the first phase called ingredient insertion
    void Add(const IngredientInfo& newIngredient)
    {
        const ull newBakedCookies = newIngredient.BakedCookies();
        innerMaps[KEY(newBakedCookies)].AddIngredient(newIngredient);
        bakedCookiesSet.emplace(newBakedCookies);
    }

    // uses magic powder to upgrade "lowest" ingredient to either maximum or next ingredient
    void UseAndUpdatePowder(ull& remainingMagicPowder)
    {
        const IngredientInfo& firstIngredient = this->GetFirstIngredient();
        const ull firstKey = firstIngredient.BakedCookies();
        const ull firstNeededGrams = firstIngredient.NeededGrams();
        const ull firstOwnedGrams = firstIngredient.OwnedGrams();
        
        const ull newMaxKey = firstIngredient.MaximumNewBakedCookies(remainingMagicPowder);

        if (firstKey == newMaxKey) // don't have enough magic powder for any upgrade
        {
            remainingMagicPowder = 0;
            return;
        }

        const maybeUll maybeSuccessorKey = this->GetSuccessorKey(firstIngredient.BakedCookies());
        ull keyDifference;
        
        // case 1. Use all of magic powder on upgrading current ingredient
        if (!maybeSuccessorKey.has_value() || maybeSuccessorKey.value() >= newMaxKey)
        {
            keyDifference = newMaxKey - firstKey;
        }
        else // case 2. Use some of magic powder to upgrade current ingredient to value of its successor
        {
            keyDifference = maybeSuccessorKey.value() - firstKey;
        }

        remainingMagicPowder = remainingMagicPowder + firstOwnedGrams - firstNeededGrams * keyDifference;
        this->RemoveIngredient(firstIngredient);
        this->Add({firstNeededGrams, 0, newMaxKey});
    }
    
    ull GetBakedCookiesCount() const
    {
        return innerMaps.begin()->second.GetFirstElement().BakedCookies();
    }

private:
    IngredientInfo GetFirstIngredient() const
    {
        return innerMaps.begin()->second.GetFirstElement();
    }

    maybeUll GetSuccessorKey(const ull bakedCookies) const
    {
        auto it = bakedCookiesSet.upper_bound(bakedCookies);
        if (it == bakedCookiesSet.end()) 
            return std::nullopt;
        return *it;
    }

    void RemoveIngredient(const IngredientInfo& ingredient)
    {
        const ull bakedCookies = ingredient.BakedCookies();
        bakedCookiesSet.erase(bakedCookies);
        
        const ull mapKey = KEY(bakedCookies);
        const bool wasLastElement = innerMaps[mapKey].WasEmptyAfterRemoval(bakedCookies);
        if (wasLastElement)
            innerMaps.erase(mapKey);
    }

    std::map<ull, IngredientMap> innerMaps; // use KEY(bakedCookies) as key
    std::set<ull> bakedCookiesSet;
};

int main()
{
    ull n, magicGrams, gramsOwned;
    std::cin >> n >> magicGrams;

    OuterMap outerMap;

    ull gramsNeededTempArray[n];

    FOR (n)
    {
        std::cin >> gramsNeededTempArray[i];
    }
    
    FOR (n)
    {
        std::cin >> gramsOwned;
        outerMap.Add({gramsNeededTempArray[i], gramsOwned});
    }

    while (magicGrams > 0)
    {
        outerMap.UseAndUpdatePowder(magicGrams);
    }

    std::cout << outerMap.GetBakedCookiesCount() << std::endl;
    return 0;
}