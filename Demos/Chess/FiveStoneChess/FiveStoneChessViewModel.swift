//
//  FiveStoneChessViewModel.swift
//  Demos
//
//  Created by 焦国辉 on 2018/11/30.
//  Copyright © 2018 zyxx. All rights reserved.
//

import Foundation

class FiveStoneChessViewModel {
    var model = FiveStoneChessModel()
    var stepCounts: Int {
        get {
            return model.steps.count
        }
    }
    
    
    func initModel() {
        self.model.steps = []
        self.model.isOver = false
    }
    
    func backStep() {
        self.model.steps.removeLast()
    }
    
    func modelStepsContains(key: String) -> Bool {
        let step1 = key + "-Black"
        let step2 = key + "-White"
        return self.model.steps.contains(step1) || self.model.steps.contains(step2)
     }
    func modelStepsContains(step: String) -> Bool {
        return self.model.steps.contains(step)
    }
    
    func modelStepsAppend(_ key: String) {
        let step = key + (self.model.isBlack ? "-Black" : "-White")
        self.model.steps.append(step)
    }
    
    
    
    
    
    func isFive(col: Int, row: Int) -> Bool {
        let isBlack = !self.model.isBlack ? "-Black" : "-White"
        var count = 1
        //横向
        for i in 1...4 {
            let key = "\(col + i)-\(row)"
            let step = key + isBlack
            if self.modelStepsContains(step: step) {
                count += 1
            }
        }
        for i in 1...4 {
            let key = "\(col - i)-\(row)"
            let step = key + isBlack
            if self.modelStepsContains(step: step) {
                count += 1
            }
        }
        if count >= 5 {
            self.model.isOver = true
            return true
        }
        
        count = 1
        //纵向
        for i in 1...4 {
            let key = "\(col)-\(row + i)"
            let step = key + isBlack
            if self.modelStepsContains(step: step) {
                count += 1
            }
        }
        for i in 1...4 {
            let key = "\(col)-\(row - i)"
            let step = key + isBlack
            if self.modelStepsContains(step: step) {
                count += 1
            }
        }
        if count >= 5 {
            self.model.isOver = true
            return true
        }
        
        
        count = 1
        //升向
        for i in 1...4 {
            let key = "\(col + i)-\(row + i)"
            let step = key + isBlack
            if self.modelStepsContains(step: step) {
                count += 1
            }
        }
        for i in 1...4 {
            let key = "\(col - i)-\(row - i)"
            let step = key + isBlack
            if self.modelStepsContains(step: step) {
                count += 1
            }
        }
        if count >= 5 {
            self.model.isOver = true
            return true
        }
        
        
        count = 1
        //降向
        for i in 1...4 {
            let key = "\(col + i)-\(row - i)"
            let step = key + isBlack
            if self.modelStepsContains(step: step) {
                count += 1
            }
        }
        for i in 1...4 {
            let key = "\(col - i)-\(row + i)"
            let step = key + isBlack
            if self.modelStepsContains(step: step) {
                count += 1
            }
        }
        if count >= 5 {
            self.model.isOver = true
            return true
        }
        
        return false
    }
    
    func saveModel(withKey key:String) {
        let data = try! JSONEncoder().encode(self.model)
        
        
        let docPath = NSHomeDirectory() + "/Documents/FiveStoneChess/"
        try! FileManager.default.createDirectory(atPath: docPath, withIntermediateDirectories: true, attributes: nil)
        print(docPath)
        let filePath = docPath + key
        try! data.write(to: URL(fileURLWithPath: filePath))
    }
    
    

}
