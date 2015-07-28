//
//  AppView.swift
//  BeatMonitor
// 13495
//  Created by Joao Nassar Galante Guedes on 22/07/15.
//  Copyright (c) 2015 Douglas Mandarino. All rights reserved.
//

import UIKit

protocol BeatMonitorScreenProtocol {
    
    func didChangeIntervalValue(value: Int)
    func didPressStartButton(state: Bool)
    func didPressDiseaseButton(disease: String)
    func didPressHelpButton()
    func didPressSetAge()
    func didPressSetHeight()
    func didPressSetWeigth()
    func didPressSetExercise()
}

class AppView: UIView {
    
    let redLightColor = UIColor(red: 247/255.0, green: 241/255.0, blue: 242/255.0, alpha: 1)
    let redDarkColor = UIColor(red: 212/255.0, green: 14/255.0, blue: 49/255.0, alpha: 1)
    let redMiddleColor = UIColor(red: 255/255.0, green: 26/255.0, blue: 66/255.0, alpha: 1)
    let brownDarkColor = UIColor(red: 68/255.0, green: 14/255.0, blue: 28/255.0, alpha: 1)
    let brownLightColor = UIColor(red: 157/255.0, green: 105/255.0, blue: 90/255.0, alpha: 1)
    
    var navBarHeight: CGFloat = 0
    var delegate: BeatMonitorScreenProtocol?
    
    var heartMidX: CGFloat = 0
    var heartMidX2: CGFloat = 0
    var heartLabelSize2: CGFloat = 0
    var heartCenter: CGPoint = CGPointMake(0, 0)
    var circleMaxSize: CGFloat = 0
    
    var age: Int = 0
    var height: Int = 0
    var weight: Int = 0
    var exercises: String = ""
    var heartBeat: Int = 0
    
    var myAge:Int {
        get {
            return age
        }
        set {
            age = newValue
            button1.setTitle("\(newValue) yrs", forState: .Normal)
        }
    }
    
    var myHeight:Int {
        get {
            return height
        }
        set {
            height = newValue
            button2.setTitle("\(newValue) cm", forState: .Normal)
        }
    }
    
    var myWeight:Int {
        get {
            return weight
        }
        set {
            weight = newValue
            button3.setTitle("\(newValue) kg", forState: .Normal)
        }
    }
    
    var myEercise:String {
        get {
            return exercises
        }
        set {
            exercises = newValue
            button4.setTitle(newValue, forState: .Normal)
        }
    }
    
    var myBeat:Int {
        get {
            return heartBeat
        }
        set {
            heartBeat = newValue
            heartLabel.text = "\(newValue)bpm"
        }
    }
    
    var myInterval:Int {
        get {
            return currentInterval * 60
        }
        set {
            currentInterval = newValue
        }
    }
    
    var inTutorial = false
    var currentInterval = 0
    var intervalButtons: Array<UIButton> = []
    
    var heartCircles: Array<UIImageView> = []
    var heartCirclesTimers: Array<NSTimer> = []
    var heartCirclesAnimating = false
    
    var resultLabel = UILabel()
    var nextScanLabel = UILabel()
    var scanEveryLabel = UILabel()
    var descriptionLabel = UILabel()
    var descriptionContainer = UIScrollView()
    var startButton = UIButton()
    var graphView = GraphView()
    
    var button1 = UIButton()
    var button2 = UIButton()
    var button3 = UIButton()
    var button4 = UIButton()
    
    var clearButton = UIButton()
    
    var buttonA = UIButton()
    var buttonB = UIButton()
    var buttonC = UIButton()
    var buttonD = UIButton()
    
    var heartView = UIImageView()
    var heartLabel = UILabel()
    
    convenience init () {
        self.init()
    }
    
