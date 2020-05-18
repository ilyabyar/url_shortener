import { size, reduce, sortBy}  from 'lodash';
import CountryStatsModel from "./models/CountryStatsModel";

function calculateTotal(countries) {
  return reduce(countries, function(accum, countryStat) {
    return accum += countryStat.attendancesCount;
  }, 0);
}

function getTopCountries(countries, threshold) {
  return sortBy(countries, (countryStat) => { return countryStat.attendancesCount; }).slice(0,threshold);
}

function distributePercentage(countries, total) {
  return countries.
    map((countryStat) => {
      countryStat.attendancesPercentage = 100 * countryStat.attendancesCount / total;
      return countryStat;
    })
}

function createOtherStats(otherSum, otherPercentage) {
  let otherCountryModel = new CountryStatsModel('OtherCountries', {
    alpha: "OC",
    attendancesCount: otherSum,
  });
  otherCountryModel.attendancesPercentage = otherPercentage;
  return otherCountryModel;
}

export default function countryStatsCalculator(statsArray) {
  const threshold = 5;

  if (size(statsArray) === 0) {
    return [];
  }

  let resultStatsArray = statsArray.slice();

  const total = calculateTotal(resultStatsArray);

  resultStatsArray = getTopCountries(resultStatsArray, threshold);
  resultStatsArray = distributePercentage(resultStatsArray, total);
  resultStatsArray = sortBy(resultStatsArray, countryStat => -countryStat.attendancesPercentage)

  if(size(statsArray) > threshold) {
    const topSum = calculateTotal(resultStatsArray);
    const otherSum = total - topSum;
    const otherPercentage = (1 - topSum / total)*100;
    resultStatsArray.push(createOtherStats(otherSum, otherPercentage));
  }

  return resultStatsArray;
};