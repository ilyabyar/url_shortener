import { size, reduce, sortBy}  from 'lodash';

export default function countryStatsSelector(statsByCountry) {
  const threshold = 5;

  if (size(statsByCountry) === 0) {
    return [];
  }

    const total = reduce(statsByCountry, function(accum, value) {
      return accum += value.attendancesCount;
    }, 0);


    let topSum = 0;
    let topPercentage = 0;
    let transformedTopStats = sortBy(
          Object.entries(statsByCountry),
          (value) => { return -value[1].attendancesCount; }
        ).
        slice(0,threshold).
        map((pair) => {
          const ratio = 100 * pair[1].attendancesCount / total;
          pair[1].attendancesPercentage = ratio;
          topPercentage += ratio;
          topSum += pair[1].attendancesCount
          return pair;
      })

    transformedTopStats = sortBy(transformedTopStats, country => country[1].attendancesPercentage)

    if(size(statsByCountry) > threshold) {
      transformedTopStats.push(['OtherCountries', {
        alpha: "OC",
        attendancesCount: total - topSum,
        attendancesPercentage: 100 - topPercentage
      }])
    }


    return transformedTopStats;
};