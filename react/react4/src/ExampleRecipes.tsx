import { IRecipe } from "./RecipeContext";

const r1: IRecipe = {
    id: 1,
    name: "kompot",
    description: "napój z owoców gotowanych w wodzie",
    isFavorite: false
}

const r2: IRecipe = {
    id: 2,
    name: "pierogi",
    description: "nadziewane kieszonki z ciasta",
    isFavorite: false
}

const r3: IRecipe = {
    id: 3,
    name: "bigos",
    description: "tradycyjne danie z kapusty i mięsa",
    isFavorite: false
}

const r4: IRecipe = {
    id: 4,
    name: "schabowy",
    description: "panierowany kotlet z mięsa wieprzowego",
    isFavorite: true
}

const r5: IRecipe = {
    id: 5,
    name: "rosół",
    description: "bulion mięsny podawany z makaronem",
    isFavorite: true
}

const r6: IRecipe = {
    id: 6,
    name: "gołąbki",
    description: "mięso i ryż zawijane w liście kapusty",
    isFavorite: false
}

const r7: IRecipe = {
    id: 7,
    name: "placki ziemniaczane",
    description: "smażone placki z tartych ziemniaków",
    isFavorite: false
}

const r8: IRecipe = {
    id: 8,
    name: "żurek",
    description: "kwaśna zupa na zakwasie żytnim",
    isFavorite: false
}

const r9: IRecipe = {
    id: 9,
    name: "kotlet mielony",
    description: "mielone mięso formowane w kotlety",
    isFavorite: false
}

const r10: IRecipe = {
    id: 10,
    name: "sernik",
    description: "ciasto z serem twarogowym",
    isFavorite: false
}

const ExampleRecipes: IRecipe[] = [r1, r2, r3, r4, r5, r6, r7, r8, r9, r10];
export default ExampleRecipes;