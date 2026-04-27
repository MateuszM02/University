import phoneSrc from "../images/phoneImage.png";
import emailSrc from "../images/email_Icon.png";
import GithubLogoSrc from "../images/githubLogo.png";
import "../styles.css";

function Phone() {
  const phoneNumber = "123-456-7890";
  return (
    <tr>
      <td>
        <img src={phoneSrc} alt="phone" />
      </td>
      <td>{phoneNumber}</td>
    </tr>
  );
}

function Email() {
  const email = "331146@uwr.edu.pl";
  return (
    <tr>
      <td>
        <img src={emailSrc} alt="email" />
      </td>
      <td>{email}</td>
    </tr>
  );
}

function Github() {
  const githubName = "MateuszM02";
  return (
    <tr>
      <td>
        <img src={GithubLogoSrc} alt="github" />
      </td>
      <td>
        <label>{githubName}</label>
      </td>
    </tr>
  );
}

function Contact() {
  return (
    <div className="contact">
      <table>
        <Phone />
        <Email />
        <Github />
      </table>
    </div>
  );
}

export default Contact;
