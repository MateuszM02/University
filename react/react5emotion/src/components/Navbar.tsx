/** @jsxImportSource @emotion/react */
import { useTheme } from '@emotion/react';
import { ITheme } from "../themes";

interface IProps {
  links: { [key: string]: string };
  toggleTheme: () => void;
  darkMode: boolean;
}

export default function Navbar({ links, toggleTheme, darkMode }: IProps) {
  const theme = useTheme() as ITheme;

  return (
    <div css={{
      position: "sticky",
      top: "0",
      padding: "10px 0",
      textAlign: "center",
      zIndex: "1000",
      backgroundColor: theme.navbarBackground,

      "a": {
        textDecoration: "none",
        padding: "0 20px",
      }
    }}>
      {Object.entries(links).map(([link, text]) => <a css={{
        color: theme.navbarLinkColor
      }} href={`#${link}`}>{text}</a>)}
      <button onClick={toggleTheme} css={{
        cursor: "pointer",
        padding: "10px 20px",
        transition: "background-color 0.3s ease",
        backgroundColor: theme.themeButtonBackground,
        color: theme.themeButtonColor,
        borderRadius: "5px",

        "&:hover": {
          backgroundColor: theme.themeButtonHoverBackground
        }
      }}>
        {darkMode ? "Light Mode" : "Dark Mode"}
      </button>
    </div>
  )
}