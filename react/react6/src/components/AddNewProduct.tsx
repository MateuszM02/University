import { Button, TextField, Dialog, DialogActions, DialogContent, DialogTitle } from "@mui/material";
import { useState } from "react";
import React from "react";
import { IData } from "../data/ExampleData";
import { IconButton } from "@mui/material";
import { AddCircle } from "@mui/icons-material";
import useStyles from "../styles";

interface IProps {
    addProduct: (obj: IData) => void;
}

export default function ProductAddDialog({ addProduct }: IProps) {
    const [open, setOpen] = useState(false);
    const classes = useStyles();

    const handleClickOpen = () => {
        setOpen(true);
    };

    const handleClose = () => {
        setOpen(false);
    };

    const fields = [
        { name: 'name', label: 'Nazwa', type: 'text' },
        { name: 'type', label: 'Typ', type: 'text' },
        { name: 'cost', label: 'Cena (PLN)', type: 'number' },
        { name: 'amountAvailable', label: 'Ilość dostępnych sztuk', type: 'number' },
    ];

    return (
        <React.Fragment>
            <IconButton
                onClick={handleClickOpen}
                color="secondary"
                className={classes.iconButton}
            >
                <AddCircle sx={{ fontSize: "2em"}} />
            </IconButton>
            <Dialog
                open={open}
                onClose={handleClose}
                PaperProps={{
                    component: "form",
                    onSubmit: (event: React.FormEvent<HTMLFormElement>) => {
                        event.preventDefault();
                        const formData = new FormData(event.currentTarget);
                        const formJson = Object.fromEntries(
                            (formData as any).entries()
                        ) as IData;
                        formJson.isAvailable = formJson.amountAvailable !== 0;
                        console.log(formJson);
                        addProduct(formJson);
                        handleClose();
                    },
                }}
            >
                <DialogTitle>Nowy produkt</DialogTitle>
                <DialogContent>
                    {
                        fields.map((field: any) =>
                            <TextField
                                key={field.id}
                                autoFocus={field.id === 'name'}
                                required
                                margin="dense"
                                id={field.name}
                                name={field.name}
                                label={field.label}
                                type={field.type}
                                fullWidth
                                variant="standard"
                            />
                        )
                    }
                </DialogContent>
                <DialogActions>
                    <Button onClick={handleClose}>Anuluj</Button>
                    <Button type="submit">Dodaj</Button>
                </DialogActions>
            </Dialog>
        </React.Fragment>
    );
}
