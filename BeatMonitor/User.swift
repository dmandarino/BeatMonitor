//
//  User.swift
//  BeatMonitor
//
//  Created by Douglas Mandarino on 7/26/15.
//  Copyright © 2015 Douglas Mandarino. All rights reserved.
//

import Foundation

class User {
    
    var age:NSNumber
    var weight:NSNumber
    var height:NSNumber
    var practiseExercise:Bool
    var intensity:Exercise
    
    init(age:NSNumber, weight:NSNumber, height:NSNumber, practiseExercise:Bool, intensity:Exercise){

        self.age = age
        self.weight = weight
        self.height = height
        self.practiseExercise = practiseExercise
        self.intensity = intensity
    }
}