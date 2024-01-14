function createGenerator(limit) {
  let _state = 0;

  return function () { //wazne - to musi byc return function a nie same return
    return {
      next: function () {
        return {
          done: _state++ >= limit,
          value: _state,
        }
      }
    }
  };
}
var foo = { //to jest iterator zwracajacy 15 pierwszych liczb naturalnych
  [Symbol.iterator]: createGenerator(15)
};

for (let f of foo) console.log(f);
