import { useState } from "react";
import useRecipes from "./UseRecipes";
import "./styles.css";

export default function AddRecipeForm() {
  const [name, setName] = useState("");
  const [description, setDescription] = useState("");
  const [isFavorite, setIsFavorite] = useState(false);
  const { addRecipe } = useRecipes();

  return (
    <div
      className="RecipeForm"
      onSubmit={(e) => {
        e.preventDefault();
        if (name.trim() === "" || description.trim() === "") {
          return;
        }
        addRecipe(name, description, isFavorite);
        setName("");
        setDescription("");
        setIsFavorite(false);
      }}
    >
      <form>
        <input
          type="text"
          placeholder="Name"
          className="text-input"
          value={name}
          onChange={(e) => setName(e.target.value)}
        />
        <input
          type="text"
          placeholder="Description"
          className="text-input"
          value={description}
          onChange={(e) => setDescription(e.target.value)}
        />
        <input
          type="checkbox"
          placeholder="isFavorite"
          className="icon"
          checked={isFavorite}
          onChange={(e) => setIsFavorite(e.target.checked)}
        />
        <button type="submit">Add Recipe</button>
      </form>
    </div>
  );
}