// get list of number's digits
List<int> getDigitsOfNumber(int x)
{
    List<int> digits = [];
    while (x > 0)
    {
        digits.Add(x % 10); 
        x /= 10;
    }
    return digits;
}

// check whether x is divisible by all of its digits and its sum
bool isOk(int x)
{
    List<int> digits = getDigitsOfNumber(x);
    foreach (int div in digits)
    {
        if (div == 0 || x % div != 0)
            return false;
    }
    return x % digits.Sum() == 0;
}

// print all number which match conditions
for(int i = 1; i <= 100; i++)
{
    if (isOk(i))
        Console.WriteLine(i);
}