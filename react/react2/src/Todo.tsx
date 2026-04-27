import React, { useState } from "react";
import { Task } from "./TodoWrapper";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faTrash } from "@fortawesome/free-solid-svg-icons";
import "./styles.css";

export default function Todo({
  todo,
  deleteTodo,
}: {
  todo: Task;
  deleteTodo: (id: number) => void;
}) {
  const [checked, setChecked] = useState(false);

  const handleCheck = (e: React.ChangeEvent<HTMLInputElement>) => {
    setChecked(!checked);
    todo.isCompleted = e.target.checked;
    //e.target.checked = !e.target.checked;
  };

  return (
    <div className="Todo">
      <input
        type="checkbox"
        onChange={handleCheck}
        checked={todo.isCompleted}
      />
      <label>{todo.task}</label>
      <FontAwesomeIcon
        className="icon iconTrash"
        icon={faTrash}
        onClick={() => deleteTodo(todo.id)}
      />
    </div>
  );
}
