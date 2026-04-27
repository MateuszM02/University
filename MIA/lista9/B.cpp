#include <deque>
#include <iostream>
#include <map>
#include <vector>

#define visitMap std::map<unsigned short, std::map<unsigned short, bool>>

struct Point 
{
    Point(const unsigned short r, const unsigned short c)
    : row{r}
    , col{c} 
    { }

    unsigned short row;
    unsigned short col;
};

void bfs(const unsigned short initRow, 
         const unsigned short initCol, 
         visitMap& rows, 
         visitMap& cols) 
{
    std::deque<Point> queue;
    queue.emplace_back(initRow, initCol);

    while (!queue.empty()) 
    {
        const auto [row, col] = queue.front();
        queue.pop_front();

        for (auto& [c, wasVisited] : rows[row]) 
        {
            if (!wasVisited) 
            {
                wasVisited = true;
                queue.emplace_back(row, c);
            }
        }

        for (auto& [r, wasVisited] : cols[col]) 
        {
            if (!wasVisited) 
            {
                wasVisited = true;
                queue.emplace_back(r, col);
            }
        }
    }
}

int main() 
{
    unsigned short n, row, col;
    std::cin >> n;

    visitMap rows, cols;
    for (unsigned short i = 0; i < n; ++i) 
    {
        std::cin >> row >> col;
        rows[row][col] = false;
        cols[col][row] = false;
    }

    unsigned short components = 0;

    for (auto& [row, colsMap] : rows) 
    {
        for (auto& [col, wasVisited] : colsMap) 
        {
            if (!wasVisited) 
            {
                bfs(row, col, rows, cols);
                ++components;
            }
        }
    }

    std::cout << components - 1 << std::endl;
    return 0;
}
