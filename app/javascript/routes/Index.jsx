import React from "react";
import { BrowserRouter as Router, Route, Switch } from "react-router-dom";
import NewLink from "../components/NewLink";
import Links from "../components/Links";

export default (
    <Router>
        <Switch>
            <Route path="/" exact component={NewLink} />
            <Route path="/app/links/new" exact component={NewLink} />
            <Route path="/app/links" exact component={Links} />
        </Switch>
    </Router>
);