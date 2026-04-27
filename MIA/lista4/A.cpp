#include <iostream>
#include <unordered_map>

int main()
{
    std::unordered_map<std::string, std::string> users; // currentName, originalName
    std::string oldName, newName;
    int q;

    std::cin >> q;

    for (int i = 0; i < q; i++)
    {
        std::cin >> oldName >> newName;

        auto it = users.find(oldName);
        if (it != users.end())
        {
            const auto originalName = it->second;
            users.erase(it);
            users[newName] = originalName;
        }
        else
        {
            users[newName] = oldName;
        }
    }

    std::cout << users.size() << std::endl;

    for (const auto& pair : users)
    {
        std::cout << pair.second << " " << pair.first << std::endl;
    }

    return 0;
}