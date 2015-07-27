//
//  Exercise.swift
//  BeatMonitor
//
//  Created by Douglas Mandarino on 7/26/15.
//  Copyright © 2015 Douglas Mandarino. All rights reserved.
//

import Foundation

enum Exercise: String {
    
    case Never = "never", Rarely = "rarely", Usually = "usually", Always = "always"
        
    static let allValues = [Never, Rarely, Usually, Always]
}