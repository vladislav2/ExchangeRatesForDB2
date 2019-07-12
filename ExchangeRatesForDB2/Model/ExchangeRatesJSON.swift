//
//  ExchangeRatesJSON.swift
//  ExchangeRatesForDB2
//
//  Created by user on 11.07.2019.
//  Copyright © 2019 Vlad Veretennikov. All rights reserved.
//

import Foundation

struct ExchangeRatesJSON: Codable {
  var date: String
  var bank: String
  var baseCurrency: Int
  var baseCurrencyLit: String
  var exchangeRate: [ExchangeRate]
}

struct ExchangeRate: Codable {
  var baseCurrency: String
  var currency: String?
  var saleRateNB: Double
  var purchaseRateNB: Double
  var saleRate: Double?
  var purchaseRate: Double?
}
