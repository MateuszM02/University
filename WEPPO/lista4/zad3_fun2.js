module.exports = { add, multadd }
let f1 = require('./zad3_fun1')

function add(x, y) 
{
    return x + y
}

function multadd(x, y, z) 
{
    return f1.mult( x, add(y, z) )
}
