/** @jsxImportSource @emotion/react */
import { useTheme } from "@emotion/react";
import { ITheme } from "../themes";

interface IProps {
  post: {
    id: number;
    title: string;
    date: string;
    content: string;
  };
}

const p = {
  marginBottom: "10px"
};

export default function BlogPostListItem({
  post: { id, title, date, content },
}: IProps) {
  const theme = useTheme() as ITheme;

  return (
    <div
      key={id}
      css={{
        borderRadius: "10px",
        padding: "20px",
        textAlign: "left",
        backgroundColor: theme.blogPostBackground,
        color: theme.blogPostColor
      }}
    >
      <h3
        css={{
          marginBottom: "10px"
        }}
      >
        {title}
      </h3>
      <p css={p}>{date}</p>
      <p css={p}>{content}</p>
      <button
        css={{
          border: "none",
          borderRadius: "5px",
          cursor: "pointer",
          padding: "5px 10px",
          transition: "background-color 0.3s ease",
          backgroundColor: "#4caf50",
          color: "#fff",

          "&:hover": {
            backgroundColor: "#45a049"
          }
        }}
      >
        Read More
      </button>
    </div>
  );
}
