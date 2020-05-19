import React from "react";
import ApiService from "../common/ApiService";

class NewLink extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      url: "",
      shortLink: "",
      errors: []
    };

    this.onChange = this.onChange.bind(this);
    this.onSubmit = this.onSubmit.bind(this);
    this.handleNewUrl = this.handleNewUrl.bind(this);
    this.handleValidationError = this.handleValidationError.bind(this);
  }

  handleNewUrl(shortLink) {
    this.setState({ url: '', shortLink: shortLink, errors: [] });
  }

  handleValidationError(errors) {
    this.setState({ errors: errors });
  }

  onChange(event) {
    this.setState({ url: event.target.value });
  }

  onSubmit(event) {
    event.preventDefault();
    const urlString = this.state.url;

    if (urlString.length === 0) {
      return;
    }

    const body = {
      link: { url: urlString }
    };

    ApiService.createLink(body).then(response => {
        return response.json();
      }).then((responseBody) => {
        if(responseBody.data) {
          this.handleNewUrl(responseBody.data.attributes.shortUrl);
        } else {
          this.handleValidationError(responseBody.errors)
        }
      }).catch(error => console.log(error.message));
  }

  render() {
    const urlValue = this.state.url;
    const shortLink = this.state.shortLink;
    const errors = this.state.errors.map((error) => {
      return(
        <small key={error} className="text-danger">
          {error}
        </small>
      )
    })

    return (
      <React.Fragment>
        <div className="container mt-5">
          <div className="row">
            <div className="col-sm-12 col-lg-6 offset-lg-3">
              <h1 className="font-weight-normal mb-5">
                Please, add your link, that you want to shorten...
              </h1>
              <form onSubmit={this.onSubmit}>
                <div className="form-group">
                  <label htmlFor="url">URL</label>
                  <input
                    placeholder="Shorten your link..."
                    value={urlValue}
                    type="text"
                    name="url"
                    id="url"
                    className="form-control"
                    required
                    onChange={this.onChange}
                  />
                  {errors}
                </div>
                <button type="submit" className="btn btn-primary mt-3">
                  Shorten
                </button>
              </form>
            </div>
          </div>
        </div>
        <div className="container mt-5">
          <div className="row">
            <div className="col-sm-12 col-lg-6 offset-lg-3">
              <a target="_blank" href={shortLink}>{shortLink}</a>
            </div>
          </div>
        </div>
      </React.Fragment>
    );
  }
}

export default NewLink;