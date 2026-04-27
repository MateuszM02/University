import classes from "../styles/TeamMembers.module.scss";

type TeamMember = {
    id: number,
    image: string,
    name: string,
    position: string,
    bio: string
}

const TeamMembers = ({teamMembers} : {teamMembers: TeamMember[]}) => {
    return (
        <div className={classes.teamMembers}>
            {teamMembers.map((member) => (
                <div key={member.id} className={classes.teamMember}>
                    <img src={member.image} alt={member.name} />
                    <div>
                        <h3>{member.name}</h3>
                        <p>{member.position}</p>
                        <p>{member.bio}</p>
                    </div>
                </div>
            ))}
        </div>
    );
};

export default TeamMembers;