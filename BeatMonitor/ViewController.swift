//
//  ViewController.swift
//  BeatMonitor
//
//  Created by Douglas Mandarino on 7/21/15.
//  Copyright (c) 2015 Douglas Mandarino. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, BeatMonitorScreenProtocol, WCSessionDelegate {
    
    var minutes = 0
    var seconds = 0
    var timer = NSTimer()
    
    var session: WCSession!
    
    var intervalo: Double = 0
    
    var counterData = String()
    
    var opened = true
    
    var lastReceived = NSDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSTimer.scheduledTimerWithTimeInterval(20, target: self, selector: "timerDidFire:", userInfo:nil, repeats: true)
        
        
        beginSession()
        
    }
    
    func beginSession() {
        
        if (WCSession.isSupported()) {
            session = WCSession.defaultSession()
            session.delegate = self;
            session.activateSession()

        }
        
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        let counterValue = message["counterValue"] as? String
        
        //Use this to update the UI instantaneously (otherwise, takes a little while)
        dispatch_async(dispatch_get_main_queue()) {
            
            self.counterData = counterValue!
            
            let s = counterValue
            
            print(s)
            
//            if s?.rangeOfString(" count/min") != nil {
//                
//                m = (s?.stringByReplacingOccurrencesOfString(" count/min", withString: ""))!
//                
//            }
//            
//            else {
//                
//                m = (s?.stringByReplacingOccurrencesOfString(" count/s", withString: ""))!
//                
//            }
//            
//            self.myView.myBeat = Int(m)!
            
            self.myView.myBeat = Int(s!)!
            
            if self.opened == false {
                
                self.myView.openTimeIntervalMenu()
                self.opened = true
                self.myView.myBeat = Int(s!)!
            }
//
//            let result = Results()
//            var array = result.results
//            
//            var string: String = DAO.loadResultsData() as String
//            if string != "" {
//               array = JSONService.convertStringToResults(string)
//            }
//            array.append(Int(m!)!)
//            print(array)
//            result.reorganizeResults(array)
//            string = JSONService.stringfyResults([0,0,0,0,0,0,0,0,Int(m!)!])
//            print(string)
//            DAO.saveResultsData(string)
            
            self.lastReceived = NSDate()
            
        }
    }
    
    func timerDidFire(timer:NSTimer!) {
        
        let difference = NSDate().timeIntervalSinceDate(lastReceived)
        
        print(difference)
        
        if difference > 20 {
            
            print("closed")
            self.myView.closeTimeIntervalMenu()
            self.opened = false
        }
    }
    
    var myView:AppView {
        get {
            return self.view as! AppView
        }
    }
    
    override func loadView() {
        
        //self.edgesForExtendedLayout = UIRectEdge.None;
        self.view = AppView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height), navBarH: self.navigationController!.navigationBar.frame.height)
        
        self.myView.delegate = self
        //self.myView.intervalAction(self.myView.intervalButtons[1])
        
        self.title = "Beat Monitor"
        
        self.myView.beginCirclesAnimation()
        //self.myView.openTutorial()
        //self.myView.openTimeIntervalMenu()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func decreaseMinute() {
        
    }
    
    func didPressDiseaseButton(disease: String) {
        
    }
    
    func didChangeIntervalValue(value: Int) {
        
        intervalo = Double(value)
        
        let applicationData = ["intervalo":intervalo]
        
        session.sendMessage(applicationData, replyHandler: {(_: [String : AnyObject]) -> Void in
            // handle reply from iPhone app here
            }, errorHandler: {(error ) -> Void in
                // catch any errors here
        })
        
    }
    
    func didPressStartButton(state: Bool) {
        
        let applicationData = ["status":state]
        
        session.sendMessage(applicationData, replyHandler: {(_: [String : AnyObject]) -> Void in
            // handle reply from iPhone app here
            }, errorHandler: {(error ) -> Void in
                // catch any errors here
        })
        
    }
    
    func didPressHelpButton() {
        
    }
    
    func didPressSetAge() {
        
        let alert = UIAlertController(title: "Age", message: "Please type your age in years.", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler(nil)
        
        let action: UIAlertAction = UIAlertAction(title: "Ok", style: .Default) { action -> Void in
            let string = alert.textFields![0].text!
            let number = Int(string)
            
            if(number != nil) {
                self.myView.myAge = number!
            } else {
                
            }
            
        }
        
        alert.textFields![0].keyboardType = UIKeyboardType.NumberPad
        alert.textFields![0].placeholder = "Example: 35"
        alert.addAction(action)
        
        self.navigationController!.presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
    func didPressSetHeight() {
        
        let alert = UIAlertController(title: "Height", message: "Please type height in centimeters.", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler(nil)
        
        let action: UIAlertAction = UIAlertAction(title: "Ok", style: .Default) { action -> Void in
            let string = alert.textFields![0].text!
            let number = Int(string)
            
            if(number != nil) {
                self.myView.myHeight = number!
            } else {
                
            }
            
        }
        
        alert.textFields![0].keyboardType = UIKeyboardType.NumberPad
        alert.textFields![0].placeholder = "Example: 170"
        alert.addAction(action)
        
        self.navigationController!.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func didPressSetWeigth() {
        
        let alert = UIAlertController(title: "Weight", message: "Please type your weight in kilograms.", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler(nil)
        
        let action: UIAlertAction = UIAlertAction(title: "Ok", style: .Default) { action -> Void in
            let string = alert.textFields![0].text!
            let number = Int(string)
            
            if(number != nil) {
                self.myView.myWeight = number!
            } else {
                
            }
            
            
        }
        
        alert.textFields![0].keyboardType = UIKeyboardType.NumberPad
        alert.textFields![0].placeholder = "Example: 75"
        alert.addAction(action)
        
        self.navigationController!.presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
    func didPressSetExercise() {
        
        let alert = UIAlertController(title: "Exercises", message: "Please, chose your exercise frequency.", preferredStyle: UIAlertControllerStyle.Alert)
        
        let action1: UIAlertAction = UIAlertAction(title: "Never", style: .Default) { action -> Void in
            self.myView.myEercise = action.title!
        }
        
        let action2: UIAlertAction = UIAlertAction(title: "Ocasionally", style: .Default) { action -> Void in
            self.myView.myEercise = action.title!
        }
        
        let action3: UIAlertAction = UIAlertAction(title: "Regulary", style: .Default) { action -> Void in
            self.myView.myEercise = action.title!
        }
        
        let action4: UIAlertAction = UIAlertAction(title: "Always", style: .Default) { action -> Void in
            self.myView.myEercise = action.title!
        }
        
        alert.addAction(action4)
        alert.addAction(action3)
        alert.addAction(action2)
        alert.addAction(action1)
        
        self.navigationController!.presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
}

