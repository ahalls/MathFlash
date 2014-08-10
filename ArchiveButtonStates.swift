//
//  ArchiveButtonStates.swift
//  Math Flash
//
//  Created by Steven Rosenberg on 8/9/14.
//  Copyright (c) 2014 Steven Rosenberg. All rights reserved.
//

import Foundation

//This class gives persistence to the chosen button states (operator, level, time
//and # of problems). At the start of the next game, instead of returning to default
//states, one can start from the most recent selections.

protocol NSCoding {
    
}

class ArchiveButtons:NSObject {
    
    var operatorChoice = "+"
    var level: Int = 0
    var time = 30
    var problem = 0
    
    var documentDirectories:NSArray = []
    var documentDirectory:String = ""
    var path:String = ""
    
    override init() {
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeObject(operatorChoice, forKey: "operatorChoice")
        aCoder.encodeInteger(time, forKey: "time")
        aCoder.encodeInteger(problem, forKey: "problem")
        aCoder.encodeInteger(level, forKey:"level")
    }
    
    init(coder aDecoder: NSCoder!) {
        super.init()
        
        operatorChoice = aDecoder.decodeObjectForKey("operatorChoice") as String
        time = aDecoder.decodeIntegerForKey("time")
        problem = aDecoder.decodeIntegerForKey("problem")
        level = aDecoder.decodeIntegerForKey("level")
    }
    
    func Archive(operatorChoice _operatorChoice: String, time _time: Int, level _level: Int, problem _problem: Int) {
        
        // Create filepath for archive.
        documentDirectories = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        // Get document directory from that list
        documentDirectory = documentDirectories.objectAtIndex(0) as String
        
        // append with the .archive file name
        path = documentDirectory.stringByAppendingPathComponent("archive_file.archive")
        
        self.operatorChoice = _operatorChoice
        self.time = _time
        self.level = _level
        self.problem = _problem
        
        var allChoices = []
        allChoices = [self]
        if NSKeyedArchiver.archiveRootObject(allChoices, toFile: path) {
            //println("Success writing to file!")
        } else {
            //println("Unable to write to file!")
        }
    }
    
    func Retrieve() -> (lastOperator: String, lastTime: Int, lastLevel: Int, lastProblem: Int)  {
        var lastOperator = ""
        var lastTime = 0
        var lastLevel = 0
        var lastProblem = 0
        
        documentDirectories = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        documentDirectory = documentDirectories.objectAtIndex(0) as String
        path = documentDirectory.stringByAppendingPathComponent("archive_file.archive")
        
        var retrieveButton:NSArray = []
        retrieveButton = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as NSArray
        for button in retrieveButton as [ArchiveButtons!]  {
            lastOperator = button.operatorChoice
            lastTime = button.time
            lastLevel = button.level
            lastProblem = button.problem
        }
        return (lastOperator, lastTime, lastLevel, lastProblem)
    }
}

