//
//  DAO.swift
//  BeatMonitor
//
//  Created by Douglas Mandarino on 7/26/15.
//  Copyright © 2015 Douglas Mandarino. All rights reserved.
//

import Foundation

class DAO {
   
    class func saveScheduleData(jsonString:User, key:String) {
        
        let path = getPath(key)
        let dict: NSMutableDictionary = [key: jsonString]
        
        //saving values
        dict.setObject(jsonString, forKey: key)
        dict.writeToFile(path, atomically: true)
    }
    
    class func loadScheduleData(key:String) -> String{
   
        let path = getPath(key)
        _ = NSFileManager.defaultManager()
        //check if file exists
//        if(!fileManager.fileExistsAtPath(path)) {
//            // If it doesn't, copy it from the default file in the Bundle
//            if let bundlePath = NSBundle.mainBundle().pathForResource(key, ofType: "plist") {
//                _ = NSMutableDictionary(contentsOfFile: bundlePath)
//                
//                do {
//                    fileManager.copyItemAtPath(bundlePath, toPath: path)
//                } catch {
//                    
//                }
//            }
//        }
        _ = NSMutableDictionary(contentsOfFile: path)
        
        let myDict = NSDictionary(contentsOfFile: path)
        if let dict = myDict {
            let schedules: AnyObject? = dict[key]
            if schedules?.description != nil{
                return schedules!.description
            }
        } else {
            print("WARNING: Couldn't create dictionary from plist! Default values will be used!")
        }
        return ""
    }
    
    private class func getPath(key:String) -> String{
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent(key+".plist")
        return path
    }
}