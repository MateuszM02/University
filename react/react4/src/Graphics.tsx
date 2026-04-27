import { useContext, useState } from "react";
import { RecipeContext } from "./RecipeContext";
import AddRecipeForm from "./AddRecipeForm";
import Filtering from "./Filtering";
import Sorting from "./Sorting";
import Recipe from "./Recipe";
import { IRecipe, SortingMode } from "./Types";

//import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
//import { faEdit } from "@fortawesome/free-solid-svg-icons";

export default function View() {
    const { state } = useContext(RecipeContext);
    const [activeRecipeId, setActiveRecipeId] = useState<number | null>(null);

    const showDetails = (id: number) => {
        setActiveRecipeId(id);
    };

    const hideDetails = () => {
        setActiveRecipeId(null);
    };

    const comparator = (a: IRecipe, b: IRecipe) => {
        switch (state.sortingMode) {
            case SortingMode.DEFAULT:
                return a.id - b.id;    
            case SortingMode.ASC:
                return a.name.localeCompare(b.name);     
            case SortingMode.DESC:
                return b.name.localeCompare(a.name);    
            default:
                return 0;
    }};

    const filteredRecipes = state.allRecipes
        .filter((recipe: IRecipe) => 
            (!state.favoritesFilterEnabled || recipe.isFavorite) &&
            (!state.phraseFilterEnabled || 
                recipe.name.includes(state.searchedPhrase) || 
                recipe.description.includes(state.searchedPhrase)))
         .sort(comparator);
    
    return (
    <div className="App">
        <h1>Recipe Finder</h1>
        <AddRecipeForm />
        <Filtering />
        {/* <div className="filter-div">
            Current recipess per page: {postsPerPage}
            <FontAwesomeIcon
                icon={faEdit}
                className="icon"
                onClick={() => {
                    const newValue = prompt("Type new posts per page:");
                    // Walidacja, czy wartość jest dodatnią liczbą całkowitą
                    if (newValue !== null &&
                        /^\d+$/.test(newValue) &&
                        parseInt(newValue, 10) > 0
                        ) {
                        setPostsPerPage(parseInt(newValue, 10));
                    } else {
                        alert("Please enter a positive integer.");
                    }
                }}
            />
        </div> */}
        <Sorting />
        <div className="filter-div">recipes: {state.allRecipes.length}</div>
        <div className="RecipeList">
            {filteredRecipes.map((recipe: IRecipe) => (
                <Recipe recipe={recipe} 
                    showDetails={showDetails} hideDetails={hideDetails} 
                    isActive={activeRecipeId === recipe.id}/>
            ))}
        </div>
        {/* <Pagination
            currentPage={currentPage}
            totalPages={Math.ceil(filteredRecipes.length / postsPerPage)}
            paginate={paginate}
        /> */}
    </div>
    );
}