    init(frame: CGRect, navBarH: CGFloat) {
        navBarHeight = navBarH
        super.init(frame: frame)
        self.setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        //Colors
        
        self.backgroundColor = UIColor.whiteColor()
        
        //Measures
        
        let totalBar = navBarHeight + UIApplication.sharedApplication().statusBarFrame.height
        
        let screenHeight = self.frame.height
        let screenWidth = self.frame.width
        
        let prop = screenHeight/677.0
        let prop2 = screenWidth/375.0
        
        let sectionOneHeight = (308 * prop) - totalBar
        let sectionTwoHeight = 173 * prop
        let sectionThreeHeight = 196 * prop
        let sectionThreeHalfWidth = 155 * prop2
        
        let intervalValues = [10,20,30,60,120,180]
        
        let secondSectionPadding:CGFloat = (22 * prop)
        let nextScanTextY = CGFloat(Int(sectionOneHeight + totalBar + secondSectionPadding))
        let nextScanTextH:CGFloat = 20
        let nextScanFontSize = CGFloat(Int(22 * prop))
        
        let scanEveryTextFontSize = CGFloat(Int(18 * prop))
        let scanEveryTextY = CGFloat(Int(nextScanTextY + nextScanTextH + (5 * prop)))
        let scanEveryTextH:CGFloat = 20
        
        let buttonsIntervalY = CGFloat(Int(scanEveryTextY + scanEveryTextH + (10 * prop)))
        let buttonsIntervalH:CGFloat = CGFloat(Int( 28 * prop ))
        let buttonsIntervalFontSize = CGFloat(Int(17 * prop))
        let buttonIntervalSpacing:CGFloat = CGFloat(Int( 7 * prop ))
        let buttonsIntervalBeginX:CGFloat = CGFloat(Int( (screenWidth/3) + buttonIntervalSpacing ))
        let buttonIntervalSize = CGFloat(Int( (((screenWidth/3)*2) - (buttonIntervalSpacing*CGFloat(intervalValues.count + 1)))/CGFloat(intervalValues.count) ))
        
        let startButtonY:CGFloat = CGFloat(Int(buttonsIntervalY + buttonsIntervalH + (15 * prop)))
        
        let sectionThreeOneBeginY: CGFloat = CGFloat(Int( totalBar + sectionOneHeight + sectionTwoHeight ))
        let sectionThreeOneSpacing: CGFloat = CGFloat(Int(10 * prop))
        let sectionThreeOneItemSizeH: CGFloat = CGFloat(Int( (sectionThreeHeight - (6 * sectionThreeOneSpacing))/5 ))
        let sectionThreeOneFontSize: CGFloat = CGFloat(Int(16 * prop))
        let sectionThreeOneFontSize2: CGFloat = CGFloat(Int(18 * prop))
        let sectionThreeOneWidth: CGFloat = CGFloat(Int( screenWidth - sectionThreeHalfWidth ))
        let sectionThreeOneButtonSize: CGFloat = CGFloat(Int( sectionThreeOneWidth/2 ))
        let sectionThreeOneButtonsBeginX = CGFloat(Int( sectionThreeOneWidth - sectionThreeOneButtonSize - sectionThreeOneSpacing ))
        let sectionThreeOneTextsBeginX = CGFloat(Int( sectionThreeOneButtonsBeginX - sectionThreeOneButtonSize - sectionThreeOneSpacing ))
        
        let sectionThreeTwoFirstH = CGFloat(Int( 3*sectionThreeHeight/4 ))
        let sectionThreeTwoItemSpacing: CGFloat = CGFloat(Int(10 * prop))
        let sectionThreeTwoItemH = CGFloat(Int( (sectionThreeTwoFirstH - (5 * sectionThreeTwoItemSpacing))/4 ))
        let sectionThreeTwoItemW = CGFloat(Int( sectionThreeHalfWidth - 20 ))
        let sectionThreeTwoBeginX = CGFloat(Int( ((sectionThreeHalfWidth - sectionThreeTwoItemW)/2) + (screenWidth - sectionThreeHalfWidth) ))
        let sectionThreeTwoBeginY = CGFloat(Int( totalBar + sectionOneHeight + sectionTwoHeight ))
        let helpButtonSize = CGFloat(Int( sectionThreeTwoItemW/5 ))
        let helpButtonX = CGFloat(Int( ((sectionThreeHalfWidth - helpButtonSize)/2) + (screenWidth - sectionThreeHalfWidth) ))
        
        let heartSizeW = 35 * prop
        let heartSizeH = 30 * prop
        let heartY = ((sectionTwoHeight - heartSizeH)/2) + sectionOneHeight + totalBar - (15 * prop2)
        let heartX = (screenWidth - heartSizeW)/2
        let heartX2 = (buttonsIntervalBeginX - heartSizeW)/2
        
        heartMidX = heartX
        heartMidX2 = heartX2
        
        let heartLabelSize:CGFloat = buttonsIntervalBeginX
        let heartLabelFontSize: CGFloat = CGFloat(Int(19 * prop))
        let heartLabelX: CGFloat = 0
        let heartLabelY: CGFloat = heartY + heartSizeH + (20 * prop)
        
        heartLabelSize2 = heartLabelSize
        heartCenter = CGPointMake(heartX2 + heartSizeW/2, heartY + heartSizeH/2)
        circleMaxSize = buttonsIntervalBeginX - 10
        
        //Sections Creations
        
        let sectionOne = UIView(frame: CGRectMake(0, totalBar, screenWidth, sectionOneHeight))
        sectionOne.backgroundColor = redLightColor
        
        let sectionTwo = UIView(frame: CGRectMake(0, sectionOneHeight + totalBar, screenWidth, sectionTwoHeight))
        sectionTwo.backgroundColor = redDarkColor
        
        let sectionThreeHalf = UIView(frame: CGRectMake(0, 0, sectionThreeHalfWidth, sectionThreeHeight))
        sectionThreeHalf.frame.origin = CGPointMake(screenWidth - sectionThreeHalf.frame.width, screenHeight - sectionThreeHalf.frame.height)
        sectionThreeHalf.backgroundColor = redLightColor
        
        //Section 1
        
        resultLabel = UILabel(frame: CGRectMake(0, totalBar, screenWidth, 50))
        resultLabel.text = "Results"
        resultLabel.textColor = brownDarkColor
        resultLabel.textAlignment = .Center
        resultLabel.font = UIFont(name: "Helvetica-Light", size: 22)
        
        descriptionContainer = UIScrollView(frame: CGRectMake(0, totalBar + 50, screenWidth, sectionOneHeight - 70))
        descriptionContainer.contentSize = CGSizeMake(screenWidth, 170)
        descriptionContainer.hidden = true
        
        descriptionLabel = UILabel(frame: CGRectMake((screenWidth - 300)/2, 0, 300, 170))
        descriptionLabel.numberOfLines = 15
        descriptionLabel.text = "Welcome to beat monitor. You can use this app to monitor your heart rates periodically and, based on variations of these rates, receive notifications of irregularities on your heart beats. You can chose what kind of irregularities will send a notification: Arritimia, when your heart rate varies too much, Taquicardia, when your heart rate is too high or Baquiocardia, when it's too low. It is also needed that you inform your Age, Height, Weight and Excersising frequency in the fields below, so the app can return best results to you. "
        descriptionLabel.font = UIFont(name: "Helvetica-Light", size: 13)
        descriptionLabel.textAlignment = .Center
        descriptionLabel.textColor = brownDarkColor
        
        descriptionContainer.addSubview(descriptionLabel)
        
        graphView = GraphView(frame: CGRectMake(0, (totalBar + 50), screenWidth, sectionOneHeight - 70))
        graphView.hidden = false
        
        //Section 2
        
        nextScanLabel = UILabel(frame: CGRectMake(buttonsIntervalBeginX, nextScanTextY, 2*screenWidth/3, nextScanTextH))
        nextScanLabel.text = "Next Scan in: --:--"
        nextScanLabel.font = UIFont(name: "Helvetica-Light", size: nextScanFontSize)
        nextScanLabel.textColor = UIColor.whiteColor()
        
        scanEveryLabel = UILabel(frame: CGRectMake(buttonsIntervalBeginX, scanEveryTextY, 2*screenWidth/3, scanEveryTextH))
        scanEveryLabel.text = "Chose the scan frequency"
        scanEveryLabel.font = UIFont(name: "Helvetica-Light", size: scanEveryTextFontSize)
        scanEveryLabel.textColor = UIColor.whiteColor()
        
        heartView = UIImageView(image: UIImage(named: "Heart"))
        heartView.frame = CGRectMake(heartX2, heartY, heartSizeW, heartSizeH)
        heartView.userInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("pressHeart"))
        heartView.addGestureRecognizer(tapGesture)
        
