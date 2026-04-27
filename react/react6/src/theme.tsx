
import { createTheme } from '@mui/material/styles';
import { blue, red } from '@mui/material/colors';

// A custom theme for this app
const theme = createTheme({
  palette: {
    primary: {
      main: red[300],
    },
    secondary: {
      main: blue[300],
    },
    error: {
      main: red.A400,
    },
  },
});

export default theme;
