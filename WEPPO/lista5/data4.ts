//zwykly export
export class Person{
    Name: string;
    Surname: string;
    Age : number;
    constructor(n: string, s: string, a: number)
    {
        this.Name = n;
        this.Surname = s;
        this.Age = a;
    }
}

//export default
export default function write(t: any)
{
    console.log(t);
}
