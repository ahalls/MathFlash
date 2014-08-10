//
//  MasterView.swift
//  Math Flash
//
//  Created by Steven Rosenberg on 8/3/14.
//  Copyright (c) 2014 Steven Rosenberg. All rights reserved.
//

import UIKit

class MasterView: UIViewController {
    
    //Varables that track user selected controls
    //Initial states are set to insure there is always a button selected in each row.
    var operatorChoice = "+"
    var level = 1
    var time:UInt8 = 30
    var problem = 10
    var storeButtons: ArchiveButtons = ArchiveButtons()
    var retrieveButtons: ArchiveButtons = ArchiveButtons()
    var lastOperator = ""
    var lastLevel = 0
    var lastProblem = 40
    
    //Operation buttons
    var activeOperationButton:Int = 1
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var timesButton: UIButton!
    @IBOutlet weak var divideButton: UIButton!
    
    //Level buttons
    @IBOutlet weak var levelOneButton: UIButton!
    @IBOutlet weak var levelTwoButton: UIButton!
    @IBOutlet weak var levelThreeButton: UIButton!
    @IBOutlet weak var levelFourButton: UIButton!
    
    //Seconds buttons
    @IBOutlet weak var thirtySecondsButton: UIButton!
    @IBOutlet weak var sixtySecondsButton: UIButton!
    @IBOutlet weak var ninetySecondsButton: UIButton!
    @IBOutlet weak var onetwentySecondsButton: UIButton!
    
    //Problems buttons
    @IBOutlet weak var tenProblemsButton: UIButton!
    @IBOutlet weak var twentyProblemsButton: UIButton!
    @IBOutlet weak var thirtyProblemsButton: UIButton!
    @IBOutlet weak var fortyProblemsButton: UIButton!
    
    //Text labels
    @IBOutlet weak var operatorLabel: UITextField!
    @IBOutlet weak var levelLabel: UITextField!
    @IBOutlet weak var secondsLabel: UITextField!
    @IBOutlet weak var problemsLabel: UITextField!
    
    //Start button
    @IBOutlet weak var startButton: UIButton!
    
    
    //Change color of tapped button to gray and call function to return any other
    //gray button to mercury color
    @IBAction func buttonTapped (button: UIButton!) {
        if (button.backgroundColor != UIColor.grayColor()) {
            button.backgroundColor = UIColor.grayColor()
            adjustButtonColors(button.tag)
            updateButtonTracker(buttonTag: button.tag)
        }
    }
    
    //Passing selected buttons to FlashCardView Controller
    //Storing button states for next game
    //Carefull to change Int types between NSTimer (UInt8)and all other uses of time
    //such as the NSCoding functions that don't seem to like UInt8
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        let theDestination = (segue.destinationViewController as FlashCardView)
        theDestination.selectedOperator = operatorChoice
        theDestination.selectedLevel = level
        theDestination.selectedTime = time
        theDestination.selectedProblem = problem
        let intTime = Int(time)
        self.storeButtons.Archive(operatorChoice: operatorChoice, time: intTime, level: level, problem: problem)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting innitial choices for the user
        var lastButtons = self.retrieveButtons.Retrieve()
        operatorChoice = lastButtons.lastOperator
        level = lastButtons.lastLevel
        problem = lastButtons.lastProblem
        time = UInt8(lastButtons.lastTime)
        setButtonInitialColors()
        
