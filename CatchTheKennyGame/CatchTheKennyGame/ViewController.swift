//
//  ViewController.swift
//  CatchTheKennyGame
//
//  Created by RuiJun haung on 2021/4/7.
//

import UIKit

class ViewController: UIViewController {
    //varable
    var score = 0
    var timer = Timer()
    var Hidetime = Timer()
    var counter = 0
    var kennyArray = [UIImageView]()
    var highscore = 0
    //view
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        scoreLabel.text = "Score: \(score)"
        //Highscore check
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        if storedHighScore == nil {
            highscore = 0
            highScoreLabel.text = "Highscore: \(highscore)"
        }
        if let newScore = storedHighScore as? Int{
            
            highscore = newScore
            highScoreLabel.text = "Highscore: \(highscore)"
            
            
        }
        //image
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        let recognnizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognnizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognnizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognnizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognnizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognnizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognnizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognnizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognnizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        kenny1.addGestureRecognizer(recognnizer1)
        kenny2.addGestureRecognizer(recognnizer2)
        kenny3.addGestureRecognizer(recognnizer3)
        kenny4.addGestureRecognizer(recognnizer4)
        kenny5.addGestureRecognizer(recognnizer5)
        kenny6.addGestureRecognizer(recognnizer6)
        kenny7.addGestureRecognizer(recognnizer7)
        kenny8.addGestureRecognizer(recognnizer8)
        kenny9.addGestureRecognizer(recognnizer9)
        kennyArray = [kenny1,kenny2,kenny3,kenny4,kenny5,kenny6,kenny7,kenny8,kenny9]
        //Timers
        counter = 10
        timeLabel.text = "Time:\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target:self,selector:#selector(countDown), userInfo: nil, repeats: true)
        Hidetime = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        hideKenny()
        
        
    }
    @objc func hideKenny() {
        for kenny in kennyArray {
            kenny.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false
    }
    @objc func increaseScore(){
        
        
        score += 1
        scoreLabel.text = "Score: \(score)"
        
    }
    @objc func countDown(){
        
        counter -= 1
        timeLabel.text = "Time:\(counter)"
        if counter == 0{
            
            timer.invalidate()
            Hidetime.invalidate()
            for kenny in kennyArray {
                kenny.isHidden = true
            }
            //highscore
            if self.score > self.highscore{
                self.highscore = self.score
                highScoreLabel.text = "HighScore:\(self.highscore)"
                UserDefaults.standard.set(self.highscore, forKey: "highscore")
                
                
            }
            
            //Alert
            
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                // replay function
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = "Time:\(self.counter)"
                self.timer = Timer.scheduledTimer(timeInterval: 1, target:self,selector:#selector(self.countDown), userInfo: nil, repeats: true)
                self.Hidetime = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
                
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
}

