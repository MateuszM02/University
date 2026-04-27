import { useState } from "react";
import { Task } from "./App";
import "./styles.css";

export default function TodoForm({
  addTodo,
}: {
  addTodo: (value: Task) => void;
}) {
  const [value, setValue] = useState("");

  const handleSubmit = (e: { preventDefault: () => void }) => {
    e.preventDefault();
    if (value) {
      const todo: Task = {
        id: Date.now(),
        task: value,
        isCompleted: false,
        isVisible: true,
      };
      addTodo(todo);
      setValue("");
    }
  };
  return (
    <form onSubmit={handleSubmit} className="TodoForm">
      <input
        type="text"
        value={value}
        onChange={(e) => setValue(e.target.value)}
        className="text-input"
        placeholder="Type task name"
      />
      <button type="submit" className="button">
        Add
      </button>
    </form>
  );
}
