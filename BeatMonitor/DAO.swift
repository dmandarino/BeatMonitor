//
//  DAO.swift
//  BeatMonitor
//
//  Created by Douglas Mandarino on 7/26/15.
//  Copyright © 2015 Douglas Mandarino. All rights reserved.
//

import Foundation

class DAO {
   
    class func saveUserData(jsonString:String) {
        
        let path = getPath("User")
        let dict: NSMutableDictionary = ["User": jsonString]
        
        //saving values
        dict.setObject(jsonString, forKey: "User")
        dict.writeToFile(path, atomically: true)
    }
    
    class func saveResultsData(results:[Int]) {
        
        let path = getPath("Results")
        let dict: NSMutableDictionary = ["Results": results]
        
        //saving values
        dict.setObject(results, forKey: "Results")
        dict.writeToFile(path, atomically: true)
    }

    
    class func loadUserData() -> String{
   
        let path = getPath("User")
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
            let schedules: AnyObject? = dict["User"]
            if schedules?.description != nil{
                return schedules!.description
            }
        } else {
            print("WARNING: Couldn't create dictionary from plist! Default values will be used!")
        }
        return ""
    }
    
    
//    class func loadUserData() -> [Int]{
//        
//        let path = getPath("Results")
//        _ = NSFileManager.defaultManager()
//        
//        _ = NSMutableDictionary(contentsOfFile: path)
//        let myDict = NSDictionary(contentsOfFile: path)
//        if let dict = myDict {
//            let results: AnyObject? = dict["Results"]
//            if results?.description != nil {
//                return results!.description
//            }
//        } else {
//            print("WARNING: Couldn't create dictionary from plist! Default values will be used!")
//        }
//        return [0,0,0,0,0,0,0,0,0,0]
//    }
    
    private class func getPath(key:String) -> String{
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent(key+".plist")
        return path
    }
}