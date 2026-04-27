import { lighten, makeStyles } from "@material-ui/core/styles";

const useStyles = makeStyles(theme => ({
    // 1. html styles ----------------------------------------------------
    Div: {
        backgroundColor: theme.palette.primary.main,
        display: 'flex', 
        alignItems: 'center',
    },

    ButtonContainer: {
        display: 'flex',
        justifyContent: 'flex-end', // Wyrównuje guziki do prawej strony
    },

    Button: {
        backgroundColor: theme.palette.secondary.light,
        color: theme.palette.secondary.contrastText,
        borderRadius: "4px",
        cursor: "pointer",
    },

    Input: {
        backgroundColor: theme.palette.primary.light,
        color: theme.palette.secondary.dark,
        width: '200px',
        display: 'inline-flex',
        alignItems: 'center',
        justifyContent: 'center',
        borderRadius: '4px',
        padding: '0 10px',
        height: '35px',
        fontSize: '15px',
        lineHeight: 1,
      },

    // 2. Account & Password styles --------------------------------------
    LabelRoot: {
        color: theme.palette.primary.contrastText,
        fontSize: "15px",
        fontWeight: 500,
        lineHeight: "35px",
    },

    TabsRoot: { // MAIN
        backgroundColor: theme.palette.primary.dark,
        color: theme.palette.primary.contrastText,
        display: "flex",
        width: "100%",
        height: "100%",
        justifyContent: "center",
    },

    TabsList: {
        //backgroundColor: "yellow",
        flexDirection: "column",
        display: "flex",
        height: "100px",
    },

    TabsTrigger: {
        backgroundColor: theme.palette.primary.dark,
        color: theme.palette.primary.contrastText,
        fontFamily: "inherit",
        height: "45px",
        fontSize: "15px",
        border: "none",
        cursor: "pointer",

        '&[data-state="active"]': {
            color: 'purple', // Kolor czcionki dla aktywnego tabu
            borderRight: '5px solid purple', // Cienka fioletowa ramka z prawej strony dla aktywnego tabu
        },
    },

    TabsContent: {
        backgroundColor: theme.palette.primary.main,
        padding: "20px",
    },

    AccordionRoot: {
        backgroundColor: theme.palette.primary.main,
        color: theme.palette.primary.contrastText,
        width: "300px",
    },

    AccordionItem: {
        overflow: "hidden",
    },

    AccordionHeader: {
        display: "flex",
    },

    RadioGroupRoot: {
        display: "flex",
        flexDirection: "column", // TODO
        gap: "10px",
    },

    RadioGroupItem: {
        backgroundColor: theme.palette.primary.light,
        width: '25px',
        height: '25px',
        borderRadius: '100%',
        cursor: "pointer",

        '&:hover': {
            borderRadius: "100%",
            backgroundColor: lighten(theme.palette.primary.main, 0.5),
        },
    },

    RadioGroupIndicator: {
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        width: '100%',
        height: '100%',
        position: 'relative',
        '&::after': {
            content: '" "',
            width: "11px",
            height: "11px",
            borderRadius: '50%',
            backgroundColor: theme.palette.primary.main,
            position: 'absolute', // zeby kolko nie bylo jajem
        },
    },
    
    // 4. Preferences styles ---------------------------------------------
    
    SelectTrigger: {
        display: "inline-flex",
        alignItems: "center",
        borderRadius: "4px",
        padding: "0 0 0 15px",
        fontSize: "13px",
        height: "35px",
        gap: "5px",
        backgroundColor: theme.palette.primary.light,
        color: theme.palette.primary.contrastText,
        cursor: "pointer",

        '&::hover': {
            backgroundColor: "yellow",//theme.palette.secondary.dark, // TODO
        },
    },

    SelectIcon: {
        color: theme.palette.primary.contrastText,
    },

    SelectContent: { // TODO
        backgroundColor: theme.palette.primary.light,
        borderRadius: "6px",
        position: 'absolute', // Dodajemy pozycjonowanie absolutne
        top: '100%', // Ustawiamy na dolnej krawędzi elementu wyzwalającego
        left: '0', // Ustawiamy na lewej krawędzi elementu wyzwalającego
        width: '100%', // Opcjonalnie, aby szerokość dopasowała się do elementu wyzwalającego
    },

    SelectViewport: { // TODO
        padding: "5px",
    },

    SelectItemIndicator: { // TODO ????
        position: "absolute",
        left: 0,
        width: "25px",
        display: "inline-flex",
        alignItems: "center",
        justifyContent: "center",
    },

    SelectScrollButton: { // TODO ???
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        height: "25px",
        backgroundColor: theme.palette.primary.light,
        color: "violet",
        cursor: "default",
    },

    // FrequencySlider.tsx
    SliderRoot: {
        position: "relative",
        display: "flex",
        alignItems: "center",
        width: "200px",
        height: "20px",
        cursor: "pointer",
    },
      
    SliderTrack: {
        backgroundColor: theme.palette.primary.light,
        position: "relative",
        flexGrow: 1,
        borderRadius: "9999px",
        height: "5px",
    },
      
    SliderRange: { // TODO ???
        // position: "absolute",
        // backgroundColor: "yellow",
        // borderRadius: "9999px",
        // height: "100%",
    },
      
    SliderThumb: {
        backgroundColor: theme.palette.secondary.dark,
        display: "block",
        width: "20px",
        height: "20px",
        borderRadius: "100%",
    },

    // DataSwitch.tsx
    SwitchRoot: {
        backgroundColor: theme.palette.primary.dark,
        width: "50px",
        height: "25px",
        borderRadius: '9999px',
        position: "relative",
        cursor: "pointer",

        '&[data-state="checked"]': {
            backgroundColor: theme.palette.primary.contrastText,
        },
    },

    SwitchThumb: {
        display: "block",
        width: "21px",
        height: "21px",
        backgroundColor: theme.palette.primary.light,
        borderRadius: '9999px',
        transition: "transform 100ms",
        transform: "translateX(-5.75px) translateY(-0.75px)",
        willChange: "transform",
        '&[data-state="checked"]': {
            transform: 'translateX(19px)',
          },
    },
}));

export default useStyles;