module.exports = { mult, printadd } //pozwala na cykle z drugim plikiem
let f2 = require('./zad3_fun2')

function mult(x, y) 
{
    return x * y
}

function printadd(x, y) 
{
    console.log(f2.add(x, y))
}

// module.exports = { mult, printadd } - wtedy multadd z drugiego pliku nie zadziala
