//
//  CoinModel.swift
//  ByteCoinApp
//
//  Created by иван Бирюков on 16.02.2023.
//

import Foundation

struct CoinModel {
    let currency: String
    let currencyValue: Double
    
    var currencyValueString: String{
        return String(format: "%.2f", currencyValue)
    }
}
