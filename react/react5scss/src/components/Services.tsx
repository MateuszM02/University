type Services = {
    id: number,
    name: string,
    description: string
}

const Services = ({services} : {services: Services[]}) => {
    return (
        <ul>
            {services.map((service) => (
                <li key={service.id}>
                    <h3>{service.name}</h3>
                    <p>{service.description}</p>
                </li>
            ))}
        </ul>
    );
};

export default Services;