//
//  ViewController.swift
//  Catch
//
//  Created by OGUZHAN SARITAS.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var remainTimeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    @IBOutlet weak var carImage1: UIImageView!
    @IBOutlet weak var carImage3: UIImageView!
    @IBOutlet weak var carImage2: UIImageView!
    @IBOutlet weak var carImage4: UIImageView!
    @IBOutlet weak var carImage5: UIImageView!
    @IBOutlet weak var carImage6: UIImageView!
    @IBOutlet weak var carImage7: UIImageView!
    @IBOutlet weak var carImage8: UIImageView!
    @IBOutlet weak var carImage9: UIImageView!
    @IBOutlet weak var carImage10: UIImageView!
    @IBOutlet weak var carImage11: UIImageView!
    @IBOutlet weak var carImage12: UIImageView!
    
    @IBOutlet weak var highScoreLabel: UILabel!
    var highscore = 0
    var score = 0
    var counter = 10
    var timer = Timer()
    var hideTimer = Timer()
    
    var carImageArray = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carImageArray = [carImage1,carImage2,carImage3,carImage4,carImage5,carImage6,carImage7,carImage8,carImage9,carImage10,carImage11,carImage12]
        
        let highscoreDefault = UserDefaults.standard.object(forKey: "highscore")
        if highscoreDefault == nil{
            highscore = 0
            highScoreLabel.text = String(highscore)
        }else{
            highscore = highscoreDefault as! Int
            highScoreLabel.text = String(highscore)
        }
        makeSettings()
        hideCar()
        
        scoreLabel.text = String(score)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideCar), userInfo: nil, repeats: true)
        
        
        
    }
    @objc func hideCar(){
        for car in carImageArray{
            car.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(carImageArray.count-1)))
        carImageArray[random].isHidden = false
    }


}
extension ViewController{
    @objc func countdown(){
        counter -= 1
        remainTimeLabel.text = String(counter)
        if counter == 0{
            timer.invalidate()
            hideTimer.invalidate()
            
            if score > highscore{
                highscore = score
                highScoreLabel.text = String(highscore)
                UserDefaults.standard.set(highscore, forKey: "highscore")
            }
            
            // Alert
            let alert = UIAlertController(title: "Time is up!", message: "Do you want play again?", preferredStyle: .alert)
            
            let okbutton = UIAlertAction(title: "Ok!", style: .destructive)
            let replayButton = UIAlertAction(title: "Play!", style: .default) { UIAlertAction in
                // replay
                self.score = 0
                self.scoreLabel.text = String(self.score)
                
                self.counter = 10
                self.remainTimeLabel.text = String(self.counter)
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countdown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideCar), userInfo: nil, repeats: true)
                
                
            }
            
            alert.addAction(okbutton)
            alert.addAction(replayButton)
            self.present(alert, animated: true)
        }
    }
    func makeSettings(){
        carImage1.isUserInteractionEnabled = true
        carImage2.isUserInteractionEnabled = true
        carImage3.isUserInteractionEnabled = true
        carImage4.isUserInteractionEnabled = true
        carImage5.isUserInteractionEnabled = true
        carImage6.isUserInteractionEnabled = true
        carImage7.isUserInteractionEnabled = true
        carImage8.isUserInteractionEnabled = true
        carImage9.isUserInteractionEnabled = true
        carImage10.isUserInteractionEnabled = true
        carImage11.isUserInteractionEnabled = true
        carImage12.isUserInteractionEnabled = true
        
        // Gesture Recognizer
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer10 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer11 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer12 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        // Add Recognizer
        carImage1.addGestureRecognizer(recognizer1)
        carImage2.addGestureRecognizer(recognizer2)
        carImage3.addGestureRecognizer(recognizer3)
        carImage4.addGestureRecognizer(recognizer4)
        carImage5.addGestureRecognizer(recognizer5)
        carImage6.addGestureRecognizer(recognizer6)
        carImage7.addGestureRecognizer(recognizer7)
        carImage8.addGestureRecognizer(recognizer8)
        carImage9.addGestureRecognizer(recognizer9)
        carImage10.addGestureRecognizer(recognizer10)
        carImage11.addGestureRecognizer(recognizer11)
        carImage12.addGestureRecognizer(recognizer12)
    }
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = String(score)
    }
}
