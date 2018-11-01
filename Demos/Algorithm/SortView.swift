//
//  SortView.swift
//  Demos
//
//  Created by 焦国辉 on 2018/10/24.
//  Copyright © 2018 zyxx. All rights reserved.
//

import UIKit

let kBarHeightMax = 100
let kBarHeightMin = 20
let theTimeInterval = 0.002
let kBarCount = 100


class SortView: UIView {

    
    var array = [Int]()
    let edgeDistance:CGFloat = 20
    let upDistance:CGFloat = 180
    let downDistance:CGFloat = 350
    var y:CGFloat {
        return  self.bounds.height - downDistance
    }
    
    
    
    
    
    override func draw(_ rect: CGRect) {
        
        for (index, value) in array.enumerated() {
            let path = UIBezierPath()
            let x = edgeDistance + (self.bounds.width - 2 * edgeDistance) * CGFloat(index) / CGFloat(array.count)
            path.move(to: CGPoint(x: x, y: y))
            let endPoint = CGPoint(x: x, y: y - CGFloat(value) * (self.bounds.height - upDistance - downDistance) / CGFloat(kBarHeightMax))
            path.addLine(to: endPoint)
            path.lineWidth = 1.0
            UIColor.blue.setStroke()
            path.stroke()
        }
        
    }

}
