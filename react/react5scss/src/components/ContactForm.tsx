import classes from "../styles/ContactForm.module.scss";

const ContactForm = ({handleSubmit} : {handleSubmit: React.FormEventHandler<HTMLFormElement>}) => {
    return (
        <form onSubmit={handleSubmit} className={classes.contactForm}>
            <div className={classes.formGroup}>
              <input type="text" placeholder="Name" required />
            </div>
            <div className={classes.formGroup}>
              <input type="email" placeholder="Email" required />
            </div>
            <div className={classes.formGroup}>
              <textarea rows={5} placeholder="Message" required></textarea>
            </div>
            <button type="submit">Send Message</button>
          </form>
    );
};

export default ContactForm;