import { useReducer, ReactNode, createContext } from "react";
import ExampleRecipes from "./ExampleRecipes";
import { IReduceState, IRecipe, RecipeAction, SortingMode } from "./Types";

// reducer ----------------------------------------------------------------------------------------

const initState: IReduceState = {
  allRecipes: ExampleRecipes,
  favoritesFilterEnabled: false,
  phraseFilterEnabled: false,
  searchedPhrase: "",
  sortingMode: SortingMode.DEFAULT
};

function reducer(state: IReduceState, action: RecipeAction): IReduceState {
  switch (action.type) {
    case 'add':
      return {
        ...state,
        allRecipes: [...state.allRecipes, action.payload]
      };
    case 'delete':
      const filteredRecipes = state.allRecipes.filter(recipe => recipe.id !== action.payload.id);
      return {
        ...state,
        allRecipes: filteredRecipes
      };
    case 'toggle':
      const toggledFavorites = state.allRecipes.map(recipe =>
        recipe.id === action.payload.id ? { ...recipe, isFavorite: !recipe.isFavorite } : recipe
      );
      return {
        ...state,
        allRecipes: toggledFavorites
      };
    case 'filter-fav-mode':
      return {
        ...state,
        favoritesFilterEnabled: !state.favoritesFilterEnabled
      };
    case 'filter-phrase-mode':
      return {
        ...state,
        phraseFilterEnabled: !state.phraseFilterEnabled
      };
    case 'set-filter-phrase':
      return {
        ...state,
        searchedPhrase: action.payload.searchedPhrase
      };
    case 'sort':
      let comparator;
      
      switch (action.payload.sortingMode) {
        case SortingMode.DEFAULT:
          comparator = ((a: IRecipe, b: IRecipe) => a.id - b.id);
          break;
        case SortingMode.ASC:
          comparator = ((a: IRecipe, b: IRecipe) => a.name.localeCompare(b.name));
          break;
        case SortingMode.DESC:
          comparator = ((a: IRecipe, b: IRecipe) => b.name.localeCompare(a.name));
          break;
        default:
          return state;
      }
      return {
        ...state,
        sortingMode: action.payload.sortingMode,
        allRecipes: state.allRecipes.sort(comparator)
      };
    default:
      return state;
  }
}

// context ----------------------------------------------------------------------------------------

export const RecipeContext = createContext<{
  state: IReduceState;
  addRecipe: (name: string, description: string, isFavorite: boolean) => void;
  deleteRecipe: (id: number) => void;
  toggleRecipe: (id: number) => void;
  setFavoriteRecipesFilterMode: () => void;
  setPhraseFilterMode: () => void;
  filterPhraseRecipes: (searchedPhrase: string) => void;
  sortRecipes: (sortingMode: SortingMode) => void;
}>({
  state: initState,
  addRecipe: () => { },
  deleteRecipe: () => { },
  toggleRecipe: () => { },
  setFavoriteRecipesFilterMode: () => { },
  setPhraseFilterMode: () => { },
  filterPhraseRecipes: () => { },
  sortRecipes: () => { }
});

// provider ---------------------------------------------------------------------------------------

export default function RecipeProvider({ children }: { children: ReactNode }) {
  const [state, dispatch] = useReducer(reducer, initState);

  function addRecipe(name: string, description: string, isFavorite: boolean) {
    let id = Date.now();
    dispatch({ type: "add", payload: { id, name, description, isFavorite } });
  }

  function deleteRecipe(id: number) {
    dispatch({ type: "delete", payload: { id } });
  }

  function toggleRecipe(id: number) {
    dispatch({ type: "toggle", payload: { id } });
  }

  function setFavoriteRecipesFilterMode() {
    dispatch({ type: "filter-fav-mode", payload: {} });
  }

  function setPhraseFilterMode() {
    dispatch({ type: "filter-phrase-mode", payload: {} })
  }

  function filterPhraseRecipes(searchedPhrase: string) {
    dispatch({ type: "set-filter-phrase", payload: { searchedPhrase } });
  }

  function sortRecipes(sortingMode: SortingMode) {
    dispatch({ type: "sort", payload: { sortingMode } });
  }

  const context = {
    state: state, addRecipe, deleteRecipe, toggleRecipe,
    setFavoriteRecipesFilterMode, setPhraseFilterMode, filterPhraseRecipes, sortRecipes
  }

  return (
    <RecipeContext.Provider value={context}>
      {children}
    </RecipeContext.Provider>
  );
}