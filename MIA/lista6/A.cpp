#include <iostream>

int main()
{
    long T, a, b, currentVolume, count;
    std::cin >> T;

    for (unsigned int i = 0; i < T; i++)
    {
        std::cin >> a >> b;

        count = 0;
        currentVolume = std::abs(b - a);
        
        count += currentVolume / 5;
        currentVolume = currentVolume % 5;
        
        switch (currentVolume)
        {
            case 0: break;
            case 1:
            case 2:
                    count++; break;
            default:
                    count+=2; break;
        }

        std::cout << count << std::endl;
    }
    
    return 0;
}