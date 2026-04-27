import React, { useState } from "react";
import * as Slider from "@radix-ui/react-slider";
import * as Label from "@radix-ui/react-label";

import useStyles from "../../styling/styles";

export default function FrequencySlider() {
    const css = useStyles();
    const defaultValue = 50;
    const [frequency, setFrequency] = useState(defaultValue);
    const handleFrequencyChange = (event) => setFrequency(event.target.value);

    return (
        <>
            <div className={css.Div}>
                <Label.Root className={css.LabelRoot} htmlFor="notif">
                    Notification frequency
                </Label.Root>
            </div>
            <Slider.Root 
                className={css.SliderRoot} 
                id="notif" 
                onChange={handleFrequencyChange}
                defaultValue={[frequency]} 
                min={0}
                max={100}
                step={1}>
                <Slider.Track className={css.SliderTrack}>
                    <Slider.Range className={css.SliderRange} />
                </Slider.Track>
                <Slider.Thumb className={css.SliderThumb} />
            </Slider.Root>
        </>
    );
}