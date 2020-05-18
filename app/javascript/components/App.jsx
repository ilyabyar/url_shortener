import React from "react";
import Routes from "../routes/Index";
import Navigation from "./Navigation";
import {BrowserRouter as Router} from "react-router-dom";

export default props => {
  return(
    <Router>
        <Navigation/>
        {Routes}
    </Router>
  )
}
