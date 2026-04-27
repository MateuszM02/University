import { useContext } from "react";
import { RecipeContext } from "./RecipeContext";

export default function useRecipes() {
  const context = useContext(RecipeContext);
  if (!context) {
    throw new Error("useExpense must be used within an ExpenseProvider");
  }
  return context;
}