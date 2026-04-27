#include <iostream>

class UnionFind {
public:
    UnionFind(const unsigned int n) : size(n), root(new unsigned int[n]), groupSizes(new unsigned int[n])
    {
        for (unsigned int i = 0; i < n; ++i) 
        {
            root[i] = i;
            groupSizes[i] = 1;
        }
    }

    unsigned int find(const unsigned int u) const
    {
        if (u != root[u]) 
        {
            root[u] = find(root[u]);
        }
        return root[u];
    }

    void unite(const unsigned int u, const unsigned int v) const
    {
        const unsigned int rootU = find(u);
        const unsigned int rootV = find(v);
        
        if (rootU > rootV) 
        {
            root[rootU] = rootV;
        } 
        else if (rootU < rootV)
        {
            root[rootV] = rootU;
        }
    }
    
    void updateGroupSizes() const
    {
        for (unsigned int i = 0; i < size; ++i)
        {
            if (i != root[i])
            {
                root[i] = find(i);
                groupSizes[root[i]]++;
            }
        }
        
        for (unsigned int i = 0; i < size; ++i)
        {
            if (i != root[i])
            {
                groupSizes[i] = groupSizes[root[i]];
            }
        }
    }

    unsigned int getGroupSize(const unsigned int u) const 
    { 
        return groupSizes[u]; 
    }

private:
    const unsigned int size;
    unsigned int* root;
    unsigned int* groupSizes;
};

int main() 
{
    unsigned int n, m, k, smallestInGroup, current;
    std::cin >> n >> m;

    UnionFind uf(n);

    for (unsigned int outer = 0; outer < m; ++outer) 
    {
        std::cin >> k;
        if (k < 1)
        {
            continue;
        }

        std::cin >> smallestInGroup;
        smallestInGroup--;
        
        for (unsigned int i = 1; i < k; ++i)
        {
            std::cin >> current;
            current--;
            
            uf.unite(smallestInGroup, current);

            if (current < smallestInGroup)
            {
                smallestInGroup = current;
            }
        }
    }

    uf.updateGroupSizes();

    for (unsigned int i = 0; i < n; ++i) 
    {
        std::cout << uf.getGroupSize(i) << " ";
    }

    return 0;
}
