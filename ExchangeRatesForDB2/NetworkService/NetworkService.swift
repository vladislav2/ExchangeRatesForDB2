//
//  NetworkService.swift
//  ExchangeRatesForDB2
//
//  Created by user on 11.07.2019.
//  Copyright © 2019 Vlad Veretennikov. All rights reserved.
//

import Foundation

class NetworkService {
  
  private init() {}
  
  static let shared = NetworkService()
  
  func getData(url: URL, completion: @escaping (Any) -> ()) {
    let session = URLSession.shared
    
    session.dataTask(with: url) { (data, response, error) in
      guard let data = data else { return }
      DispatchQueue.main.async {
        completion(data)
      }
      }.resume()
  }
}
