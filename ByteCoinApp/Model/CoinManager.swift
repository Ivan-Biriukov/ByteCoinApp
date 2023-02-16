//
//  CoinManager.swift
//  ByteCoinApp
//
//  Created by иван Бирюков on 15.02.2023.
//

import Foundation
protocol CoinManagerDelegate{
    func didUpdateCoinInfo(coinManager: CoinManager, coin: CoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "Insert Your API Key HERE"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var delegate: CoinManagerDelegate?
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let coin = self.parseJSON(safeData){
                        self.delegate?.didUpdateCoinInfo(coinManager: self, coin: coin)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ coinData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData =  try decoder.decode(CoinData.self, from: coinData)
            let currency = decodedData.asset_id_quote
            let currencyValue = decodedData.rate
            let coin = CoinModel(currency: currency, currencyValue: currencyValue)
            
            return coin
        } catch {
            print(error)
            return nil
        }
    }
}
