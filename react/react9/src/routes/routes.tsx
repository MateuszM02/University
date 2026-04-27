import { createContext, useContext } from 'react';

export const routePaths = {
    home: '/',
    projects: '/projects',
    aboutMe: '/aboutMe',
};

const RouteContext = createContext(routePaths);

export const useRouteContext = () => useContext(RouteContext);