type User = {
    name: string;
    age: number;
    occupation?: string;
    type: string; //nowe pole
}
type Admin = {
    name: string;
    age: number;
    role?: string;
    type: string; //nowe pole
}
    
export type Person = User & Admin;

//------------------------------------------------------------------------

export const persons: Person[] = [
    {
    name: 'Jan Kowalski',
    age: 17,
    occupation: 'Student',
    type: 'user' //nowe pole
    },
    {
    name: 'Tomasz Malinowski',
    age: 20,
    role: 'Administrator',
    type: 'admin' //nowe pole
    }
];

//------------------------------------------------------------------------

export function isAdmin(person: Person) {
    return person.type === 'admin';
}
    
export function isUser(person: Person) {
    return person.type === 'user';
}
    
//------------------------------------------------------------------------

export function logPerson(person: Person) {
    let additionalInformation: string | undefined;
    if (isAdmin(person)) {
        additionalInformation = person.role;
    }
    if (isUser(person)) {
        additionalInformation = person.occupation;
    }
    console.log(` - ${person.name}, ${person.age}, ${additionalInformation}`);
}

logPerson(persons[0]);
logPerson(persons[1]);
