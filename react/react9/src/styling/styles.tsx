import { makeStyles } from "@material-ui/core/styles";
import { Theme } from "@mui/material";

const useStyles = makeStyles((theme: Theme) => ({
    // 1. Material UI styles ---------------------------------------------
    Tile: {
        cursor: "pointer",
        width: "250px",
        height: "250px",
        backgroundColor: theme.palette.primary.main,
        color: "red",
    },

    Category: {
        marginBottom: "10px",
    },

    Image: {
        width: "200px", 
        height: "200px", 
        margin: "auto", 
        borderRadius: "50%",
    },
}));

export default useStyles;