        //Do not allow editing of text labels
        operatorLabel.enabled = false
        levelLabel.enabled = false
        secondsLabel.enabled = false
        problemsLabel.enabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Used to set button initial states after the ViewDidLoad method loaded the
    //button choices from the last game stored in the archive file
    func setButtonInitialColors() {
        switch operatorChoice {
        case "+":
            addButton.backgroundColor = UIColor.grayColor()
        case "-":
            minusButton.backgroundColor = UIColor.grayColor()
        case "x":
            timesButton.backgroundColor = UIColor.grayColor()
        case "÷":
            divideButton.backgroundColor = UIColor.grayColor()
        default:
            return()
        }
        switch time {
        case 30:
            thirtySecondsButton.backgroundColor = UIColor.grayColor()
        case 60:
            sixtySecondsButton.backgroundColor = UIColor.grayColor()
        case 90:
            ninetySecondsButton.backgroundColor = UIColor.grayColor()
        case 120:
            onetwentySecondsButton.backgroundColor = UIColor.grayColor()
        default:
            return()
        }
        switch level {
        case 1:
            levelOneButton.backgroundColor = UIColor.grayColor()
        case 2:
            levelTwoButton.backgroundColor = UIColor.grayColor()
        case 3:
            levelThreeButton.backgroundColor = UIColor.grayColor()
        case 4:
            levelFourButton.backgroundColor = UIColor.grayColor()
        default:
            return()
        }
        switch problem {
        case 10:
            tenProblemsButton.backgroundColor = UIColor.grayColor()
        case 20:
            twentyProblemsButton.backgroundColor = UIColor.grayColor()
        case 30:
            thirtyProblemsButton.backgroundColor = UIColor.grayColor()
        case 40:
            fortyProblemsButton.backgroundColor = UIColor.grayColor()
        default:
            return()
        }
    }
    
    
    //After selected button changed to dark gray, the function deselects gray buttons
    //in the same row.  Only allow one button in a feature row to be selected as gray.
    func adjustButtonColors (buttonTag: Int) {
        switch buttonTag {
            //keep only seleted operator button gray, set the rest to mercury color
        case 1...4:
            for var tag=1; tag<=4; ++tag {
                if buttonTag != 1 {
                    addButton.backgroundColor = UIColor(red: 0.901961, green: 0.901961, blue: 0.901961, alpha: 1)
                }
                if buttonTag != 2 {
                    minusButton.backgroundColor = UIColor(red: 0.901961, green: 0.901961, blue: 0.901961, alpha: 1)
                }
                if buttonTag != 3 {
                    timesButton.backgroundColor = UIColor(red: 0.901961, green: 0.901961, blue: 0.901961, alpha: 1)
                }
                if buttonTag != 4 {
                    divideButton.backgroundColor = UIColor(red: 0.901961, green: 0.901961, blue: 0.901961, alpha: 1)
                }
            }
            //keep only seleted level button gray, the rest set to mercury color
        case 5...8:
            for var tag=5; tag<=8; ++tag {
                if buttonTag != 5 {
                    levelOneButton.backgroundColor = UIColor(red: 0.901961, green: 0.901961, blue: 0.901961, alpha: 1)
                }
                if buttonTag != 6 {
                    levelTwoButton.backgroundColor = UIColor(red: 0.901961, green: 0.901961, blue: 0.901961, alpha: 1)
                }
                if buttonTag != 7 {
                    levelThreeButton.backgroundColor = UIColor(red: 0.901961, green: 0.901961, blue: 0.901961, alpha: 1)
                }
                if buttonTag != 8 {
                    levelFourButton.backgroundColor = UIColor(red: 0.901961, green: 0.901961, blue: 0.901961, alpha: 1)
                }
            }
            //keep only seleted time button gray, the rest set to mercury color
        case 9...12:
            for var tag=9; tag<=12; ++tag {
                if buttonTag != 9 {
                    thirtySecondsButton.backgroundColor = UIColor(red: 0.901961, green: 0.901961, blue: 0.901961, alpha: 1)
                }
                if buttonTag != 10 {
                    sixtySecondsButton.backgroundColor = UIColor(red: 0.901961, green: 0.901961, blue: 0.901961, alpha: 1)
                }
                if buttonTag != 11 {
                    ninetySecondsButton.backgroundColor = UIColor(red: 0.901961, green: 0.901961, blue: 0.901961, alpha: 1)
                }
                if buttonTag != 12 {
                    onetwentySecondsButton.backgroundColor = UIColor(red: 0.901961, green: 0.901961, blue: 0.901961, alpha: 1)
                }
            }
            //keep only seleted # of problems button gray, the rest set to mercury color
        case 13...16:
            for var tag=13; tag<=16; ++tag {
                if buttonTag != 13 {
                    tenProblemsButton.backgroundColor = UIColor(red: 0.901961, green: 0.901961, blue: 0.901961, alpha: 1)
                }
                if buttonTag != 14 {
                    twentyProblemsButton.backgroundColor = UIColor(red: 0.901961, green: 0.901961, blue: 0.901961, alpha: 1)
                }
                if buttonTag != 15 {
                    thirtyProblemsButton.backgroundColor = UIColor(red: 0.901961, green: 0.901961, blue: 0.901961, alpha: 1)
                }
                if buttonTag != 16 {
                    fortyProblemsButton.backgroundColor = UIColor(red: 0.901961, green: 0.901961, blue: 0.901961, alpha: 1)
                }
            }
        default:
            return()
        }
        
    }
    
    //Update tracker variables so state of buttons can be passed via segue to the
    //FlashCardView Controller
    func updateButtonTracker (buttonTag tag: Int) {
        switch tag {
        case 1...4:
            if tag == 1 {
                operatorChoice = "+"
            }
            else if tag == 2 {
                operatorChoice = "-"
            }
            else if tag == 3 {
                operatorChoice = "x"
            }
            else if tag == 4 {
                operatorChoice = "÷"
            }
        case 5...8:
            if tag == 5 {
                level = 1
            }
            else if tag == 6 {
                level = 2
            }
            else if tag == 7 {
                level = 3
            }
            else if tag == 8 {
                level = 4
            }
        case 9...12:
            if tag == 9 {
                time = 30
            }
            else if tag == 10 {
                time = 60
            }
            else if tag == 11 {
                time = 90
            }
            else if tag == 12 {
                time = 120
            }
        case 13...16:
            if tag == 13 {
                problem = 10
            }
            else if tag == 14 {
                problem = 20
            }
            else if tag == 15 {
                problem = 30
            }
            else if tag == 16 {
                problem = 40
            }
        default:
            return()
        }
    }
}

