import React from "react";
import LinkModel from "../common/models/LinkModel";
import ApiService from "../common/ApiService";
import LinkTable  from './table/LinkTable';

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
    return <LinkTable links={this.state.links}/>
  }
}
export default Links;