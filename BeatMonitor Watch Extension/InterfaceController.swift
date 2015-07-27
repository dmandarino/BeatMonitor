//
//  InterfaceController.swift
//  teste_watch WatchKit Extension
//
//  Created by Victor Souza on 7/27/15.
//  Copyright © 2015 Victor Souza. All rights reserved.
//

import WatchKit
import Foundation
import HealthKit
import WatchConnectivity


class InterfaceController: WKInterfaceController, HKWorkoutSessionDelegate, WCSessionDelegate  {
    
    let healthStore: HKHealthStore = HKHealthStore()
    
    @IBOutlet var label: WKInterfaceLabel!
    
    @IBOutlet var scan: WKInterfaceLabel!
    
    var session : WCSession!
    
    var workoutStartDate: NSDate?
    var workoutEndDate: NSDate?
    
    var queries: [HKQuery] = []
    
    var heartRateSampless: [HKQuantitySample] = []
    let countPerMinuteUnit = HKUnit(fromString: "count/min")
    
    let heartRateType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)
    
    var currentHeartRateSample: HKQuantitySample?
    
    var currentHeartRateQuantity: HKQuantity!
    
    
    var activityType: HKWorkoutActivityType?
    var locationType: HKWorkoutSessionLocationType?
    
    var workoutSession: HKWorkoutSession?
    
    var beginDate = NSDate()
    
    var intervalo = Double()
    
    override func willActivate() {
        super.willActivate()
        
        scan.setText("Connecting...")
        
        beginSession()
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        label.setText("hasn't been updated yet")
        
        activityType = HKWorkoutActivityType.MindAndBody
        
        locationType = HKWorkoutSessionLocationType.Indoor
        
        
        let typesToShare = Set([HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)!])
        let typesToRead = Set([
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)!,
            
            ])
        
        self.healthStore.requestAuthorizationToShareTypes(typesToShare, readTypes: typesToRead) { (sucess, error) -> Void in
            
            
            print(sucess)
            print(error)
            
            if error == nil {
                
                self.label.setText("----")
                
            }
            
        }
        
        setupWorkout()
    }
    
    func setupWorkout() {
        
//        let variation = NSDate().timeIntervalSinceDate(beginDate)
        
        workoutSession = HKWorkoutSession(activityType: activityType!, locationType: locationType!)
        
        workoutSession!.delegate = self
        
        healthStore.startWorkoutSession(workoutSession!)
        
        createStreamingHeartRateQuery(NSDate())
        
    }
    
    func delay(delay:Double, closure:()->()) {
        
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    
    func getHeartRateSamples(samples: [HKSample]?) {
        guard let heartRateSamples = samples as? [HKQuantitySample] else { return }
        
        self.heartRateSampless = heartRateSamples
        
        for sample in heartRateSamples {
            print(sample.quantity)
            print(sample.startDate)
            
            let string = String(sample.quantity)
            
//            let heartRate = sample.quantity
//            let heartRateDouble = heartRate.doubleValueForUnit(countPerMinuteUnit)
            
            let counter = string.stringByReplacingOccurrencesOfString(" count/min", withString: "")
            
            sendToPhone(string)
            
            self.label.setText("\(counter)")
            
            self.scan.setText("Scanning...")
            
        }
        
        healthStore.endWorkoutSession(workoutSession!)
        
        delay(intervalo) {
            
            self.workoutSession = HKWorkoutSession(activityType: self.activityType!, locationType: self.locationType!)
            
            self.workoutSession!.delegate = self
            
            self.healthStore.startWorkoutSession(self.workoutSession!)
        }
    }
    
    func sendToPhone(counter: String) {
        
        let applicationData = ["counterValue":counter]
        
        session.sendMessage(applicationData, replyHandler: {(_: [String : AnyObject]) -> Void in
            // handle reply from iPhone app here
            }, errorHandler: {(error ) -> Void in
                // catch any errors here
        })
        
    }
    
    
    func createStreamingHeartRateQuery(workoutStartDate: NSDate) -> HKQuery {
        
        
        let predicate = HKQuery.predicateForSamplesWithStartDate(workoutStartDate, endDate: nil, options: .None)
        let type = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)
        let heartRateQuery = HKAnchoredObjectQuery(type: type!, predicate: predicate, anchor: 0, limit: 0) { (query, samples, deletedObjects, anchor, error) -> Void in
            
        }
        
        heartRateQuery.updateHandler = {
            (query, samples, deletedObjects, anchor, error) -> Void in
            
            self.getHeartRateSamples(samples)
            
        }
        
        healthStore.executeQuery(heartRateQuery)
        
        _ = { (samples: [HKQuantitySample]) -> Void in
            
        }
        
        
        return heartRateQuery
        
    }
    
    func workoutSession(workoutSession: HKWorkoutSession, didChangeToState toState: HKWorkoutSessionState, fromState: HKWorkoutSessionState, date: NSDate) {
        
        
        
    }
    
    func workoutSession(workoutSession: HKWorkoutSession, didFailWithError error: NSError) {
        
        
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        
        intervalo = (message["intervalo"] as? Double)!
        print(intervalo)
        
    }
    
    func beginSession() {
        
        if (WCSession.isSupported()) {
            session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
    }
    
}
