import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
  faFilter,
  faFilterCircleXmark,
} from "@fortawesome/free-solid-svg-icons";

import "./styles.css";

import Todo from "./Todo";
import TodoForm from "./TodoForm";
import { useState } from "react";

export interface Task {
  id: number;
  task: string;
  isCompleted: boolean;
  isVisible: boolean;
}

export default function TodoWrapper() {
  const [todos, setTodos] = useState<Task[]>([]);
  const [checkFilter, setCheckFilter] = useState(false); // czy filtr checka wlaczony?
  const [name, setName] = useState(""); // filtrowany tekst
  const [nameFilter, setNameFilter] = useState(false); // czy filtr nazwy wlaczony?

  const addTodo = (todo: Task) => {
    setTodos([...todos, todo]);
  };

  const deleteTodo = (id: number) => {
    setTodos(todos.filter((todo) => todo.id !== id));
  };

  const handleNameFilter = (e: React.MouseEvent) => {
    var val = name;
    if (nameFilter) {
      // jesli filtr jest wlaczony i go wylaczamy
      val = "";
    }
    todos.map((todo: Task) => {
      todo.isVisible = todo.task.includes(val);
    });

    //setName("");
    setNameFilter(!nameFilter);
  };

  return (
    <div className="App">
      <h1>TODO List</h1>
      <TodoForm addTodo={addTodo} />
      <div className="filter-div">
        <FontAwesomeIcon
          icon={checkFilter ? faFilterCircleXmark : faFilter}
          className="icon"
          onClick={() => {
            setCheckFilter(!checkFilter);
          }}
        />
        <label>
          {checkFilter ? "Show finished tasks" : "Hide finished tasks"}
        </label>
      </div>
      <div className="filter-div">
        <FontAwesomeIcon
          icon={nameFilter ? faFilterCircleXmark : faFilter}
          className="icon"
          onClick={handleNameFilter}
        />
        <input
          type="text"
          value={name}
          onChange={(e) => setName(e.target.value)}
          className="text-input"
          placeholder="Filter tasks by name"
        />
      </div>
      <div className="filter-div">Tasks to do: {todos.length}</div>
      <div className="TodoList">
        {todos.map(
          (todo: Task) =>
            (!checkFilter || !todo.isCompleted) &&
            todo.isVisible && <Todo todo={todo} deleteTodo={deleteTodo} />
        )}
      </div>
    </div>
  );
}
