import React from "react";
import { BrowserRouter as Router, Route, Switch } from "react-router-dom";
import AddLink from "../components/AddLink";

export default (
    <Router>
        <Switch>
            <Route path="/" exact component={AddLink} />
        </Switch>
    </Router>
);