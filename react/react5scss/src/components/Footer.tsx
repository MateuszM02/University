import classes from "../styles/Footer.module.scss";

const Footer = ({ companyName }: { companyName: string }) => {
  return (
    <footer className={classes.footer}>
      <div className={classes.footerContent}>
        <p>
          &copy; {new Date().getFullYear()} {companyName}
        </p>
      </div>
    </footer>
  );
};

export default Footer;
