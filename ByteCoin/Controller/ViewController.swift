//  ViewController.swift
//  ByteCoin

import UIKit

class ViewController: UIViewController , UIPickerViewDataSource
{
  // Initializing IBO Outlets
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    // Initializing coinManager structure
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self

        coinManager.delegate = self
    }
}


// MARK: - ViewControoler CoinManagerDelegate protocol

extension ViewController: CoinManagerDelegate {
    // Delegate function
    func didUpdateView(_ result: CurrencyStruct) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = String(format:"%.1f",result.currencyRate)
            self.currencyLabel.text = result.currencyName
        }
    }
}

// MARK: - UIPickerViewDelegate methods

extension ViewController: UIPickerViewDelegate {
    
    // Add delegate method pickerView
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    // Add delegate method for pickerView
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currencyLiteral = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: currencyLiteral)
        
    }
    
    // Add function which return number of components
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Function which return number of elements in currency Array
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}
