//
//  JSONService.swift
//  BeatMonitor
//
//  Created by Douglas Mandarino on 7/26/15.
//  Copyright © 2015 Douglas Mandarino. All rights reserved.
//

import Foundation

class JSONService {
    
    init(){
        
    }
    
    func stringfyUser(user:User) -> String {
        
        let userObj:AnyObject = [ "age" : user.age.stringValue, "weight" : user.weight.stringValue, "height" : user.height.stringValue, "practiseExercise" : user.practiseExercise.description, "intensity" : user.intensity.rawValue ]
        
        let jsonString = JSONStringify(userObj)
        return jsonString
    }
    
    func convertStringToUser(jsonString:String) -> User{
        
        let array = JSONParseArray(jsonString)
        for dict:AnyObject in array {
            
            let age = dict["age"] as! NSNumber
            let weight = dict["weight"] as! NSNumber
            let height = dict["height"] as! NSNumber
            let practiseExercise = dict["practiseExercise"] as! Bool
            let intensity = dict["itensity"] as! Exercise
            
            let user:User = User(age: age, weight: weight, height: height, practiseExercise: practiseExercise, intensity: intensity)
            
            return user
        }

        return User(age: 0, weight: 0, height: 0, practiseExercise: false, intensity: Exercise.Never)
    }
    
    
    private func JSONStringify(value: AnyObject, prettyPrinted: Bool = false) -> String {
        let options:NSJSONWritingOptions! = prettyPrinted ? NSJSONWritingOptions.PrettyPrinted : nil
        var data:NSData!
        
        if NSJSONSerialization.isValidJSONObject(value) {

            do{
                data = try NSJSONSerialization.dataWithJSONObject(value, options: options!)
            
                if (data != nil) {
                    if let string = NSString(data: data, encoding: NSUTF8StringEncoding) {
                        return string as String
                    }
                }
                
            } catch {
               print("erro para converter pra string")
            }
        }
        return ""
    }
    
    private func JSONParseArray(jsonString: String) -> [AnyObject] {
        if let data = jsonString.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                if let array = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0))  as? [AnyObject] {
                    return array
                }
            } catch {
                print("error json parse")
            }
        }
        return [AnyObject]()
    }
}