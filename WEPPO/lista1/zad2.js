//sprawdza, czy podana liczba jest podzielna przez kazda ze swoich cyfr oraz jej sume
function isCorrect(x)
{
    let sum = 0;
    let temp = x;
    while (temp > 0) {
        let remainder = temp % 10;
        if (remainder == 0 || x % remainder != 0) {
            return false;
        } else {
            sum += remainder;
            temp /= 10;
            temp = Math.floor(temp);
        }
    }
    if (x % sum != 0) {
        return false;
    }
    return true;
}

for (let index = 1; index < 100000; index++) {
    if(isCorrect(index))
        console.log(index);
}
