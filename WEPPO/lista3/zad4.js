function sum(...args) {
    let sum = 0
    for (var i = 0; i < arguments.length; i++) {
        sum += arguments[i];
    }
    return sum
}

console.log(sum()) //0
console.log(sum(1)) //1
console.log(sum(1, 2)) //3
console.log(sum(1, 2, 3)) //6
console.log(sum(1, 2, 3, 4)) //10
console.log(sum(1, 2, 3, 4, 5)) //15
