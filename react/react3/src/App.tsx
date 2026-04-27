import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faEdit } from "@fortawesome/free-solid-svg-icons";

import { useState, useEffect } from "react";
import "./styles.css";

import Todo from "./Todo";
import TodoForm from "./TodoForm";
import { exampleTodos } from "./ExampleTodos";
import Filtering from "./Filtering";
import Sorting from "./Sorting";
import Pagination from "./Pagination";

export interface Task {
  id: number;
  task: string;
  isCompleted: boolean;
}

export default function TodoWrapper() {
  const [todos, setTodos] = useState<Task[]>(exampleTodos); // zmiana początkowej wartości
  const [checkFilter, setCheckFilter] = useState(false); // czy filtr checka wlaczony?
  const [name, setName] = useState(""); // filtrowany tekst
  const [nameFilter, setNameFilter] = useState(false); // czy filtr nazwy wlaczony?
  // nowe dla rozszerzonej wersji
  const [currentPage, setCurrentPage] = useState(1); // numer strony, na początku pierwsza
  const [postsPerPage, setPostsPerPage] = useState(5); // ile elementów na stronie, domyślnie 10

  // nowe do otrzymania listy todos do wyświetlenia na aktualnej stronie
  const filteredTodos = todos.filter(
    (todo: Task) =>
      (!checkFilter || !todo.isCompleted) && // check filter
      (!nameFilter || todo.task.includes(name)) // name filter
  );

  // Efekt uruchamia się tylko wtedy,
  // gdy zmienia się liczba przefiltrowanych lub całkowitych todos
  useEffect(() => {
    // Jeśli liczba przefiltrowanych todos jest inna niż całkowita liczba todos,
    // ustawiamy currentPage na 1
    if (filteredTodos.length !== todos.length) {
      setCurrentPage(1);
    }
  }, [filteredTodos.length, todos.length]);

  const indexOfLastTodo = currentPage * postsPerPage;
  const indexOfFirstTodo = indexOfLastTodo - postsPerPage;

  const currentTodos = filteredTodos.slice(indexOfFirstTodo, indexOfLastTodo);

  // nowe do zmiany strony
  const paginate = (pageNumber: number) => setCurrentPage(pageNumber);

  const addTodo = (todo: Task) => {
    setTodos([...todos, todo]);
  };

  const deleteTodo = (id: number) => {
    setTodos(todos.filter((todo) => todo.id !== id));
  };

  return (
    <div className="App">
      <h1>TODO List</h1>
      <TodoForm addTodo={addTodo} />
      <Filtering
        checkFilter={checkFilter}
        setCheckFilter={setCheckFilter}
        nameFilter={nameFilter}
        setNameFilter={setNameFilter}
        name={name}
        setName={setName}
      />
      {/* nowe, pokazuje aktualną ilość tasków na stronę i pozwala ją zmienić */}
      <div className="filter-div">
        Current tasks per page: {postsPerPage}
        <FontAwesomeIcon
          icon={faEdit}
          className="icon"
          onClick={() => {
            const newValue = prompt("Type new posts per page:");
            // Walidacja, czy wartość jest dodatnią liczbą całkowitą
            if (
              newValue !== null &&
              /^\d+$/.test(newValue) &&
              parseInt(newValue, 10) > 0
            ) {
              setPostsPerPage(parseInt(newValue, 10));
            } else {
              alert("Please enter a positive integer.");
            }
          }}
        />
      </div>
      <Sorting todos={todos} setTodos={setTodos} />
      <div className="filter-div">Tasks to do: {todos.length}</div>
      <div className="TodoList">
        {currentTodos.map((todo: Task) => (
          <Todo todo={todo} deleteTodo={deleteTodo} />
        ))}
      </div>
      <Pagination
        currentPage={currentPage}
        totalPages={Math.ceil(filteredTodos.length / postsPerPage)}
        paginate={paginate}
      />
    </div>
  );
}
