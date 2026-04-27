#include <iostream>
#include <cmath>

int main() {
    long long maxWeight, redJoy, blueJoy, redWeight, blueWeight;
    long long result = 0; 
    
    std::cin >> maxWeight >> redJoy >> blueJoy >> redWeight >> blueWeight;
    
    int limit = static_cast<int>(std::sqrt(static_cast<double>(maxWeight)));
    
    for (int redCount = 0; redCount <= limit && maxWeight - redCount * redWeight > 0; redCount++)
        result = std::max(result, redCount * redJoy + (maxWeight - redCount * redWeight) / blueWeight * blueJoy);
    
    for (int blueCount = 0; blueCount <= limit && maxWeight - blueCount * blueWeight > 0; blueCount++)
        result = std::max(result, blueCount * blueJoy + (maxWeight - blueCount * blueWeight) / redWeight * redJoy);
    
    std::cout << result << std::endl;
    
    return 0;
}