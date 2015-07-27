//
//  ViewController.swift
//  BeatMonitor
//
//  Created by Douglas Mandarino on 7/21/15.
//  Copyright (c) 2015 Douglas Mandarino. All rights reserved.
//

import UIKit

class ViewController: UIViewController, BeatMonitorScreenProtocol {
    
    var minutes = 0
    var seconds = 0
    var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
        
        self.title = "Beat Monitor"
        
        //self.myView.beginViewFirstTime()
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
        
    }
    
    func didPressStartButton(state: Bool) {
        
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

