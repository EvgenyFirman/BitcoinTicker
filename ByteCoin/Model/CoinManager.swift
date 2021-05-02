//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

protocol CoinManagerDelegate{
    func didUpdateView(_ result: CurrencyStruct)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "FB88052C-86ED-40B7-8283-8F3643D69034"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    
    var delegate: CoinManagerDelegate?
    
    func getCoinPrice(for currency: String){
        let urlString = String("\(baseURL)/\(currency)?apikey=\(apiKey)")
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                }
                if let safeData = data {
                    let parsedData = parseJSON(safeData)!
                    delegate?.didUpdateView(parsedData)
                }
            }
            task.resume()
        }
        
    }
    func parseJSON(_ data: Data) -> CurrencyStruct?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinManagerModel.self, from: data)
            let rate = decodedData.rate
            let currencyName = decodedData.asset_id_quote
            let currency = CurrencyStruct(currencyName: currencyName, currencyRate: rate)
            return currency
            }
            catch {
                print("Was an error")
                return nil
            }
            
        }
    }
    
