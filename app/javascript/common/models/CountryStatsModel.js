class CountryStatsModel {
  constructor(name, attributes) {
    this.name = name;
    this.alpha = attributes.alpha;
    this.attendancesCount = attributes.attendancesCount;
  }
}

export default CountryStatsModel;