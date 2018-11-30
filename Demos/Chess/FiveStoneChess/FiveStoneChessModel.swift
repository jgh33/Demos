//
//  FiveStoneChessModel.swift
//  Demos
//
//  Created by 焦国辉 on 2018/11/30.
//  Copyright © 2018 zyxx. All rights reserved.
//

import Foundation

//typealias Step = (key:String, isBlack: Bool)
class FiveStoneChessModel: Codable {
    
    var steps:[String]
    var isOver: Bool
    var isBlack: Bool {
        get {
            if steps.count % 2 == 0 {
                return true
            }
            return false
        }
    }
    
    init() {
        self.steps = []
        self.isOver = false
    }
    
   
    
    
}
