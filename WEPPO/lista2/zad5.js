let fruit = {
    name: "Apple",
    cost: 5,
    valid_cost: function(k) {
        return k >= 0
    },
    get GetCost() {
        return this.cost
    },
    
    set SetCost(value) {
        if (value >= 0)
            this.cost = value
    }
}

console.log(fruit)
console.log(fruit.GetCost) //5
fruit.SetCost = 4 //zmienia wartosc zmiennej cost na 4 poprzez uzycie settera SetCost
console.log(fruit.GetCost) //4
fruit.SetCost = -10 //NIE zmienia wartosc zmiennej cost dzieki walidacji danych w SetCost
console.log(fruit.GetCost) //nadal 4

//dodawanie nowych obiektow do fruit

//ZMIENNE

fruit.color = "red" //1 sposob dodania zmiennej
fruit["country"] = "Poland" //2 sposob dodania zmiennej
Object.defineProperty( fruit, "is_tasty", { //3 sposob dodania zmiennej
    get : function() {
    return true;
    }
});

console.log("Wartosci nowych zmiennych: " + fruit.color + ", " + fruit.country + " oraz " + fruit.is_tasty)

//METODY

fruit.is_valid_country = function(name) { //1 sposob dodania metody
    return typeof name == 'string'
},
fruit["is_valid_color"] = function(color) { //2 sposob dodania metody
    return typeof color == 'string'
},
Object.defineProperty( fruit, "name_and_country", { //3 sposob dodania metody
    get : function() {
    return fruit.name + " from " + fruit.country;
    }
});

console.log("Czy dane sa poprawne: " + fruit.is_valid_country("Spain") + ", " + fruit.is_valid_color('Green') + ", " + fruit.is_valid_country(0))
console.log(fruit.name_and_country)

//SETTERY I GETTERY

Object.defineProperty( fruit, "color", { //jedyny sposob dodania wlasciwosci
    get : function() {
    return fruit.color;
    },
    set : function(c) {
        if (typeof c == 'string')
            fruit.color = c
    }
});
