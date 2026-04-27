import { NavLink, Outlet, useLocation, useNavigate } from "react-router-dom";
import { List, ListItemButton, ListItemText } from '@mui/material';
import { useRouteContext } from "../routes/routes";

export default function RootLayout() {
    const location = useLocation();
    const navigate = useNavigate();
    const paths = useRouteContext();

    return (
        <div>
            <nav>
                <List style={{ display: 'flex', justifyContent: 'center', gap: '20px' }}>
                    <ListItemButton component={NavLink} to={paths.home} state={{ from: location.pathname }}>
                        <ListItemText primary="Home" />
                    </ListItemButton>
                    <ListItemButton component={NavLink} to={paths.aboutMe} state={{ from: location.pathname }}>
                        <ListItemText primary="About me" />
                    </ListItemButton>
                    <ListItemButton component={NavLink} to={paths.projects} state={{ from: location.pathname }}>
                        <ListItemText primary="Projects" />
                    </ListItemButton>
                </List>
            </nav>
            <main>
                <Outlet />
            </main>
        </div>
    );
}