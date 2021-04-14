//
//  ViewController.swift
//  TicTacToe
//
//  Created by RuiJun haung on 2020/11/26.
//

import UIKit

class ViewController: UIViewController {

    // 1 is nought, 2 is crosses
    @IBOutlet weak var winnerlabel: UILabel!
    @IBOutlet weak var playagainbutton: UIButton!
    @IBAction func playAgain(_ sender: Any) {
        activeGame = true
        activePlayer = 1
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        for i in 1..<10{
            
            if let button = view.viewWithTag(i) as? UIButton{
                
                button.setImage(nil, for: [])
                
            }
            winnerlabel.isHidden = true
            playagainbutton.isHidden = true
            
            winnerlabel.center = CGPoint(x: winnerlabel.center.x - 500, y: winnerlabel.center.y)
            playagainbutton.center = CGPoint(x: playagainbutton.center.x - 500, y: playagainbutton.center.y)
            
        }
    }
    var activeGame = true
    var activePlayer = 1
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]//0 - empty, 1 - nought,2 - crosses
    let winningCombinations = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    @IBAction func buttonPressed(_ sender: AnyObject) {
        let activePosition = sender.tag - 1
        if gameState[activePosition] == 0 && activeGame{
            gameState[activePosition] = activePlayer
            if activePlayer == 1{
                sender.setImage(UIImage(named:"nought.png"),for: [])
            
                activePlayer = 2
            }
            else
            {
                sender.setImage(UIImage(named:"cross.png"),for: [])
                activePlayer = 1
            
            }
            for combiation in winningCombinations{
                //print("comb"+String(combiation[3]))
                
                //print(combiation[2])
                if gameState[combiation[0]] != 0 && gameState[combiation[0]] == gameState[combiation[1]] && gameState[combiation[1]] == gameState[combiation[2]]{
                    
                    print("123")
                    //we have a winner
                    activeGame = false
                    winnerlabel.isHidden = false
                    playagainbutton.isHidden = false
                    if(gameState[combiation[0]]) == 1{
                        
                        
                        winnerlabel.text = "Nought has won!"
                    }else{
                        winnerlabel.text = "Crosses has won!"
                    }
                    UIView.animate(withDuration: 1, animations: {
                        self.winnerlabel.center = CGPoint(x:self.winnerlabel.center.x+500,y:self.winnerlabel.center.y)
                        self.playagainbutton.center = CGPoint(x: self.playagainbutton.center.x+500, y: self.playagainbutton.center.y)
                    })
                }
                
            }
        }
        //print(sender.tag)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        winnerlabel.isHidden = true
        playagainbutton.isHidden = true
        
        winnerlabel.center = CGPoint(x: winnerlabel.center.x - 500, y: winnerlabel.center.y)
        playagainbutton.center = CGPoint(x: playagainbutton.center.x - 500, y: playagainbutton.center.y)
        // Do any additional setup after loading the view.
    }


}

