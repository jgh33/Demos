//
//  FiveStoneChessModel.swift
//  Demos
//
//  Created by 焦国辉 on 2018/11/30.
//  Copyright © 2018 zyxx. All rights reserved.
//

import Foundation

class FiveStoneChessModel {
    
    fileprivate let lineCounts = 15
    
    var steps:[String] = []
    var isOver: Bool = false
    var isBlack: Bool {
        get {
            if steps.count % 2 == 0 {
                return true
            }
            return false
        }
    }
    
}
