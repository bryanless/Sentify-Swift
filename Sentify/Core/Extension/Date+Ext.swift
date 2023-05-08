//
//  Date+Ext.swift
//  
//
//  Created by Bryan on 02/02/23.
//

import Foundation

extension Date {

  // Format Date: https://gist.github.com/rl-pavel/68a53147363a417995b04f2ecab041e1
  // MARK: - Helper types

  public enum DateFormatComponents: String {
    /// 1997
    case yearFull = "yyyy"
    /// 97 (1997)
    case yearShort = "yy"

    /// 7
    case monthDigit = "M"
    /// 07
    case monthDigitPadded = "MM"
    /// Jul
    case monthShort = "MMM"
    /// July
    case monthFull = "MMMM"
    /// J (July)
    case monthLetter = "MMMMM"

    /// 5
    case dayOfMonth = "d"

    /// Sat
    case weekdayShort = "EEE"
    /// Saturday
    case weekdayFull = "EEEE"
    /// S (Saturday)
    case weekdayLetter = "EEEEE"

    /// Localized **13** or **1 PM**, depending on the locale.
    case hour = "j"
    /// 20
    case minute = "m"
    /// 08
    case second = "ss"

    /// CST
    case timeZone = "zzz"
    /// **Central Standard Time** or **CST-06:00** or if full name is unavailable.
    case timeZoneFull = "zzzz"
  }

  // MARK: - Date Math

  public func advance(_ component: Calendar.Component, by value: Int, calendar: Calendar = Calendar.current) -> Date? {
    return calendar.date(byAdding: component, value: value, to: self)
  }

  public func isSame(_ granularity: Calendar.Component, as other: Date, calendar: Calendar = Calendar.current) -> Bool {
    return calendar.compare(self, to: other, toGranularity: granularity) == .orderedSame
  }

  // MARK: - Date Formatting

  public func format(
    with components: [DateFormatComponents],
    in timeZone: TimeZone? = .current,
    using dateFormatter: DateFormatter = DateFormatter(),
    locale: Locale = .current) -> String? {
    let template = components.map(\.rawValue).joined(separator: " ")

    guard let localizedFormat = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: locale) else {
      return nil
    }

    dateFormatter.timeZone = timeZone
    dateFormatter.dateFormat = localizedFormat

    return dateFormatter.string(from: self)
  }

  // MARK: Interval
  /// Compare date interval between two date and a distance in seconds.
  ///
  /// If unspecified, the current date is used with distance of 24 hours.
  public func isExpired(
    by date: Date = Date(),
    from distance: Double = 24 * 3600) -> Bool {
      return abs(self.timeIntervalSinceNow) > distance
    }
}
