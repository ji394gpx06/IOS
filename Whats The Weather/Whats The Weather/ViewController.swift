//
//  ViewController.swift
//  Whats The Weather
//
//  Created by RuiJun haung on 2020/11/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBAction func getwheather(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string:"https://www.weather-forecast.com/locations/London/forecasts/latest")!
        let request = NSMutableURLRequest(url: url)// Do any additional setup after loading the view.
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if let error = error{
                
                print(error)
                
            }else{
                
                if let unwrappedData = data {
                    
                    let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                    l
                    
                }
            }
            
        }
    }


}

