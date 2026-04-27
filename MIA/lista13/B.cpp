#include <iostream>
using ll = long long;

struct point
{
	ll x, y;
};

int main()
{
    point a, b, c;
	std::cin >> a.x >> a.y;
	std::cin >> b.x >> b.y;
    std::cin >> c.x >> c.y;

    const ll diff1 = (c.y - a.y) * (b.x - a.x);
    const ll diff2 = (b.y - a.y) * (c.x - a.x);

	if (diff1 > diff2)
		std::cout << "LEFT\n";
	else if (diff1 < diff2)
		std::cout << "RIGHT\n";
	else
		std::cout << "TOWARDS\n";
    return 0;
}