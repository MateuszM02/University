import photoSrc from "../images/profilowe.jpg";
import "../styles.css";

function Photo() {
  return (
    <div className="photo">
      <img src={photoSrc} />
      <h1>Mateusz Mazur</h1>
    </div>
  );
}

export default Photo;
