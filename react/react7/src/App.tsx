import React from 'react'
import TabSelector from './components/TabSelector';
import { ThemeProvider } from '@material-ui/core';

import MyTheme from './styling/theme';

/*
npm install
npm install @mui/material @emotion/react @emotion/styled
npm install @radix-ui/react-icons
npm install @material-ui/core --force
npm install @radix-ui/react-tabs
npm install @radix-ui/react-accordion
npm install @radix-ui/react-label
npm install @radix-ui/react-radio-group
npm install @radix-ui/react-select
npm install @radix-ui/react-slider
npm install @radix-ui/react-switch
*/

function App() {
  return (
    <ThemeProvider theme={MyTheme}>
      <TabSelector/>
    </ThemeProvider>
  )
}

export default App;
