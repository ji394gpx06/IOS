//
//  ViewController.swift
//  Egg_Timer
//
//  Created by RuiJun haung on 2020/7/19.
//  Copyright © 2020 RuiJun haung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var timer = Timer()
    var time = 210
    @IBOutlet weak var UILabel: UILabel!
    
    
    @objc func decreaseTimer(){
        if time > 0{
            
            
            time = time - 1
            UILabel.text = String(time)
            
        }else{
            
            timer.invalidate()
            
        }
        
        
    }
    @IBAction func pause(_ sender: AnyObject) {
        timer.invalidate()
    }
    
    @IBAction func play(_ sender: AnyObject) {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.decreaseTimer), userInfo: nil, repeats: true)
    }
    @IBAction func plusten(_ sender: AnyObject) {
        
        time += 10
        UILabel.text = String(time)
    }
    @IBAction func minusten(_ sender: AnyObject) {
        
        time -= 10
        UILabel.text = String(time)
    }
    @IBAction func reset(_ sender: AnyObject) {
        
        time = 210
        UILabel.text = String(time)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }


}