        heartLabel = UILabel(frame: CGRectMake(heartLabelX, heartLabelY, heartLabelSize, 40))
        heartLabel.textAlignment = .Center
        heartLabel.font = UIFont(name: "Helvetica-Bold", size: heartLabelFontSize)
        heartLabel.text = "No Data"
        heartLabel.textColor = UIColor.whiteColor()
        
        for var j = 0; j < 10; j++ {
            
            let circle = UIImageView(image: UIImage(named: "Circle"))
            circle.frame = CGRectMake(heartCenter.x - 1, heartCenter.y - 1, 2, 2)
            
            heartCircles.append(circle)
            
        }
        
        for var i=0; i<intervalValues.count; i++ {
            
            let button = UIButton(frame: CGRectMake(buttonsIntervalBeginX + (buttonIntervalSize + buttonIntervalSpacing)*CGFloat(i), buttonsIntervalY, buttonIntervalSize, buttonsIntervalH))
            button.setTitle("\(intervalValues[i])", forState: .Normal)
            button.layer.borderWidth = 0
            button.layer.cornerRadius = 1
            button.clipsToBounds = true
            button.backgroundColor = UIColor.whiteColor()
            button.setTitleColor(redDarkColor, forState: .Normal)
            button.titleLabel?.font = UIFont(name: "Helvetica-Light", size: buttonsIntervalFontSize)
            button.addTarget(self, action: Selector("intervalAction:"), forControlEvents: UIControlEvents.TouchUpInside)
            
            intervalButtons.append(button)
            
        }
        
