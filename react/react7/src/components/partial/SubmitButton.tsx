import React from "react";
import useStyles from "../../styling/styles";

export default function SubmitButton() {
    const css = useStyles();

    return (
        <div className={css.ButtonContainer}>
            <button className={css.Button} type="submit">
                Save changes
            </button>
        </div>
    )
}