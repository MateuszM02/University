//wersja rekurencyjna
function rec_Fib(n)
{
    if(n <= 1) return 1;
    else return rec_Fib(n - 1) + rec_Fib(n - 2);
}

//wersja iteracyjna
function iter_Fib(n)
{
    let act = 1;
    let prev = 1;
    while(n > 1)
    {
        let temp = act;
        act += prev;
        prev = temp;
        n--;
    }
    return act;
}

for (let index = 10; index <= 40; index++) {
    console.log("n = " + index);
    timePassedRec(index);
    timePassedIter(index);
}

function timePassedRec(i)
{
    console.log("REKURENCJA");
    console.time();
    rec_Fib(i)
    console.timeEnd();
}

function timePassedIter(i)
{
    console.log("ITERACJA");
    console.time();
    iter_Fib(i)
    console.timeEnd();
}
