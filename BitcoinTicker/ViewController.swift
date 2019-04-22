//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Andrei Giuglea on 22/04/2019.
//  Copyright © 2019 Andrei Giuglea. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
   
    
    let currencyArray = ["AUD","BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let currencySymbols = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    
    
    
    @IBOutlet weak var bitcoinPrice: UILabel!
    @IBOutlet weak var curencyPicker: UIPickerView!
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let finalURL = baseURL + currencyArray[row]
        getBitcoinData(url: finalURL, nr: row)
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        curencyPicker.delegate = self
        curencyPicker.dataSource = self
        
        getBitcoinData(url: (baseURL + currencyArray[0]),nr: 0)
        // Do any additional setup after loading the view.
    }

    
    func getBitcoinData(url: String,nr: Int){
        Alamofire.request(url,method: .get).responseJSON { response in
            if response.result.isSuccess{
                let bitcoinJSON : JSON = JSON(response.result.value!)
                self.updateUI(bitcoin: bitcoinJSON,nr: nr)
            }else{
                print("Error acquiring data:\(response.result.error) ")
            }
            
            
        }
    }
    
    func updateUI(bitcoin: JSON,nr: Int){
        bitcoinPrice.text = "\(bitcoin["last"])\(currencySymbols[nr])"
    }

}

