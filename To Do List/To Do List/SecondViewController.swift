//
//  SecondViewController.swift
//  To Do List
//
//  Created by RuiJun haung on 2020/7/20.
//  Copyright © 2020 RuiJun haung. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var itemTextField: UITextField!
    
    
    @IBAction func add(_ sender: Any) {
         
        let itemsObject = UserDefaults.standard.object(forKey: "items")
        var items:[String]
        if let tempItems = itemsObject as? [String]{
            items = tempItems
            items.append(itemTextField.text!)
            
            print(items)
            
        }else{
            
            items = [itemTextField.text!]
            
            
        }
        UserDefaults.standard.set(items, forKey: "items")
            
       
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

