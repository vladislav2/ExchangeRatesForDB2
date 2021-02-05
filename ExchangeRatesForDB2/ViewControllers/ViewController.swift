//
//  ViewController.swift
//  ExchangeRatesForDB2
//
//  Created by user on 11.07.2019.
//  Copyright © 2019 Vlad Veretennikov. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
  
  private var exchangeRatesJSON: ExchangeRatesJSON!
  private var exchangeRatesForPrivatBank: [ExchangeRate] = []
  private let currencyName = ["Канадский доллар", "Китайский юань", "Чешская крона", "Датская крона", "Венгерский форинт", "Новый израильский шекель", "Японская йена", "Казахстанский тенге", "Молдавский лей", "Норвежская крона", "Сингапурский доллар", "Шведская крона", "Швейцарский франк", "Российский рубль", "Британский фунт", "Американский доллар", "Узбекский сум", "Белорусский рубль", "Туркменский манат", "Азербайджанский манат", "Турецкая лира", "Евро", "Украинская гривна", "Грузинский лари", "Польский злотый"]
  private var indexNBU = 0
  private var indexPB = 0
  
  @IBOutlet weak var calendarButtonPB: UIButton!
  @IBOutlet weak var calendarButtonNBU: UIButton!
  @IBOutlet weak var ERPBTableView: UITableView!
  @IBOutlet weak var ERNBUTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setButtonTitle(date: Date())
    getExchangeRates(dateStr: DateFormatterAssistant.convertDateToString(date: Date()))
  }
  
  private func setButtonTitle(date: Date) {
    calendarButtonPB.setTitle(DateFormatterAssistant.convertDateToString(date: date), for: .normal)
    calendarButtonNBU.setTitle(DateFormatterAssistant.convertDateToString(date: date), for: .normal)
  }
  
  private func getExchangeRates(dateStr: String) {
    NetworkServiceExchangeRates.getExchangeRates(date: dateStr, completion: { [weak self] (exchangeRates) in
      self?.exchangeRatesJSON = exchangeRates
      self?.exchangeRatesForPrivatBank = self?.selectExchangeRatesForPB(array: exchangeRates.exchangeRate) ?? []
      self?.ERPBTableView.reloadData()
      self?.ERNBUTableView.reloadData()
    })
  }

  private func selectExchangeRatesForPB(array: [ExchangeRate]) -> [ExchangeRate] {
    var exchangeRateArray: [ExchangeRate] = []
    for currency in array {
      if currency.purchaseRate != nil && currency.saleRate != nil {
        exchangeRateArray.append(currency)
      }
    }
    return exchangeRateArray
  }
  
  @IBAction func changeDateButton(_ sender: UIButton) {
    guard let popVC = storyboard?.instantiateViewController(withIdentifier: "popVC") else { return }
    popVC.modalPresentationStyle = .popover
    let popOverVC = popVC.popoverPresentationController
    popOverVC?.delegate = self
    popOverVC?.sourceView = sender
    popOverVC?.sourceRect = CGRect(x: sender.bounds.midX, y: sender.bounds.maxY, width: 0, height: 0)
    popVC.preferredContentSize = CGSize(width: 300, height: 250)
    self.present(popVC, animated: true)
  }
}

//MARK: - extentions

extension ViewController: UIPopoverPresentationControllerDelegate {
  func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
    return .none
  }
  func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
    getExchangeRates(dateStr: DateFormatterAssistant.convertDateToString(date: DateForRequest.shared.date))
    setButtonTitle(date: DateForRequest.shared.date)
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch tableView {
    case ERPBTableView:
      let selectedCell = tableView.cellForRow(at: indexPath) as! ERPBTableViewCell
      var indexPathNBU = IndexPath(row: indexNBU, section: 0)
      indexNBU = 0
      for exchangeRate in exchangeRatesJSON.exchangeRate {
        if exchangeRate.currency == exchangeRatesJSON.exchangeRate.first?.currency { continue }
        if exchangeRate.currency == selectedCell.currencyLabel.text { break }
        indexNBU += 1
      }
      indexPathNBU = IndexPath(row: indexNBU, section: 0)
      ERNBUTableView.selectRow(at: indexPathNBU, animated: true, scrollPosition: .middle)
    case ERNBUTableView:
      var indexPathPB = IndexPath(row: indexPB, section: 0)
      indexPB = 0
      for exchangeRate in exchangeRatesForPrivatBank {
        if exchangeRate.currency == exchangeRatesJSON.exchangeRate[indexPath.row + 1].currency {
          indexPathPB = IndexPath(row: indexPB, section: 0)
          ERPBTableView.selectRow(at: indexPathPB, animated: true, scrollPosition: .middle)
          break
        }
        indexPB += 1
      }
    default: break
    }
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch tableView {
    case ERPBTableView: if exchangeRatesJSON == nil { return 0 }
      return exchangeRatesForPrivatBank.count
    case ERNBUTableView: if exchangeRatesJSON == nil { return 0 }
      return exchangeRatesJSON.exchangeRate.count - 1
    default:
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    tableView.rowHeight = 50
    switch tableView {
    case ERPBTableView:
      let privatBankСell = tableView.dequeueReusableCell(withIdentifier: "PBcell", for: indexPath) as! ERPBTableViewCell
      privatBankСell.currencyLabel.text = exchangeRatesForPrivatBank[indexPath.row].currency
      privatBankСell.purchaseRateLabel.text = String(exchangeRatesForPrivatBank[indexPath.row].purchaseRate ?? 0)
      privatBankСell.saleRateLabel.text = String(exchangeRatesForPrivatBank[indexPath.row].saleRate ?? 0)
      return privatBankСell
    case ERNBUTableView:
      let nationalBankCell = tableView.dequeueReusableCell(withIdentifier: "NBUcell", for: indexPath) as! ERNBUTableViewCell
      nationalBankCell.currencyLabel.text = currencyName[indexPath.row]
      nationalBankCell.purchaseRateLabel.text = CountCurrencyAssistant.amountCurrency(cost: exchangeRatesJSON.exchangeRate[indexPath.row + 1]).0
      nationalBankCell.amountCurrencyLabel.text = CountCurrencyAssistant.amountCurrency(cost: exchangeRatesJSON.exchangeRate[indexPath.row + 1]).1
      return nationalBankCell
    default: return UITableViewCell()
    }
  }
}
