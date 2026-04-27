import React from "react";
import * as Accordion from "@radix-ui/react-accordion";
import * as Tabs from "@radix-ui/react-tabs";

import useStyles from "../styling/styles";
import SettingsSelect from "./partial/SettingsSelect";
import FrequencySlider from "./partial/FrequencySlider";
import DataSwitch from "./partial/DataSwitch";

export default function Preferences() {
    const css = useStyles();

    return (
        <Tabs.Content className={css.TabsContent} value="Preferences">
            <Accordion.Root className={css.AccordionRoot} type="multiple">
                <Accordion.Item className={css.AccordionItem} value="Preferences">
                    <Accordion.Header className={css.AccordionHeader}>
                        Change preferences here. Click save when you're done.
                    </Accordion.Header>
                    <fieldset>
                        <SettingsSelect />
                        <FrequencySlider />
                        <DataSwitch />
                    </fieldset>
                </Accordion.Item>
            </Accordion.Root>
        </Tabs.Content>
    )
}