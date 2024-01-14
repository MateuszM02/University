type User = {
    name: string;
    age: number;
    occupation?: string; //dodanie ?
}
type Admin = {
    name: string;
    age: number;
    role?: string; //dodanie ?
}
    
export type Person = User & Admin; //zmiana z | na &

//------------------------------------------------------------------------

export const persons: Person[] = [
    {
    name: 'Jan Kowalski',
    age: 17,
    occupation: 'Student'
    },
    {
    name: 'Tomasz Malinowski',
    age: 20,
    role: 'Administrator'
    }
];

//------------------------------------------------------------------------

function logPerson(person: Person) {
    let additionalInformation: string | undefined; //zmiana ze string
    if (person.role) {
        additionalInformation = person.role;
    } else {
        additionalInformation = person.occupation;
    }
    console.log(`- ${person.name}, ${person.age}, ${additionalInformation}`);
    }
logPerson(persons[0]);
logPerson(persons[1]);
