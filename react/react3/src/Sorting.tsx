import React from "react";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
  faSortAlphaAsc,
  faSortAlphaDesc,
  faUnsorted,
} from "@fortawesome/free-solid-svg-icons";
import { Task } from "./App"; // Załóżmy, że ścieżka jest poprawna

interface SortingProps {
  todos: Task[];
  setTodos: React.Dispatch<React.SetStateAction<Task[]>>;
}

function Sorting({ todos, setTodos }: SortingProps) {
  return (
    <div className="filter-div">
      Choose sorting method:
      <FontAwesomeIcon
        icon={faUnsorted}
        className="icon"
        onClick={() => {
          const sortedOG = [...todos].sort((a, b) => a.id - b.id);
          setTodos(sortedOG);
        }}
      />
      <FontAwesomeIcon
        icon={faSortAlphaAsc}
        className="icon"
        onClick={() => {
          const sortedAsc = [...todos].sort((a, b) =>
            a.task.localeCompare(b.task)
          );
          setTodos(sortedAsc);
        }}
      />
      <FontAwesomeIcon
        icon={faSortAlphaDesc}
        className="icon"
        onClick={() => {
          const sortedDesc = [...todos].sort((a, b) =>
            b.task.localeCompare(a.task)
          );
          setTodos(sortedDesc);
        }}
      />
    </div>
  );
}

export default Sorting;
