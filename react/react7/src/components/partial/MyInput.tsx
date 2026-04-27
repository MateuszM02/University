import React from "react";
import * as Label from "@radix-ui/react-label";
import * as RadioGroup from "@radix-ui/react-radio-group";

import useStyles from "../../styling/styles";

function TextInput({ onChange, value, title, type = "text", placeholder = "" }) {
    const css = useStyles();

    return (
        <div className={css.Div}>
            <input 
                className={css.Input} 
                onChange={onChange}
                value={value}
                title={title} 
                type={type}
                placeholder={placeholder}
                required={true} />
        </div>
    );
}

function RadioGroupInput({onChange, value, values}) {
    const css = useStyles();

    return (
        <div className={css.Div}>
            <RadioGroup.Root 
                className={css.RadioGroupRoot} 
                onValueChange={onChange} 
                value={value}>
                {values.map((possValue: string) => 
                    <div className={css.Div}>
                        <RadioGroup.Item 
                            className={css.RadioGroupItem} 
                            value={possValue} 
                            id={possValue}>
                            <RadioGroup.Indicator className={css.RadioGroupIndicator} />
                        </RadioGroup.Item>
                        <Label.Root className="TODO" htmlFor={possValue}>
                            {possValue}
                        </Label.Root>
                    </div>
                )}
            </RadioGroup.Root>
        </div>
    )
}

export default function MyInput({ InputElement, onChange, value, title, ...props }) {
    const css = useStyles();

    return (
        <>
            <div className={css.Div}>
                <Label.Root className={css.LabelRoot}>
                    {title}
                </Label.Root>
            </div>
            <InputElement onChange={onChange} value={value} title={title} {...props} />
        </>
    );
}

export { RadioGroupInput, TextInput };