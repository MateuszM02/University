import React, { useState } from "react";
import * as Accordion from "@radix-ui/react-accordion";
import * as Tabs from "@radix-ui/react-tabs";

import useStyles from "../styling/styles";
import MyInput, { TextInput } from "./partial/MyInput";

export default function Password() {
    const css = useStyles();
    const [oldPassword, setOldPassword] = useState("");
    const [newPassword, setNewPassword] = useState("");
    const [repeatPassword, setRepeatPassword] = useState("none");

    const handleOldPasswordChange = (event) => setOldPassword(event.target.value);
    const handleNewPasswordChange = (event) => setNewPassword(event.target.value);
    const handleRepeatPasswordChange = (event) => setRepeatPassword(event.target.value);

    return (
        <Tabs.Content className={css.TabsContent} value="Password">
            <Accordion.Root className={css.AccordionRoot} type="multiple">
                <Accordion.Item className={css.AccordionItem} value="Password">
                    <Accordion.Header className={css.AccordionHeader}>
                        Change your password here. After saving, you'll be logged out.
                    </Accordion.Header>
                    <fieldset>
                        <MyInput 
                            InputElement={TextInput} 
                            onChange={handleOldPasswordChange} 
                            value={oldPassword}
                            title="Current password" 
                            type="password" />
                        <MyInput 
                            InputElement={TextInput} 
                            onChange={handleNewPasswordChange}
                            value={newPassword}
                            title="New password" 
                            type="password" />
                        <MyInput 
                            InputElement={TextInput} 
                            onChange={handleRepeatPasswordChange}
                            value={repeatPassword}
                            title="Repeat password" 
                            type="password" />
                    </fieldset>
                </Accordion.Item>
            </Accordion.Root>
        </Tabs.Content>
    )
}