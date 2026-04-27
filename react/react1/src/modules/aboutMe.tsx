import "../styles.css";

function Info1() {
  const info1 =
    "I am a passionate programmer with 3 year experience working with both \
    frontend (.Net Core and JavaScript) and backend (C++, Java, Rust).";
  return <div>{info1}</div>;
}

function Info2() {
  const info2 =
    "I created multiple projects like online shop, gaming platform, \
  hexapawn game and many more.";
  return <div>{info2}</div>;
}

function Info3() {
  const info3 =
    "I also have AI and ML experience working with python, creating \
    projects like nonogram solver or sudoku solver.";
  return <div>{info3}</div>;
}

function AboutMe() {
  return (
    <div className="aboutMe">
      <h1>About me</h1>
      <Info1 />
      <Info2 />
      <Info3 />
    </div>
  );
}

export default AboutMe;
