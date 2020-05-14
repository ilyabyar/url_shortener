import React from "react";

class NewLink extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      url: ""
    };

    this.onChange = this.onChange.bind(this);
    this.onSubmit = this.onSubmit.bind(this);
  }

  onChange(event) {
    this.setState({ url: event.target.value });
  }

  onSubmit(event) {
    event.preventDefault();
    const url = "/api/v1/links";
    const urlString = this.state.url;

    if (urlString.length === 0) {
      return;
    }

    const body = {
      link: { url: urlString }
    };

    const token = document.querySelector('meta[name="csrf-token"]').content;
    fetch(url, {
      method: "POST",
      headers: {
        "X-CSRF-Token": token,
        "Content-Type": "application/json"
      },
      body: JSON.stringify(body)
    }).then(response => {
        if (response.ok) {
          return response.json();
        }
        throw new Error("Network response was not ok.");
      })
      .catch(error => console.log(error.message));
  }

  render() {
    return (
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
                  type="text"
                  name="url"
                  id="url"
                  className="form-control"
                  required
                  onChange={this.onChange}
                />
              </div>
              <button type="submit" className="btn btn-primary mt-3">
                Shorten
              </button>
            </form>
          </div>
        </div>
      </div>
    );
  }
}

export default NewLink;