import "./styles.css";

import Photo from "./modules/photo";
import Contact from "./modules/contact";
import AboutMe from "./modules/aboutMe";
import Skills from "./modules/skills";

export default function App() {
  return (
    <div className="App-container">
      <div className="App">
        <Photo />
        <Contact />
        <AboutMe />
        <Skills />
      </div>
    </div>
  );
}
