import { createTheme } from '@mui/material/styles';
import { blue, red, purple, green } from '@mui/material/colors';

// A custom theme for this app
const MyTheme = createTheme({
  palette: {
    primary: // foreground
    {
      main: blue[300], // tabs background
      light: "white", // background
      dark: "lightcyan", // switch turned off
      contrastText: "black", // tabs font color
    },
    secondary: // background
    {
      main: "plum", // web background
      light: green[100], // submit button background color
      dark: purple[800], // input font color
      contrastText: green[700], // submit button font color
    },
  },
});

export default MyTheme;