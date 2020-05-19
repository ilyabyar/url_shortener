import React from "react";
import {Link} from "react-router-dom";

export default (props) => {
  return (
    <nav className="navbar navbar-expand-lg navbar-light bg-light">
      <Link to="/" className="btn">
        Home
      </Link>
      <Link to="/app/links/new" className="btn">
        New link
      </Link>
      <Link to="/app/links/" className="btn">
        All links
      </Link>
    </nav>
  )
}