        startButton = UIButton(frame: CGRectMake(buttonsIntervalBeginX, startButtonY , buttonIntervalSize*3, buttonsIntervalH))
        startButton.setTitle("Stop", forState: .Normal)
        startButton.layer.borderWidth = 0
        startButton.layer.cornerRadius = 1
        startButton.clipsToBounds = true
        startButton.backgroundColor = UIColor.whiteColor()
        startButton.setTitleColor(redDarkColor, forState: .Normal)
        startButton.titleLabel?.font = UIFont(name: "Helvetica-Light", size: buttonsIntervalFontSize)
        startButton.addTarget(self, action: Selector("startAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        // Section 3.1
        
        button1 = UIButton(frame: CGRectMake(sectionThreeOneButtonsBeginX, sectionThreeOneBeginY + sectionThreeOneSpacing, sectionThreeOneButtonSize, sectionThreeOneItemSizeH))
        button1.setTitle("Tap to set", forState: .Normal)
        button1.layer.borderWidth = 0
        button1.layer.cornerRadius = 1
        button1.clipsToBounds = true
        button1.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        button1.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        button1.backgroundColor = redLightColor
        button1.setTitleColor(brownLightColor, forState: .Normal)
        button1.titleLabel?.font = UIFont(name: "Helvetica-Light", size: sectionThreeOneFontSize)
        button1.addTarget(self, action: Selector("setAge"), forControlEvents: UIControlEvents.TouchUpInside)
        
        button2 = UIButton(frame: CGRectMake(sectionThreeOneButtonsBeginX, sectionThreeOneBeginY + sectionThreeOneSpacing + (sectionThreeOneItemSizeH + sectionThreeOneSpacing), sectionThreeOneButtonSize, sectionThreeOneItemSizeH))
        button2.setTitle("Tap to set", forState: .Normal)
        button2.layer.borderWidth = 0
        button2.layer.cornerRadius = 1
        button2.clipsToBounds = true
        button2.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        button2.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        button2.backgroundColor = redLightColor
        button2.setTitleColor(brownLightColor, forState: .Normal)
        button2.titleLabel?.font = UIFont(name: "Helvetica-Light", size: sectionThreeOneFontSize)
        button2.addTarget(self, action: Selector("setHeight"), forControlEvents: UIControlEvents.TouchUpInside)
        
        button3 = UIButton(frame: CGRectMake(sectionThreeOneButtonsBeginX, sectionThreeOneBeginY + sectionThreeOneSpacing + 2*(sectionThreeOneItemSizeH + sectionThreeOneSpacing), sectionThreeOneButtonSize, sectionThreeOneItemSizeH))
        button3.setTitle("Tap to set", forState: .Normal)
        button3.layer.borderWidth = 0
        button3.layer.cornerRadius = 1
        button3.clipsToBounds = true
        button3.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        button3.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        button3.backgroundColor = redLightColor
        button3.setTitleColor(brownLightColor, forState: .Normal)
        button3.titleLabel?.font = UIFont(name: "Helvetica-Light", size: sectionThreeOneFontSize)
        button3.addTarget(self, action: Selector("setWeight"), forControlEvents: UIControlEvents.TouchUpInside)
        
        button4 = UIButton(frame: CGRectMake(sectionThreeOneButtonsBeginX, sectionThreeOneBeginY + sectionThreeOneSpacing + 3*(sectionThreeOneItemSizeH + sectionThreeOneSpacing), sectionThreeOneButtonSize, sectionThreeOneItemSizeH))
        button4.setTitle("Tap to set", forState: .Normal)
        button4.layer.borderWidth = 0
        button4.layer.cornerRadius = 1
        button4.clipsToBounds = true
        button4.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        button4.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        button4.backgroundColor = redLightColor
        button4.setTitleColor(brownLightColor, forState: .Normal)
        button4.titleLabel?.font = UIFont(name: "Helvetica-Light", size: sectionThreeOneFontSize)
        button4.addTarget(self, action: Selector("setExercise"), forControlEvents: UIControlEvents.TouchUpInside)
        
        clearButton = UIButton(frame: CGRectMake((sectionThreeOneWidth - sectionThreeOneButtonSize)/2, sectionThreeOneBeginY + sectionThreeOneSpacing + 4*(sectionThreeOneItemSizeH + sectionThreeOneSpacing), sectionThreeOneButtonSize, sectionThreeOneItemSizeH))
        clearButton.setTitle("Reset Data", forState: .Normal)
        clearButton.layer.borderWidth = 0
        clearButton.layer.cornerRadius = 1
        clearButton.clipsToBounds = true
        clearButton.backgroundColor = redLightColor
        clearButton.setTitleColor(redDarkColor, forState: .Normal)
        clearButton.titleLabel?.font = UIFont(name: "Helvetica", size: sectionThreeOneFontSize)
        clearButton.addTarget(self, action: Selector("clearAll"), forControlEvents: UIControlEvents.TouchUpInside)
        
        let label1 = UILabel(frame: CGRectMake(sectionThreeOneTextsBeginX, sectionThreeOneBeginY + sectionThreeOneSpacing, sectionThreeOneButtonSize, sectionThreeOneItemSizeH))
        label1.textColor = brownDarkColor
        label1.font = UIFont(name: "Helvetica-Light", size: sectionThreeOneFontSize2)
        label1.text = "Age:"
        label1.textAlignment = .Right
        
        let label2 = UILabel(frame: CGRectMake(sectionThreeOneTextsBeginX, sectionThreeOneBeginY + sectionThreeOneSpacing + 1*(sectionThreeOneItemSizeH + sectionThreeOneSpacing), sectionThreeOneButtonSize, sectionThreeOneItemSizeH))
        label2.textColor = brownDarkColor
        label2.font = UIFont(name: "Helvetica-Light", size: sectionThreeOneFontSize2)
        label2.text = "Height:"
        label2.textAlignment = .Right
        
        let label3 = UILabel(frame: CGRectMake(sectionThreeOneTextsBeginX, sectionThreeOneBeginY + sectionThreeOneSpacing + 2*(sectionThreeOneItemSizeH + sectionThreeOneSpacing), sectionThreeOneButtonSize, sectionThreeOneItemSizeH))
        label3.textColor = brownDarkColor
        label3.font = UIFont(name: "Helvetica-Light", size: sectionThreeOneFontSize2)
        label3.text = "Weight:"
        label3.textAlignment = .Right
        
        let label4 = UILabel(frame: CGRectMake(sectionThreeOneTextsBeginX, sectionThreeOneBeginY + sectionThreeOneSpacing + 3*(sectionThreeOneItemSizeH + sectionThreeOneSpacing), sectionThreeOneButtonSize, sectionThreeOneItemSizeH))
        label4.textColor = brownDarkColor
        label4.font = UIFont(name: "Helvetica-Light", size: sectionThreeOneFontSize2)
        label4.text = "Exercises:"
        label4.textAlignment = .Right
        
        // Section 3.2
        
        let label5 = UILabel(frame: CGRectMake(sectionThreeTwoBeginX, sectionThreeTwoBeginY + sectionThreeTwoItemSpacing + 0*(sectionThreeTwoItemH + sectionThreeTwoItemSpacing), sectionThreeTwoItemW, sectionThreeTwoItemH))
        label5.textColor = brownDarkColor
        label5.font = UIFont(name: "Helvetica-Light", size: sectionThreeOneFontSize2)
        label5.text = "Check for:"
        label5.textAlignment = .Left
        
        buttonA = UIButton(frame: CGRectMake(sectionThreeTwoBeginX, sectionThreeTwoBeginY + sectionThreeTwoItemSpacing + 1*(sectionThreeTwoItemH + sectionThreeTwoItemSpacing), sectionThreeTwoItemW, sectionThreeTwoItemH))
        buttonA.setTitle("Arritimia", forState: .Normal)
        buttonA.titleLabel?.textAlignment = .Left
        buttonA.layer.borderWidth = 0
        buttonA.layer.cornerRadius = 1
        buttonA.clipsToBounds = true
        buttonA.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        buttonA.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        buttonA.backgroundColor = redDarkColor
        buttonA.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        buttonA.titleLabel?.font = UIFont(name: "Helvetica-Light", size: sectionThreeOneFontSize)
        buttonA.addTarget(self, action: Selector("selectDisease:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        buttonB = UIButton(frame: CGRectMake(sectionThreeTwoBeginX, sectionThreeTwoBeginY + sectionThreeTwoItemSpacing + 2*(sectionThreeTwoItemH + sectionThreeTwoItemSpacing), sectionThreeTwoItemW, sectionThreeTwoItemH))
        buttonB.setTitle("Taquicardia", forState: .Normal)
        buttonB.titleLabel?.textAlignment = .Left
        buttonB.layer.borderWidth = 0
        buttonB.layer.cornerRadius = 1
        buttonB.clipsToBounds = true
        buttonB.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        buttonB.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        buttonB.backgroundColor = redDarkColor
        buttonB.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        buttonB.titleLabel?.font = UIFont(name: "Helvetica-Light", size: sectionThreeOneFontSize)
        buttonB.addTarget(self, action: Selector("selectDisease:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        buttonC = UIButton(frame: CGRectMake(sectionThreeTwoBeginX, sectionThreeTwoBeginY + sectionThreeTwoItemSpacing + 3*(sectionThreeTwoItemH + sectionThreeTwoItemSpacing), sectionThreeTwoItemW, sectionThreeTwoItemH))
        buttonC.setTitle("Baquiocardia", forState: .Normal)
        buttonC.titleLabel?.textAlignment = .Left
        buttonC.layer.borderWidth = 0
        buttonC.layer.cornerRadius = 1
        buttonC.clipsToBounds = true
        buttonC.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        buttonC.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        buttonC.backgroundColor = redDarkColor
        buttonC.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        buttonC.titleLabel?.font = UIFont(name: "Helvetica-Light", size: sectionThreeOneFontSize)
        buttonC.addTarget(self, action: Selector("selectDisease:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        buttonD = UIButton(frame: CGRectMake(helpButtonX, 10 + sectionThreeTwoBeginY + sectionThreeTwoItemSpacing + 4*(sectionThreeTwoItemH + sectionThreeTwoItemSpacing), helpButtonSize, helpButtonSize))
        buttonD.setTitle("?", forState: .Normal)
        buttonD.layer.borderWidth = 0
        buttonD.layer.cornerRadius = helpButtonSize/2
        buttonD.clipsToBounds = true
        buttonD.backgroundColor = redDarkColor
        buttonD.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        buttonD.titleLabel?.font = UIFont(name: "Helvetica-Regular", size: sectionThreeOneFontSize)
        buttonD.addTarget(self, action: Selector("pressHelp"), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        //Adding the Subviews
        
        self.addSubview(sectionOne)
        self.addSubview(sectionTwo)
        self.addSubview(sectionThreeHalf)
        
        for b in intervalButtons {
            self.addSubview(b)
        }
        
        self.addSubview(resultLabel)
        self.addSubview(nextScanLabel)
        self.addSubview(scanEveryLabel)
        self.addSubview(startButton)
        self.addSubview(heartView)
        self.addSubview(heartLabel)
        
        self.addSubview(button1)
        self.addSubview(button2)
        self.addSubview(button3)
        self.addSubview(button4)
        self.addSubview(clearButton)
        self.addSubview(label1)
        self.addSubview(label2)
        self.addSubview(label3)
        self.addSubview(label4)
        
        self.addSubview(label5)
        self.addSubview(buttonA)
        self.addSubview(buttonB)
        self.addSubview(buttonC)
        self.addSubview(buttonD)
        
        self.addSubview(graphView)
        self.addSubview(descriptionContainer)
        
        for a in heartCircles {
            
            self.addSubview(a)
            
        }
        
        intervalAction(intervalButtons[1]) // Padrao 20 minutos
        
    }
    
    func beginCirclesAnimation() {
        
        heartCirclesAnimating = true
        
        for var i = 0; i < self.heartCircles.count; i++ {
            
            let timer = NSTimer.scheduledTimerWithTimeInterval((0.5 * NSTimeInterval(i)), target: self, selector: Selector("growCircle:"), userInfo: i, repeats: false)
            
            heartCirclesTimers.append(timer)
            
        }
        
    }
    
    func stopCirclesAnimation() {
        
        heartCirclesAnimating = false
        
        for i in heartCirclesTimers {
            
            i.invalidate()
            
        }
        
        heartCirclesTimers = []
        
    }
    
    func growCircle(timer: NSTimer) {
        
        let i = timer.userInfo as! Int
        
        let theX = self.heartView.frame.origin.x + self.heartView.frame.size.width/2
        let theY = self.heartView.frame.origin.y + self.heartView.frame.size.height/2
        
        self.heartCircles[i].frame = CGRectMake(theX - 1, theY - 1, 2, 2)
        self.heartCircles[i].alpha = 1
        
        UIView.animateWithDuration(3.0, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () in
            
            self.heartCircles[i].frame = CGRectMake(theX - (self.circleMaxSize/2), theY - (self.circleMaxSize/2), self.circleMaxSize, self.circleMaxSize)
            self.heartCircles[i].alpha = 0
            
            }, completion: {
                (value: Bool) in
                
                if(self.heartCirclesAnimating == true) {
                    
                    self.heartCirclesTimers[i].invalidate()
                    
                    self.heartCirclesTimers[i] = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: Selector("growCircle:"), userInfo: i, repeats: false)
                }
        })
        
    }
    
    func pressHeart() {
        
        if(inTutorial == true) {
            closeTutorial()
        }
    }
    
    func closeTutorial() {
        
        inTutorial = false
        
        resultLabel.text = "Results"
        
        graphView.hidden = false
        descriptionContainer.hidden = true
        
        nextScanLabel.hidden = true
        scanEveryLabel.hidden = true
        startButton.hidden = true
        
        for i in intervalButtons {
            
            i.hidden = true
            
        }
        
        let f = heartLabel.frame
        
        heartLabel.frame = CGRectMake(f.origin.x, f.origin.y, self.frame.width, f.height)
        heartLabel.text = "Awating for watch"
        
        let f2 = heartView.frame
        
        heartView.frame = CGRectMake(heartMidX, f2.origin.y, f2.width, f2.height)
        
    }
    
    func openTutorial() {
        
        inTutorial = true
        
        resultLabel.text = "Welcome to Beat Monitor"
        
        graphView.hidden = true
        descriptionContainer.hidden = false
        
        nextScanLabel.hidden = true
        scanEveryLabel.hidden = true
        startButton.hidden = true
        
        for i in intervalButtons {
            
            i.hidden = true
            
        }
        
        let f = heartLabel.frame
        
        heartLabel.frame = CGRectMake(f.origin.x, f.origin.y, self.frame.width, f.height)
        heartLabel.text = "Tap heart to begin"
        
        let f2 = heartView.frame
        
        heartView.frame = CGRectMake(heartMidX, f2.origin.y, f2.width, f2.height)
        
    }
    
    func openTimeIntervalMenu() {
        
        if(inTutorial == true) {
            return //Only open menu if not in tutorial
        }
        
        let f = heartLabel.frame
        let f2 = heartView.frame
        
        UIView.animateWithDuration(0.5, delay: 1.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () in
            
            self.heartLabel.alpha = 0
            self.heartView.frame = CGRectMake(self.heartMidX2, f2.origin.y, f2.width, f2.height)
            
            self.nextScanLabel.alpha = 0
            self.scanEveryLabel.alpha = 0
            self.startButton.alpha = 0
            
            for i in self.intervalButtons {
                
                i.alpha = 0
                
            }
            
            }, completion: {
                (value: Bool) in
                
                self.nextScanLabel.hidden = false
                self.scanEveryLabel.hidden = false
                self.startButton.hidden = false
                
                for i in self.intervalButtons {
                    
                    i.hidden = false
                    
                }
                
                self.heartLabel.frame = CGRectMake(f.origin.x, f.origin.y, self.heartLabelSize2, f.height)
//                self.heartLabel.text = "No Data"
                
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () in
                    
                    self.nextScanLabel.alpha = 1
                    self.scanEveryLabel.alpha = 1
                    self.startButton.alpha = 1
                    
                    for i in self.intervalButtons {
                        
                        i.alpha = 1
                        
                    }
                    
                    self.heartLabel.alpha = 1
                    
                    }, completion: {
                        (value: Bool) in
                        
                })
        })
        
    }
    
    func closeTimeIntervalMenu() {
        
        let f = heartLabel.frame
        let f2 = heartView.frame
        
        UIView.animateWithDuration(0.5, delay: 1.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () in
            
            self.heartLabel.alpha = 0
            self.heartView.frame = CGRectMake(self.heartMidX, f2.origin.y, f2.width, f2.height)
            
            self.nextScanLabel.alpha = 0
            self.scanEveryLabel.alpha = 0
            self.startButton.alpha = 0
            
            for i in self.intervalButtons {
                
                i.alpha = 0
                
            }
            
            }, completion: {
                (value: Bool) in
                
                self.nextScanLabel.hidden = true
                self.scanEveryLabel.hidden = true
                self.startButton.hidden = true
                
                for i in self.intervalButtons {
                    
                    i.hidden = true
                    
                }
                
                self.heartLabel.frame = CGRectMake(f.origin.x, f.origin.y, self.frame.width, f.height)
                self.heartLabel.text = "No Data"
                
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () in
                    
                    self.nextScanLabel.alpha = 1
                    self.scanEveryLabel.alpha = 1
                    self.startButton.alpha = 1
                    
                    for i in self.intervalButtons {
                        
                        i.alpha = 1
                        
                    }
                    
                    self.heartLabel.alpha = 1
                    
                    }, completion: {
                        (value: Bool) in
                        
                })
        })
        
    }
    
