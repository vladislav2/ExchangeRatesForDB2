//
//  AppDelegate.swift
//  ExchangeRatesForDB2
//
//  Created by user on 11.07.2019.
//  Copyright © 2019 Vlad Veretennikov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.4059388515, green: 0.675694951, blue: 0.3616236093, alpha: 1)
    UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

    return true
  }
}

