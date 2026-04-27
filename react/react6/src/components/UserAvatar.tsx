import { AccountCircle } from "@material-ui/icons";
import { Avatar } from "@mui/material";

export default function UserAvatar({ user } : { user : string | undefined }) {
    if (user == undefined)
        return <AccountCircle />

    const firstLetter = user.charAt(0); // Pobranie pierwszej litery nazwy użytkownika
    return  <Avatar> {firstLetter} </Avatar>
  }