//
//  DateFormatterAssistant.swift
//  ExchangeRatesForDB2
//
//  Created by user on 12.07.2019.
//  Copyright © 2019 Vlad Veretennikov. All rights reserved.
//

import Foundation

class DateFormatterAssistant {
  static func convertDateToString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM.yyyy"
    let dateString = dateFormatter.string(from: date)
      
    return dateString
  }
}
