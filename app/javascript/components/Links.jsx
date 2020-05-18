import React from "react";
import { Link } from "react-router-dom";
import ReactCountryFlag from "react-country-flag"
import countryStatsCalculator from "../common/countryStatsCalculator";
import LinkModel from "../common/models/LinkModel";
import ApiService from "../common/ApiService";

class Links extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      links: []
    };
  }

  componentDidMount() {
    ApiService.linksList().then(response => {
      if (response.ok) {
        return response.json();
      }
      throw new Error("Network response was not ok.");
    }).then(response => {
      let linkModelsArray = response.data.map((link) => {
        return new LinkModel(link)
      });
      this.setState({ links: linkModelsArray })
    })
  }
  render() {
    const { links } = this.state;

    const allLinks = links.map((link) => {
      let statsWithPercentage = countryStatsCalculator(link.countryStats).map(countryStat => {
          return(
            <li key={countryStat.alpha}>
              <span>
                <ReactCountryFlag
                  className="emojiFlag"
                  countryCode={countryStat.alpha}
                  style={{
                    fontSize: '2em',
                    lineHeight: '2em',
                  }}
                  aria-label={countryStat.name}
                />
              </span>
              <span>{countryStat.name}</span>
              <span>{countryStat.attendancesPercentage.toFixed(2) + '%'}</span>
            </li>
          )
        }
      )
      return (
        <li key={link.id}>
          <p><a href={link.shortUrl}>{link.shortUrl}</a></p>
          <p>Attendances: {link.attendancesCount}</p>
          <p>Uniq Attendances: {link.uniqAttendancesCount}</p>
          Statistics per country: <ul>{statsWithPercentage}</ul>
        </li>
      )
    });
    const nolink = (
      <div className="vw-100 vh-50 d-flex align-items-center justify-content-center">
        <h4>
          No Links found <Link to="/app/links/new">Create one</Link>
        </h4>
      </div>
    );

    return (
      <React.Fragment>
        <div className="py-5">
          <main className="container">
            <div className="row">
              <ul>
                {links.length > 0 ? allLinks : nolink}
              </ul>
            </div>
          </main>
        </div>
      </React.Fragment>
    );
  }
}
export default Links;