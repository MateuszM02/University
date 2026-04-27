#include <iostream>
#include <queue>
#include <vector>

int main() 
{
    unsigned long long numNodes, numEdges;
    std::cin >> numNodes >> numEdges;

    std::vector<unsigned long long> nodeValues(numNodes + 1);
    for (int i = 1; i <= numNodes; ++i) 
    {
        std::cin >> nodeValues[i];
    }

    std::vector<std::vector<unsigned long long>> adjacencyList(numNodes + 1);
    for (int i = 0; i < numEdges; ++i) 
    {
        unsigned long long u, v;
        std::cin >> u >> v;
        adjacencyList[u].push_back(v);
        adjacencyList[v].push_back(u);
    }

    std::vector<bool> visited(numNodes + 1, false);
    unsigned long long totalMinGold = 0;

    for (int startNode = 1; startNode <= numNodes; ++startNode) 
    {
        if (!visited[startNode]) 
        {
            unsigned long long componentMinValue = UINT32_MAX;
            std::queue<unsigned long long> nodesToVisit;
            nodesToVisit.push(startNode);
            visited[startNode] = true;

            while (!nodesToVisit.empty()) 
            {
                unsigned long long currentNode = nodesToVisit.front();
                nodesToVisit.pop();
                componentMinValue = std::min(componentMinValue, nodeValues[currentNode]);

                for (unsigned long long neighbor : adjacencyList[currentNode]) 
                {
                    if (!visited[neighbor]) 
                    {
                        visited[neighbor] = true;
                        nodesToVisit.push(neighbor);
                    }
                }
            }

            totalMinGold += componentMinValue;
        }
    }

    std::cout << totalMinGold << std::endl;

    return 0;
}