// npm install react-router-dom
// npm install @mui/material @emotion/react @emotion/styled
// npm install @mui/icons-material
// npm install @material-ui/core

import React from "react";
import ReactDOM from "react-dom/client";
import {
  BrowserRouter,
  Route,
  Routes,
} from "react-router-dom";

import Home from "./routes/Home";
import RootLayout from "./layout/RootLayout";
import AboutMe from "./routes/AboutMe/AboutMe";
import Projects from "./routes/Projects/Projects";
import { ThemeProvider } from "@emotion/react";
import { theme } from "./styling/themes";
//import { useRouteContext } from "./routes/routes";

const jsxRouter = (
  <BrowserRouter>
    <Routes>
      <Route path="/" element={<RootLayout />}>
        <Route path="/" element={<Home />} />
        <Route path="/aboutMe" element={<AboutMe />} />
        <Route path="/projects" element={<Projects />} />
      </Route>
    </Routes>
  </BrowserRouter>
);

ReactDOM.createRoot(document.getElementById("root")!).render(
  <React.StrictMode>
    <ThemeProvider theme={theme}>
      {jsxRouter}
    </ThemeProvider>
  </React.StrictMode>
);