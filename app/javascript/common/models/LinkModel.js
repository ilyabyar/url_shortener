import CountryStatsModel from './CountryStatsModel'

class LinkModel {
  constructor(data) {
    const attributes = data.attributes;
    this.id = data.id;
    this.url = attributes.url;
    this.attendancesCount = attributes.attendancesCount;
    this.shortUrl = attributes.shortUrl;
    this.uniqAttendancesCount = attributes.uniqAttendancesCount;
    this.countryStats = Object.entries(attributes.countryStats).map((singleCountryEntry) => {
      return new CountryStatsModel(singleCountryEntry[0], singleCountryEntry[1])
    });
  }
}

export default LinkModel;
