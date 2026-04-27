/** @jsxImportSource @emotion/react */
interface IProps {
  name: string;
}

export default function Footer({ name }: IProps) {
  return (
    <footer
      css={{
        padding: "20px 0",
        textAlign: "center",
      }}
    >
      <div>
        <p>
          &copy; {new Date().getFullYear()} {name}
        </p>
      </div>
    </footer>
  );
}
