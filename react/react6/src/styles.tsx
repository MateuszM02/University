import { makeStyles } from '@material-ui/core/styles';

const useStyles = makeStyles((theme: { spacing: (arg0: number) => any; zIndex: { drawer: number; }; }) => ({
    root: {
      flexGrow: 1,
      width: '100%', // Zapewnia, że Header będzie na całej szerokości strony
    },
    menuButton: {
      marginRight: theme.spacing(2),
    },
    appBar: {
      position: 'sticky', // Ustawienie AppBar jako fixed, aby był zawsze widoczny na górze
      zIndex: theme.zIndex.drawer + 1, // Zapewnia, że AppBar będzie nad innymi elementami
    },
    logo: {
      maxHeight: 50, // Maksymalna wysokość logo
      alignItems: "center",
    },
    // MyTable
    tableContainer: {
      marginTop: theme.spacing(8),
    },

    // AddNewProducts
    iconButton: {
      position: "fixed",
      bottom: "1em",
      right: "1em",
    },

  }));

export default useStyles;