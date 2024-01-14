function isPrime(x)
{
    for (let current = 2; current <= Math.sqrt(x); current++) {
        if (x % current == 0) {
            return false;
        }
    }
    return true;
}

for (let n = 1; n < 100000; n++){
    if(isPrime(n))
        console.log(n);
}
