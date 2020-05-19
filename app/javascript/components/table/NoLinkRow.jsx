import React from "react";
import {Link} from "react-router-dom";

export default () => {
  return (
    <tr>
      <td className="text-center" colSpan={5  }>
        No Links found <Link to="/app/links/new">Create one</Link>
      </td>
    </tr>
  )
}