    func pressHelp() {
        
        openTutorial()
        
    }
    
    func selectDisease(button: UIButton) {
        
        if(button.backgroundColor == redDarkColor) {
            button.backgroundColor = UIColor.whiteColor()
            button.setTitleColor(UIColor(red: 225/255.0, green: 207/255.0, blue: 204/255.0, alpha: 1), forState: .Normal)
        } else {
            button.backgroundColor = redDarkColor
            button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        }
        
        delegate?.didPressDiseaseButton(button.titleLabel!.text!)
        
    }
    
    func setAge() {
        
        delegate?.didPressSetAge()
        
    }
    
    func setHeight() {
        
        delegate?.didPressSetHeight()
        
    }
    
    func setWeight() {
        
        delegate?.didPressSetWeigth()
        
    }
    
    func setExercise() {
        
        delegate?.didPressSetExercise()
        
    }
    
    func clearAll() {
        
        print("Cleared All")
        
    }
    
    func intervalAction(button: UIButton) {
        
        for i in intervalButtons {
            
            if(i.titleLabel!.text == button.titleLabel!.text!) {
                i.backgroundColor = redMiddleColor
                i.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            } else {
                i.backgroundColor = UIColor.whiteColor()
                i.setTitleColor(redDarkColor, forState: .Normal)
            }
            
        }
        
        scanEveryLabel.text = "Scan every \(button.titleLabel!.text!) minutes"
        
        let string = button.titleLabel!.text!
        let number = Int(string)
        delegate?.didChangeIntervalValue(number!)
        
    }
    
    func startAction(button: UIButton) {
        
        if(button.titleLabel!.text! == "Start") {
            button.setTitle("Stop", forState: .Normal)
            delegate?.didPressStartButton(true)
        } else {
            button.setTitle("Start", forState: .Normal)
            delegate?.didPressStartButton(false)
        }
        
    }
    
    func refreshGraphData(data: Array<Int>) {
        
        graphView.heartBeatValues = data
        
        graphView.removeFromSuperview()
        
        self.addSubview(graphView)
        
    }
    
    func resetVisualData() {
        
        button1.setTitle("Tap to set", forState: .Normal)
        button2.setTitle("Tap to set", forState: .Normal)
        button3.setTitle("Tap to set", forState: .Normal)
        button4.setTitle("Tap to set", forState: .Normal)
        
        buttonA.backgroundColor = redDarkColor
        buttonA.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        buttonB.backgroundColor = redDarkColor
        buttonB.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        buttonC.backgroundColor = redDarkColor
        buttonC.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        graphView.removeFromSuperview()
        
        self.addSubview(graphView)
        
    }
    
    //Set functions
}
