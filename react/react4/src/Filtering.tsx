import useRecipes from "./UseRecipes";

import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
  faFilter,
  faFilterCircleXmark,
} from "@fortawesome/free-solid-svg-icons";

/*
npm install --save @fortawesome/fontawesome-svg-core
npm install --save @fortawesome/free-solid-svg-icons
npm install --save @fortawesome/react-fontawesome
*/

export default function Filtering() {
    const { state, setFavoriteRecipesFilterMode, setPhraseFilterMode, filterPhraseRecipes } = useRecipes();

    return (
    <>
    {/* włączanie filtra ulubionych przepisów */}
      <div className="filter-div">
        <FontAwesomeIcon
          icon={state.favoritesFilterEnabled ? faFilterCircleXmark : faFilter}
          className="icon"
          onClick={() => setFavoriteRecipesFilterMode()}
        />
        <label>
          {state.favoritesFilterEnabled ? "Show all recipes" : "Show favorite recipes"}
        </label>
      </div>
      <div className="filter-div">
        {/* włączanie filtra nazwy/opisu przepisu */}
        <FontAwesomeIcon
          icon={state.phraseFilterEnabled ? faFilterCircleXmark : faFilter}
          className="icon"
          onClick={() => setPhraseFilterMode()}
        />
        {/* ustalanie szukanej frazy */}
        <input
          type="text"
          // value={name}
          onChange={(e) => {
            filterPhraseRecipes(e.target.value);
            }}
          className="text-input"
          placeholder="Filter recipes by name/description"
        />
      </div>
    </>
  );
};