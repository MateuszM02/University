import React, { useState } from "react";
import * as Switch from "@radix-ui/react-switch";
import * as Label from "@radix-ui/react-label";

import useStyles from "../../styling/styles";

export default function DataSwitch() {
    const css = useStyles();
    const [additionalData, setAdditionalData] = useState(false);
    const handleAdditionalDataChange = (event) => setAdditionalData(event.target.value);

    return (
        <>
            <div className={css.Div}>
                <Label.Root className={css.LabelRoot} htmlFor="add-data">
                    Collect additional data
                </Label.Root>
            </div>
            <div className={css.Div}>
                <Switch.Root 
                    className={css.SwitchRoot} 
                    id="add-data"
                    defaultChecked={additionalData}
                    onChange={handleAdditionalDataChange}>
                    <Switch.Thumb className={css.SwitchThumb} />
                </Switch.Root>
            </div>
        </>
    );
}