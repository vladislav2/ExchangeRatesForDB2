//
//  PopVC.swift
//  ExchangeRatesForDB2
//
//  Created by user on 12.07.2019.
//  Copyright © 2019 Vlad Veretennikov. All rights reserved.
//

import UIKit

class PopVC: UIViewController {
  
  @IBOutlet weak var datePicker: UIDatePicker!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    settingDatePicker()
  }
  
  func settingDatePicker() {
    datePicker.addTarget(self, action: #selector(followDatePicker(datePicker:)), for: .valueChanged)
    datePicker.datePickerMode = .date
    datePicker.maximumDate = Date()
    datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -4, to: Date())
  }
  
  @objc func followDatePicker(datePicker: UIDatePicker) {
    DateForRequest.shared.date = datePicker.date
  }
}

