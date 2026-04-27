export interface Item {
    primary: string;
    secondary?: string;
}

export interface Category {
    title: string;
    items: Item[];
}

export const info: Category[] = [
    {
        title: "Edukacja",
        items: [
            {
                primary: "Queen's University", 
                secondary: "Studia: 1989-1992",
            },
            {
                primary: "University of Pennsylvania",
                secondary: "BSc w fizyce i BA w ekonomii: 1997",
            },
        ]
    },
    {
        title: "Doświadczenie",
        items: [
            {
                primary: "SpaceX", 
                secondary: "Założyciel, przewodniczący i dyrektor techniczny: 2002-obecnie",
            },
            {
                primary: "Tesla, Inc.",
                secondary: "Założyciel i dyrektor generalny: 2004-obecnie",
            },
            {
                primary: "The Boring Company",
                secondary: "Założyciel: 2016-obecnie",
            },
        ]
    },
    {
        title: "Umiejętności",
        items: [
            {
                primary: "HTML", 
            },
            {
                primary: "CSS",
            },
            {
                primary: "JavaScript",
            },
            {
                primary: "AngularJS",
            },
            {
                primary: "C#",
            },
        ]
    },
]