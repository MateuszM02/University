export enum SortingMode {
    DEFAULT = "default",
    ASC = "asc",
    DESC = "desc",
}

export interface IRecipe {
    id: number;
    name: string;
    description: string;
    isFavorite: boolean;
  }
  
  export type IReduceState = {
    allRecipes: IRecipe[],
    favoritesFilterEnabled: boolean,
    phraseFilterEnabled: boolean,
    searchedPhrase: string,
    sortingMode: SortingMode,
  }
  
export type RecipeAction =
    | {
      type: "add";
      payload: {
        id: number,
        name: string,
        description: string,
        isFavorite: boolean,
      };
    }
    | {
      type: "delete";
      payload: {
        id: number;
      };
    }
    | {
      type: "toggle";
      payload: {
        id: number;
      };
    }
    | {
      type: "filter-fav-mode";
      payload: {};
    }
    | {
      type: "filter-phrase-mode",
      payload: {}
    }
    | {
      type: "set-filter-phrase";
      payload: {
        searchedPhrase: string;
      };
    }
    | {
      type: "sort";
      payload: {
        sortingMode: SortingMode
      };
    };