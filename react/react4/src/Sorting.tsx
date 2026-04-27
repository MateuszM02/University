import useRecipes from "./UseRecipes";
import { SortingMode } from "./Types";

import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
  faSortAlphaAsc,
  faSortAlphaDesc,
  faUnsorted,
} from "@fortawesome/free-solid-svg-icons";

export default function Sorting() {
    const { sortRecipes } = useRecipes();

    return (
        <div className="filter-div">
            Choose sorting method:
            <FontAwesomeIcon
                icon={faUnsorted}
                className="icon"
                onClick={() => {
                    sortRecipes(SortingMode.DEFAULT);
                }}
        />
        <FontAwesomeIcon
            icon={faSortAlphaAsc}
            className="icon"
            onClick={() => {
                sortRecipes(SortingMode.ASC);
            }}
        />
        <FontAwesomeIcon
            icon={faSortAlphaDesc}
            className="icon"
            onClick={() => {
                sortRecipes(SortingMode.DESC);
            }}
        />
    </div>
  );
}