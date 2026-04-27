/** @jsxImportSource @emotion/react */
import { useTheme } from '@emotion/react';
import { ITheme } from "../themes";

interface IProps {
  id: string;
  h2: string;
  children?: any;
  className?: string;
}

export default function Section({ id, h2, children, className }: IProps) {
  const theme = useTheme() as ITheme;

  return (
    <section id={id} className={className} css={{
      padding: "20px 0",

      h2: {
        fontSize: "2.5em",
        marginBottom: "20px",
        display: "inline-block",
      },

      "&:nth-child(even)": {
        backgroundColor: theme.evenSectionBackground
      },
    }}>
      <div css={{
        maxWidth: "800px",
        margin: "0 auto",
      }}>
        <h2>{h2}</h2>
        {children}
      </div>
    </section>
  );
}
