//
//  NetworkServiceExchangeRates.swift
//  ExchangeRatesForDB2
//
//  Created by user on 11.07.2019.
//  Copyright © 2019 Vlad Veretennikov. All rights reserved.
//

import Foundation

class NetworkServiceExchangeRates {
  
  static func getExchangeRates(date: String, completion: @escaping(ExchangeRatesJSON) -> ()) {
    let jsonUrlString = "https://api.privatbank.ua/p24api/exchange_rates?json&date=" + date

    guard let url = URL(string: jsonUrlString) else { return }
    
    NetworkService.shared.getData(url: url) { (data) in
      do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let exchangeRates = try decoder.decode(ExchangeRatesJSON.self, from: data as! Data)
        completion(exchangeRates)
      } catch let error {
        print("Error serialization json", error)
      }
    }
  }
}
