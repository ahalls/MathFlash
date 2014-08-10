//
//  FlashCardView.swift
//  Math Flash
//
//  Created by Steven Rosenberg on 8/3/14.
//  Copyright (c) 2014 Steven Rosenberg. All rights reserved.
//

import UIKit

class FlashCardView: UIViewController {
    
    //Variables that will be passed from the VC
    var selectedOperator = ""
    var selectedLevel = 0
    var selectedTime:UInt8 = 0
    var selectedProblem = 0
    
    //Variables for getting new math problems
    var getNewProblem: MathProblem = MathProblem()
    var returnedArray: [Int] = []
    
    //Trackers
    var problemCounter = -1
    var correctAnswerCounter = 0
    
    //Timer variables
    var startTime = NSTimeInterval()
    var timer = NSTimer()
    
    //upper half of window obects
    @IBOutlet weak var timeDisplayLabel: UILabel!
    @IBOutlet weak var statsDisplayLabel: UILabel!
    @IBOutlet weak var operatorDisplayLabel: UILabel!
    @IBOutlet weak var topNumberLabel: UILabel!
    @IBOutlet weak var bottomNumberLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    //numeric pad buttons
    @IBOutlet weak var oneKey: UIButton!
    @IBOutlet weak var twoKey: UIButton!
    @IBOutlet weak var threeKey: UIButton!
    @IBOutlet weak var fourKey: UIButton!
    @IBOutlet weak var fiveKey: UIButton!
    @IBOutlet weak var sixKey: UIButton!
    @IBOutlet weak var sevenKey: UIButton!
    @IBOutlet weak var eightKey: UIButton!
    @IBOutlet weak var nineKey: UIButton!
    @IBOutlet weak var deleteKey: UIButton!
    @IBOutlet weak var zeroKey: UIButton!
    @IBOutlet weak var enterKey: UIButton!
    @IBOutlet weak var timeLeft: UITextField!
    
    //Keyboard IBActions
    @IBAction func numberTapped(sender: AnyObject) {
        var number = sender.currentTitle
        if number == "0" && returnedArray[2] == 0 {
            answerLabel.text = answerLabel.text + number
        } else if number == "0" && answerLabel.text == "" {
        } else if answerLabel.text.toInt() > 99 && answerLabel.text.toInt() < 1000 {
        } else {
            answerLabel.text = answerLabel.text + number
        }
    }
    
    
    @IBAction func deleteTapped(sender: AnyObject) {
        if problemCounter != selectedProblem {
            let labelText = answerLabel.text
            answerLabel.text = labelText.substringToIndex(labelText.endIndex.predecessor())
        }
    }
    
    @IBAction func enterTapped(sender: AnyObject) {
        // if problemCounter != selectedProblem {
        if answerLabel.text == String(returnedArray[2]) {
            correctAnswerCounter++
            statsDisplayLabel.text = "\(correctAnswerCounter)" + "/" + "\(selectedProblem)"
            answerLabel.text = ""
        } else {
            //place X in label for a few seconds
            answerLabel.text = ""
        }
        gameManager()
        //}
    }
    
    
    @IBAction func buttonTapped (sender : AnyObject) {
        var alert = UIAlertController(title: "End mid-game?", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        self.presentViewController(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: { action in
            switch action.style{
            case .Default:
                self.performSegueWithIdentifier("MasterViewSegue", sender: self)
            case .Cancel:
                break
            case .Destructive:
                break
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .Default, handler: { action in
            switch action.style{
            case .Default:
                break
            case .Cancel:
                break
            case .Destructive:
                break
            }
        }))
        
    }
    
    //call the MathProblem model and get a new problem
    func gameManager() {
        problemCounter++
        if problemCounter != selectedProblem {
            switch selectedOperator {
            case "+":
                returnedArray = self.getNewProblem.additionProblem(selectedLevel)
                
            case "-":
                returnedArray = self.getNewProblem.subtractionProblem(selectedLevel)
                
            case "x":
                returnedArray = self.getNewProblem.multiplicationProblem(selectedLevel)
                
            case "÷":
                returnedArray = self.getNewProblem.divisionProblem(selectedLevel)
                
            default:
                break
            }
            topNumberLabel.text = String(returnedArray[0])
            bottomNumberLabel.text = String(returnedArray[1])
            statsDisplayLabel.text = "\(correctAnswerCounter)" + "/" + "\(selectedProblem)"
        } else {
            keyPadOff()
            timeLeft.enabled = true
            timeLeft.text = ""
            timeLeft.enabled = false
            if correctAnswerCounter == selectedProblem {
                timeDisplayLabel.text = "100%"
            }
            else {
                timeDisplayLabel.text = "Time Is Up!"
            }
            timer.invalidate()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let aSelector : Selector = "updateTime"
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: aSelector, userInfo: nil, repeats: true)
        startTime = NSDate.timeIntervalSinceReferenceDate()
        timeDisplayLabel.text = "\(selectedTime)"
        operatorDisplayLabel.text = selectedOperator
        timeLeft.text = "Time Left"
        timeLeft.enabled = false
        statsDisplayLabel.text = "\(problemCounter)" + "/" + "\(selectedProblem)"
        let answerLine = UILabel()
        answerLine.frame = CGRectMake(105, 180, 65, 2)
        answerLine.backgroundColor = UIColor.blackColor()
        self.view.addSubview(answerLine)
        
        gameManager()
    }
    
    func updateTime() {
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        var elapsedTime: NSTimeInterval = currentTime - startTime
        let seconds = selectedTime-UInt8(elapsedTime)
        if seconds > 0 {
            elapsedTime -= NSTimeInterval(seconds)
            timeDisplayLabel.text = "\(seconds)"
        } else {
            timeLeft.enabled = true
            timeLeft.text = ""
            timeLeft.enabled = false
            timeDisplayLabel.text = "Time Is Up!"
            timer.invalidate()
        }
    }
    
    //Called when game is over
    func keyPadOff() {
        oneKey.enabled = false
        twoKey.enabled = false
        threeKey.enabled = false
        fourKey.enabled = false
        fiveKey.enabled = false
        sixKey.enabled = false
        sevenKey.enabled = false
        eightKey.enabled = false
        nineKey.enabled = false
        zeroKey.enabled = false
        deleteKey.enabled = false
        enterKey.enabled = false
        timeLeft.enabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
