/** @jsxImportSource @emotion/react */

interface IProps {
  name: string;
  slogan: string;
}

export default function Header({ name, slogan }: IProps) {

  return (
    <header id="header" css={{
      padding: "50px 0",
      textAlign: "center",

      "h1": {
        fontSize: "3em",
        marginBottom: "10px",
      },

      "p": {
        fontSize: "1.5em",
      }
    }}>
      <div>
        <h1>{name}</h1>
        <p>{slogan}</p>
      </div>
    </header>
  )
}