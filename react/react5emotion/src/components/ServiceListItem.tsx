interface IProps {
  service: {
    id: number;
    name: string;
    description: string;
  };
}

export default function ServiceListItem({
  service: { id, name, description },
}: IProps) {
  return (
    <li key={id}>
      <h3>{name}</h3>
      <p>{description}</p>
    </li>
  );
}
