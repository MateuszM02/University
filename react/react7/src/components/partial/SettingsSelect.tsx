import React, { useState } from "react";
import * as Select from "@radix-ui/react-select";
import * as Label from "@radix-ui/react-label";
import { ChevronDownIcon, ChevronUpIcon } from '@radix-ui/react-icons';

import useStyles from "../../styling/styles";

export default function SettingsSelect() {
    const css = useStyles();
    const [settings, setSettings] = useState("All");
    const handleSettingsChange = (event) => setSettings(event.target.value);

    return (
        <>
            <div className={css.Div}>
                <Label.Root className={css.LabelRoot}>
                    Notification settings
                </Label.Root>
            </div>
            <div className={css.Div} >
                <Select.Root onValueChange={handleSettingsChange}>
                    <Select.Trigger className={css.SelectTrigger}>
                        <Select.Value placeholder={settings} />
                        <Select.Icon className={css.SelectIcon}>
                            <ChevronDownIcon />
                        </Select.Icon>
                    </Select.Trigger>
                    <Select.Portal>
                        <Select.Content className={css.SelectContent}>
                            <Select.ScrollUpButton className={css.SelectScrollButton}>
                                <ChevronUpIcon />
                            </Select.ScrollUpButton>
                            <Select.Viewport className={css.SelectViewport}>
                                <Select.Group defaultValue={settings}>
                                    <Select.Label />
                                    <Select.Item value="All">
                                        <Select.ItemText />
                                        <Select.ItemIndicator/>
                                    </Select.Item>
                                    <Select.Label />
                                    <Select.Item value="Only followed">
                                        <Select.ItemText />
                                        <Select.ItemIndicator />
                                    </Select.Item>
                                    <Select.Label />
                                    <Select.Item value="None">
                                        <Select.ItemText />
                                        <Select.ItemIndicator />
                                    </Select.Item>
                                </Select.Group>
                            </Select.Viewport>
                            <Select.ScrollDownButton className={css.SelectScrollButton}>
                                <ChevronDownIcon />
                            </Select.ScrollDownButton>
                            <Select.Arrow />
                        </Select.Content>
                    </Select.Portal>
                </Select.Root>
            </div>
        </>
    );
}