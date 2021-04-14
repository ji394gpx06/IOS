//
//  ViewController.swift
//  How many fingers
//
//  Created by RuiJun haung on 2020/7/14.
//  Copyright © 2020 RuiJun haung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var fingerTextfield: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBAction func guess(_ sender: Any) {
        let diceRoll = String(arc4random_uniform(6))
        if fingerTextfield.text == diceRoll{
            
            resultLabel.text = "You are right!"
            
        }else{
            
            
            resultLabel.text = "Wrong! It was a " + diceRoll + "."
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

