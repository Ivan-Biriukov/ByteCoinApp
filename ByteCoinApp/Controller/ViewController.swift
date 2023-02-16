//
//  ViewController.swift
//  ByteCoinApp
//
//  Created by иван Бирюков on 15.02.2023.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource {
    var coinManager = CoinManager()
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPiaker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPiaker.dataSource = self
        currencyPiaker.delegate = self
        coinManager.delegate = self
    }

}


// MARK: - CoinManagerDelegate
extension ViewController: CoinManagerDelegate{
    func didUpdateCoinInfo(coinManager: CoinManager, coin: CoinModel) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = coin.currencyValueString
            self.currencyLabel.text = coin.currency
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}

// MARK: - UIPickerViewDelegate
extension ViewController: UIPickerViewDelegate {
    // setup how many colloms do we watns
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // setup how many rows do we have
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    // this method setup names for rows in picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    //CALL insta method thats update current value from piaker
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let  selectedCurrency = coinManager.currencyArray[row]
            coinManager.getCoinPrice(for: selectedCurrency)
    }
}
