/** @jsxImportSource @emotion/react */
import { useTheme } from '@emotion/react';
import { ITheme } from "../themes";

interface IProps {
  member: {
    id: number;
    image: string;
    name: string;
    position: string;
    bio: string;
  };
}

export default function MemberListItem({
  member: { id, image, name, position, bio },
}: IProps) {
  const theme = useTheme() as ITheme;

  return (
    <div key={id} css={{
      flex: "0 0 calc(33.33% - 20px)",
      padding: "20px",
      margin: "10px",
      textAlign: "center",
      backgroundColor: theme.teamMemberBackground,
      color: theme.teamMemberColor,
      
      img: {
        borderRadius: "50%",
        marginBottom: "20px",
      },
      
      h3: {
        marginBottom: "10px",
        display: "inline-block",
      }
    }}>
      <img src={image} alt={name} />
      <div>
        <h3>{name}</h3>
        <p>{position}</p>
        <p>{bio}</p>
      </div>
    </div>
  );
}
