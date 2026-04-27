import { IRecipe } from "./Types";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faTrash } from "@fortawesome/free-solid-svg-icons";
import useRecipes from "./UseRecipes";
import { useState } from "react";

export default function Recipe({
  recipe,
  showDetails,
  hideDetails,
  isActive
}: {
  recipe: IRecipe;
  showDetails: (id: number) => void;
  hideDetails: () => void;
  isActive: boolean;
}) {
  const { deleteRecipe } = useRecipes();
  const [checked, setChecked] = useState(false);

  const handleCheck = (e: React.ChangeEvent<HTMLInputElement>) => {
    setChecked(!checked);
    recipe.isFavorite = e.target.checked;
  };

  function changeState(e: React.MouseEvent<HTMLDivElement, MouseEvent>) {
    if (e.target instanceof HTMLInputElement && e.target.type == 'checkbox')
      return;
    if (isActive)
      hideDetails();
    else
      showDetails(recipe.id);
  }

  return (
    <div className={`Recipe ${isActive ? "active" : ""}`} onClick={changeState}>
      {isActive ? (
        <div>
          <div className="centered-label">{recipe.name}</div>
          <div className="centered-label">{recipe.description}</div>
        </div>
      ) : (
        <>
          <input
            type="checkbox"
            checked={recipe.isFavorite}
            onChange={handleCheck}
            placeholder="nice"
            className="dontChangeState"
          />
          <label>{recipe.name}</label>
          <FontAwesomeIcon
            className="icon iconTrash"
            icon={faTrash}
            onClick={(e) => {
              e.stopPropagation();
              deleteRecipe(recipe.id);
            }}
          />
        </>
      )}
    </div>
  );
}
