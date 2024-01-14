function Tree(val, left, right) {
    this.left = left;
    this.right = right;
    this.val = val;
}

/*---------------------------------------------------------
generator "wglab" - wersja rekurencyjna z wykladu
---------------------------------------------------------*/

/*Tree.prototype[Symbol.iterator] = function*() {
    yield this.val; 
    if ( this.left ) yield* this.left;
    if ( this.right ) yield* this.right;
}*/

/*---------------------------------------------------------
generator "wszerz" - wersja rekurencyjna
---------------------------------------------------------*/

/*Tree.prototype[Symbol.iterator] = function*() 
{
    yield this.val; 
    if ( this.left ) yield this.left.val;
    if ( this.right ) yield this.right.val;
    if ( this.left && this.left.left ) yield* this.left.left;
    if ( this.left && this.left.right ) yield* this.left.right;
    if ( this.right && this.right.left ) yield* this.right.left;
    if ( this.right && this.right.right ) yield* this.right.right;
}*/

/*---------------------------------------------------------
generator "wszerz" - wersja iteracyjna z kolejka
---------------------------------------------------------*/

Tree.prototype[Symbol.iterator] = function* () 
{
    let queue = [this]
    while (queue.length > 0) {
        let node = queue.splice(0, 1)[0] //wyjmij wezel
        if (node.left && node.right)
            queue.splice(queue.length, 0, node.left, node.right)
        else if (node.left)
            queue.splice(queue.length, 0, node.left)
        else if (node.right)
            queue.splice(queue.length, 0, node.right)
        yield node.val
    }
}

/*---------------------------------------------------------
generator "wszerz" - wersja iteracyjna ze stosem
---------------------------------------------------------*/

/*Tree.prototype[Symbol.iterator] = function* () 
{
    let queue = [this]
    while (queue.length > 0) {
        let node = queue.splice(0, 1)[0] //wyjmij wezel
        if (node.left && node.right)
            queue.splice(0, 0, node.left, node.right)
        else if (node.left)
            queue.splice(0, 0, node.left)
        else if (node.right)
            queue.splice(0, 0, node.right)
        yield node.val
    }
}*/

var root = new Tree(1, new Tree(2, new Tree(3)), new Tree(4))
var root2 = new Tree(11,
    new Tree(21, new Tree(31), new Tree(32)),
    new Tree(22, new Tree(33), new Tree(34)))

console.log("Wartosci root:")
for (var e of root) {
    console.log(e)
}

console.log("\nWartosci root2:")
for (var e of root2) {
    console.log(e)
}
