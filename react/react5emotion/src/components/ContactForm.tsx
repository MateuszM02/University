/** @jsxImportSource @emotion/react */
import { useTheme } from '@emotion/react';
import { ITheme } from "../themes";

interface IProps {
  handleSubmit: (event: React.FormEvent<HTMLFormElement>) => void;
}

export default function ContactForm({ handleSubmit }: IProps) {
  const theme = useTheme() as ITheme;

  return (
    <form onSubmit={handleSubmit} css={{
      maxWidth: "500px",
      margin: "0 auto",
      padding: "20px",
      borderRadius: "10px",
      display: "flex",
      flexDirection: "column",
      backgroundColor: theme.contactFormBackground,
      color: theme.contactFormColor,
      border: `1px solid ${theme.contactFormBorder}`,
    }}>
      <div className="form-group">
        <input type="text" placeholder="Name" required />
      </div>
      <div className="form-group">
        <input type="email" placeholder="Email" required />
      </div>
      <div className="form-group">
        <textarea rows={5} placeholder="Message" required></textarea>
      </div>
      <button type="submit">Send Message</button>
    </form>
  )
}