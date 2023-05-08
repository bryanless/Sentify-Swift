//
//  Int+ext.swift
//  
//
//  Created by Bryan on 07/01/23.
//

extension Int {
  // Seconds to hours minutes seconds: https://stackoverflow.com/a/26794841/18764882
  public func secondsToHoursMinutesSeconds() -> (Int, Int, Int) {
    return (self / 3600, (self % 3600) / 60, (self % 60))
  }

  // Formatting numbers https://stackoverflow.com/a/48371527
  public func formatNumber() -> String {
    let num = abs(Double(self))
    let sign = (self < 0) ? "-" : ""

    switch num {
    case 1_000_000_000...:
      var formatted = num / 1_000_000_000
      formatted = formatted.reduceScale(to: 1)
      return "\(sign)\(formatted)B"

    case 1_000_000...:
      var formatted = num / 1_000_000
      formatted = formatted.reduceScale(to: 1)
      return "\(sign)\(formatted)M"

    case 1_000...:
      var formatted = num / 1_000
      formatted = formatted.reduceScale(to: 1)
      return "\(sign)\(formatted)K"

    case 0...:
      return "\(self)"

    default:
      return "\(sign)\(self)"
    }
  }
}
