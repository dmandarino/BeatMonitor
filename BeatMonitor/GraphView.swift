//
//  GraphView.swift
//  BeatMonitor
//
//  Created by Joao Nassar Galante Guedes on 26/07/15.
//  Copyright © 2015 Douglas Mandarino. All rights reserved.
//

import UIKit

class GraphView: UIView {
    
    let redLightColor = UIColor(red: 247/255.0, green: 241/255.0, blue: 242/255.0, alpha: 1)
    let redDarkColor = UIColor(red: 212/255.0, green: 14/255.0, blue: 49/255.0, alpha: 1)
    let redMiddleColor = UIColor(red: 255/255.0, green: 26/255.0, blue: 66/255.0, alpha: 1)
    let brownDarkColor = UIColor(red: 68/255.0, green: 14/255.0, blue: 28/255.0, alpha: 1)
    let brownLightColor = UIColor(red: 157/255.0, green: 105/255.0, blue: 90/255.0, alpha: 1)
    
    var heartBeatValues: Array<Int> = []//[55,77,80,100,110,94,80,75,98]
    
    override func drawRect(rect: CGRect) {
        
        if(heartBeatValues.count > 0) {
            
            var maxV = 0
            
            for x in heartBeatValues {
                
                if(x > maxV) {
                    maxV = x
                }
                
            }
            
            var minV = 999
            
            for x in heartBeatValues {
                
                if(x < minV) {
                    minV = x
                }
                
            }
            
            let borderSize:CGFloat = 20
            let maxSize = (8 * rect.height)/9
            let divisionSizeV = maxSize/CGFloat(maxV - minV)
            let divisionSizeH = ((rect.width - (2 * borderSize))/(CGFloat(heartBeatValues.count)-1))
            
            let ctx = UIGraphicsGetCurrentContext()
            CGContextSetRGBStrokeColor(ctx, 157/255.0, 105/255.0, 90/255.0, 1)
            CGContextSetLineWidth(ctx, 1)
            CGContextMoveToPoint(ctx, borderSize, rect.height - (CGFloat(heartBeatValues[0] - minV) * divisionSizeV ))
            
            for var i=0; i < heartBeatValues.count; i++ {
                
                let y = CGFloat(Int( rect.height - (CGFloat(heartBeatValues[i] - minV) * divisionSizeV) ))
                let xp = CGFloat(Int( (CGFloat(i) * divisionSizeH) + borderSize ))
                CGContextAddLineToPoint(ctx, xp, y)
                CGContextStrokePath(ctx)
                CGContextMoveToPoint(ctx, xp, y)
                
                let label = UILabel(frame: CGRectMake(0, 0, 100, 40))
                label.center = CGPointMake(xp, y - 10)
                label.textColor = UIColor(red: 212/255.0, green: 14/255.0, blue: 49/255.0, alpha: 1)
                label.textAlignment = .Center
                label.text = "\(heartBeatValues[i])"
                label.font = UIFont(name: "Helvetica-Light", size: 13)
                
                self.addSubview(label)
                
            }
            
        } else {
            
            let label = UILabel(frame: CGRectMake(0, 0, 100, 40))
            label.center = CGPointMake(CGFloat(Int(  rect.width/2 )), CGFloat(Int(  rect.height/2 )))
            label.textColor = UIColor(red: 212/255.0, green: 14/255.0, blue: 49/255.0, alpha: 1)
            label.textAlignment = .Center
            label.text = "No results yet"
            label.font = UIFont(name: "Helvetica-Light", size: 13)
            
            self.addSubview(label)
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
    }
    
}