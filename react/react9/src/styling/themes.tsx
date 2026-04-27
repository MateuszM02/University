import { createTheme } from '@mui/material/styles';
import { blue, green, purple, red } from '@mui/material/colors';

// A custom theme for this app
export const theme = createTheme({
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
    // primary: { 
    //   main: red[300], // background
    //   //light: "", // nav background
    //   dark: "yellow", // tiles #0F1525
    //   //contrastText: "white",
    // },
    // // secondary: { 
    // //   main: blue[300],
    // // },
  },
});