import classes from "../styles/Header.module.scss";

const Header = ({name, slogan} : {name: string, slogan: string}) => {
  return (
    <header id={classes.header} className={classes.header}>
        <div className={classes.headerContent}>
          <h1>{name}</h1>
          <p>{slogan}</p>
        </div>
      </header>
    );
};

export default Header;