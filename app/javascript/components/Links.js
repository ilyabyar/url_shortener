import React from "react";
import { Link } from "react-router-dom";
import ReactCountryFlag from "react-country-flag"
import countryStatsCalculator from "../common/countryStatsCalculator";

class Links extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      links: []
    };
  }

  componentDidMount() {
    const url = "/api/v1/links";
    fetch(url)
      .then(response => {
        if (response.ok) {
          return response.json();
        }
        throw new Error("Network response was not ok.");
      })
      .then(response => { this.setState({ links: response.data }) })
  }
  render() {
    const { links } = this.state;

    const allLinks = links.map((link) => {
      let a = countryStatsCalculator(link.attributes.countryStats).map(countryArray => {
          return(
            <li key={countryArray[1].alpha}>
              <span>
                <ReactCountryFlag
                  className="emojiFlag"
                  countryCode={countryArray[1].alpha}
                  style={{
                    fontSize: '2em',
                    lineHeight: '2em',
                  }}
                  aria-label={countryArray[0]}
                />
              </span>
              <span>{countryArray[0]}</span>
              <span>{countryArray[1].attendancesPercentage.toFixed(2) + '%'}</span>
            </li>
          )
        }
      )
      return (
        <li key={link.attributes.id}>
          <p><a href={link.attributes.shortUrl}>{link.attributes.shortUrl}</a></p>
          <p>Attendances: {link.attributes.attendancesCount}</p>
          <p>Uniq Attendances: {link.attributes.uniqAttendancesCount}</p>
          Statistics per country: <ul>{a}</ul>
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
        <section className="jumbotron jumbotron-fluid text-center">
          <div className="container py-5">
            <h1 className="display-4">Shortened links</h1>
          </div>
        </section>
        <div className="py-5">
          <main className="container">
            <div className="text-right mb-3">
              <Link to="/app/links/new" className="btn">
                Create New link
              </Link>
            </div>
            <div className="row">
              <ul>
                {links.length > 0 ? allLinks : nolink}
              </ul>
            </div>
            <Link to="/" className="btn btn-link">
              Home
            </Link>
          </main>
        </div>
      </React.Fragment>
    );
  }
}
export default Links;