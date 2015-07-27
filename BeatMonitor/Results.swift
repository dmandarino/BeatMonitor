//
//  Results.swift
//  BeatMonitor
//
//  Created by Douglas Mandarino on 7/27/15.
//  Copyright © 2015 Douglas Mandarino. All rights reserved.
//

import Foundation

class Results {
    
    var results:[Int]
    
    init(){
        results = [0,0,0,0,0,0,0,0,0,0]
    }
    
    func reorganizeResults(results:[Int]) {
        
        var array = results
        array.removeAtIndex(0)
        
        self.results = array
    }
}