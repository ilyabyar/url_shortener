import React from "react";
import ReactCountryFlag from "react-country-flag";

export default (props) => {
  const countryStat = props.countryStat;

  return(
    <React.Fragment>
      <span className="mr-1">
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
      <span className="mr-1">{countryStat.name}</span>
      <span>{countryStat.attendancesPercentage.toFixed(2) + '%'}</span>
    </React.Fragment>
  )
}