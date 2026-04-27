import React from "react";
import * as Tabs from "@radix-ui/react-tabs";

import useStyles from "../styling/styles";
import Account from "./Account";
import Password from "./Password";
import Preferences from "./Preferences";
import SubmitButton from "./partial/SubmitButton";

export default function TabSelector() {
    const css = useStyles();
    const tabs = ["Account", "Password", "Preferences"];

    const handleSubmit = (event) => {
        //event.preventDefault();
        // operacje na stanie
    };

    return (
        <Tabs.Root className={css.TabsRoot} aria-orientation="vertical" defaultValue={tabs[0]}>
            <Tabs.List className={css.TabsList}>
                {
                    tabs.map((tabName: string) =>
                        <Tabs.Trigger className={css.TabsTrigger} value={tabName}>
                            {tabName}
                        </Tabs.Trigger>)
                }
            </Tabs.List>
            <form onSubmit={handleSubmit}>
                <Tabs.Content className={css.TabsContent} value={tabs[0]}>
                    <Account />
                </Tabs.Content>
                <Tabs.Content className={css.TabsContent} value={tabs[1]}>
                    <Password />
                </Tabs.Content>
                <Tabs.Content className={css.TabsContent} value={tabs[2]}>
                    <Preferences />
                </Tabs.Content>
                <SubmitButton />
            </form>
        </Tabs.Root>
    )
}