import React from "react";

export default (props) => {
  const link = props.link;
  const statsWithPercentage = props.statsWithPercentage;
  const noStats = <span>No stats</span>;
  const truncatedUrl = link.url.length > 15 ? link.url.substring(0, 10) + "..." : link.url;
  return (
    <tr>
      <td><a href={link.shortUrl}>{link.shortUrl}</a></td>
      <td><a href={link.url}>{truncatedUrl}</a></td>
      <td>{link.attendancesCount}</td>
      <td>{link.uniqAttendancesCount}</td>
      <td>{statsWithPercentage.length === 0 ? noStats : <ul>{statsWithPercentage}</ul>}</td>
    </tr>
  )
}