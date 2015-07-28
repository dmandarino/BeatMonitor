//
//  PushNotification.swift
//  BeatMonitor
//
//  Created by Douglas Mandarino on 7/27/15.
//  Copyright © 2015 Douglas Mandarino. All rights reserved.
//

import Foundation
import UIKit

class PushNotification {
    
    class func sendNotification(message:String) {
        
        let localNotification = UILocalNotification()
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 5)
        localNotification.alertBody = message
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        localNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
}