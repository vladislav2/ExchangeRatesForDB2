//
//  DateForRequest.swift
//  ExchangeRatesForDB2
//
//  Created by user on 12.07.2019.
//  Copyright © 2019 Vlad Veretennikov. All rights reserved.
//

import Foundation

class DateForRequest {
  
  private init() {}
  
  static let shared = DateForRequest()
  
  var date = Date()
  
}
