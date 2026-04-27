import React, { useState } from "react";
import * as Accordion from "@radix-ui/react-accordion";
import * as Tabs from "@radix-ui/react-tabs";

import useStyles from "../styling/styles";
import MyInput, { RadioGroupInput, TextInput } from "./partial/MyInput";

export default function Account() {
    const css = useStyles();
    const [name, setName] = useState("");
    const [username, setUsername] = useState("");
    const [gender, setGender] = useState("Male");

    const handleNameChange = (event) => setName(event.target.value);
    const handleUsernameChange = (event) => setUsername(event.target.value);
    const handleGenderChange = (value) => setGender(value);

    return (
        <Tabs.Content className={css.TabsContent} value="Account">
            <Accordion.Root className={css.AccordionRoot} type="multiple">
                <Accordion.Item className={css.AccordionItem} value="Account">
                    <Accordion.Header className={css.AccordionHeader}>
                        Make changes to your account here. Click save when you're done.
                    </Accordion.Header>
                    <fieldset>
                        <MyInput 
                            InputElement={TextInput} 
                            onChange={handleNameChange} 
                            value={name}
                            title="Name" 
                            placeholder="Mateusz Mazur" />
                        <MyInput 
                            InputElement={TextInput} 
                            onChange={handleUsernameChange}
                            value={username}
                            title="Username" 
                            placeholder="@MateuszMazur" />
                        <MyInput 
                            InputElement={RadioGroupInput} 
                            onChange={handleGenderChange}
                            value={gender}
                            title="Gender" 
                            values={["Male", "Female"]} />
                    </fieldset>
                </Accordion.Item>
            </Accordion.Root>
        </Tabs.Content>
    )
}