import React from "react";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
  faFilter,
  faFilterCircleXmark,
} from "@fortawesome/free-solid-svg-icons";

interface FilteringProps {
  checkFilter: boolean;
  setCheckFilter: React.Dispatch<React.SetStateAction<boolean>>;
  nameFilter: boolean;
  setNameFilter: React.Dispatch<React.SetStateAction<boolean>>;
  name: string;
  setName: React.Dispatch<React.SetStateAction<string>>;
}

const Filtering: React.FC<FilteringProps> = ({
  checkFilter,
  setCheckFilter,
  nameFilter,
  setNameFilter,
  name,
  setName,
}) => {
  return (
    <>
      <div className="filter-div">
        <FontAwesomeIcon
          icon={checkFilter ? faFilterCircleXmark : faFilter}
          className="icon"
          onClick={() => setCheckFilter(!checkFilter)}
        />
        <label>
          {checkFilter ? "Show finished tasks" : "Hide finished tasks"}
        </label>
      </div>
      <div className="filter-div">
        <FontAwesomeIcon
          icon={nameFilter ? faFilterCircleXmark : faFilter}
          className="icon"
          onClick={() => setNameFilter(!nameFilter)}
        />
        <input
          type="text"
          value={name}
          onChange={(e) => setName(e.target.value)}
          className="text-input"
          placeholder="Filter tasks by name"
        />
      </div>
    </>
  );
};

export default Filtering;
