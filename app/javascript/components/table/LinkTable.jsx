import React from "react";
import {sortBy} from "lodash";
import countryStatsCalculator from "../../common/countryStatsCalculator";
import NoLinkRow from "./NoLinkRow";
import LinkRow from "./LinkRow";
import CountryStats from "../CountryStats";

export default (props) => {
  const links = props.links;

  const allLinks = sortBy(links, link => -link.attendancesCount).map((link) => {
    let statsWithPercentage = countryStatsCalculator(link.countryStats).map(countryStat => {
      return <li key={countryStat.alpha}><CountryStats countryStat={countryStat}/></li>
      }
    )

    return (
      <LinkRow key={link.id} link={link} statsWithPercentage={statsWithPercentage}/>
    )
  });

  return (
    <main className="mt-5 container">
      <table className="table table-bordered">
        <thead>
        <tr>
          <th scope="col">Short URL</th>
          <th scope="col">Original URL</th>
          <th scope="col">Attendances</th>
          <th scope="col">Uniq Attendances</th>
          <th scope="col">Country Stats</th>
        </tr>
        </thead>
        <tbody>
          {links.length > 0 ? allLinks : <NoLinkRow/>}
        </tbody>
      </table>
    </main>
  );
}