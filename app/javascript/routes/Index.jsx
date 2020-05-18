import React from "react";
import {  Route, Switch } from "react-router-dom";
import NewLink from "../components/NewLink";
import Links from "../components/Links";

export default (
        <Switch>
            <Route path="/" exact component={NewLink} />
            <Route path="/app/links/new" exact component={NewLink} />
            <Route path="/app/links" exact component={Links} />
        </Switch>
);