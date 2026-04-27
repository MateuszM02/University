import React from 'react';
import { AppBar, Toolbar, IconButton, Tooltip, Stack, Typography } from '@mui/material';
import logo from '../data/logo.png'; // Importowanie logo
import useStyles from '../styles';
import UserAvatar from './UserAvatar';

export default function Header() {
  const classes = useStyles();
  const [auth] = React.useState(false);
  const [user] = React.useState(undefined);

  return (
    <div className={classes.root}>
      <AppBar className={classes.appBar}>
        <Toolbar>
          <Typography variant="h6" component="div" sx={{flexGrow: 1}}>
            <img src={logo} alt="Logo Sklepu" className={classes.logo} />
          </Typography>
          <Stack direction="row" justifyContent="flex-end">
            <Tooltip title={auth ? `Zalogowany jako: ${user}` : "Nie zalogowano"} enterDelay={300} leaveDelay={200} >
                <IconButton
                  size="large"
                  color="inherit"
                >
                <UserAvatar user={user}/>
                </IconButton>
              </Tooltip>
          </Stack>
        </Toolbar>
      </AppBar>
    </div>
  );
}
