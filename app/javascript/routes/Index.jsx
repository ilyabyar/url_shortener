import React from "react";
import { BrowserRouter as Router, Route, Switch } from "react-router-dom";
import NewLink from "../components/NewLink";

export default (
    <Router>
        <Switch>
            <Route path="/" exact component={NewLink} />
        </Switch>
    </Router>
);