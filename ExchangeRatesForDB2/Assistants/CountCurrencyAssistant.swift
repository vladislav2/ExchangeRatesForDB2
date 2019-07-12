//
//  File.swift
//  ExchangeRatesForDB2
//
//  Created by user on 13.07.2019.
//  Copyright © 2019 Vlad Veretennikov. All rights reserved.
//

import Foundation

class CountCurrencyAssistant {
  static func amountCurrency(cost: ExchangeRate) -> (String, String) {
    let currency = cost.currency ?? ""
    let baseCurrency = "UAN"
    if cost.purchaseRateNB < 1 {
      if cost.purchaseRateNB < 0.1 {
        if cost.purchaseRateNB < 0.01 {
          return (String(format: "%.3f", cost.purchaseRateNB * 1000) + baseCurrency, "1000" + currency)
        }
        return (String(format: "%.3f", cost.purchaseRateNB * 100) + baseCurrency, "100" + currency)
      }
      return (String(format: "%.3f", cost.purchaseRateNB * 10) + baseCurrency, "10" + currency)
    }
    return (String(format: "%.3f", cost.purchaseRateNB) + baseCurrency, "1" + currency)
  }
}
