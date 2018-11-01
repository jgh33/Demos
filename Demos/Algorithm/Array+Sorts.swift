//
//  SortAlgorithms.swift
//  Demos
//
//  Created by 焦国辉 on 2018/10/24.
//  Copyright © 2018 zyxx. All rights reserved.
//

import Foundation

extension Array {
    
    //MARK: --Base Func
    //交换两个元素
    private mutating func exchange(forIndex indexA:Index, andIndex indexB:Index, didExchange exchangeCallBack:(()->Void)?) {
        let tem = self[indexA]
        self[indexA] = self[indexB]
        self[indexB] = tem
        if let back = exchangeCallBack {
            back()
        }
    }
    
    
    //MARK: --Sort Func
    
    mutating func selectionF(usingComparator comparator:((Element,Element) -> ComparisonResult), didExchange exchangeCallback:(()->Void)?){
        if self.count == 0 {
            return
        }
        for i in 0 ..< (self.count - 1){
            for j in i + 1 ..< self.count{
                if comparator(self[i], self[j]) == .orderedDescending  {
                    exchange(forIndex: i, andIndex: j, didExchange: exchangeCallback)
                }
            }
        }
    }
    
    mutating func bubbleF(usingComparator comparator:((Element,Element) -> ComparisonResult), didExchange exchangeCallback:(()->Void)?){
        if self.count == 0 {
            return
        }
        
        var len = self.count
        var flag = true
        while flag {
            flag = false
            for i in 0..<len - 1 {
                if comparator(self[i], self[i + 1]) == .orderedDescending {
                    exchange(forIndex: i, andIndex: i + 1, didExchange: exchangeCallback)
                    flag = true
                }
            }
            len -= 1
        }
        
    }
    
    mutating func insertionF(usingComparator comparator:((Element,Element) -> ComparisonResult), didExchange exchangeCallback:(()->Void)?){
        for i in 1 ..< self.count{
            for  j in (0...i - 1).reversed() {
                if comparator(self[j + 1], self[j]) == .orderedAscending{
                    exchange(forIndex: j + 1, andIndex: j, didExchange: exchangeCallback)
                }
                
            }
        }
    }
    
    mutating func quickF(usingComparator comparator:((Element,Element) -> ComparisonResult), didExchange exchangeCallback:(()->Void)?){
        if self.count == 0 {
            return
        }
        quickSort(withLowIndex: 0, heightIndex: self.count - 1, usingComparator:comparator, didExechange: exchangeCallback)
        
        
        
        
        
    }
    private mutating func quickSort(withLowIndex low:Index, heightIndex height:Index, usingComparator comparator:((Element,Element) -> ComparisonResult), didExechange exchangeCallback:(()->Void)?){
        if low  >= height{
            return
        }
        let pivotIndex = quickParttition(withLowIndex: low, heightIndex: height, usingComparator: comparator, didExechange: exchangeCallback)
        quickSort(withLowIndex: low, heightIndex: pivotIndex - 1, usingComparator: comparator, didExechange: exchangeCallback)
        quickSort(withLowIndex: pivotIndex + 1, heightIndex: height, usingComparator: comparator, didExechange: exchangeCallback)
    }
    
    private mutating func quickParttition(withLowIndex low:Index, heightIndex height:Index, usingComparator comparator:((Element,Element) -> ComparisonResult), didExechange exchangeCallback:(()->Void)?) -> Int{
        let pivot = self[low]
        var i = low
        var j = height
        while i < j {
            while i < j && comparator(self[j], pivot) != .orderedAscending{
                j = j - 1
            }
            if (i < j) {
                // i、j未相遇，说明找到了小于pivot的元素。交换。
                self.exchange(forIndex: i, andIndex: j, didExchange: exchangeCallback)
                i = i + 1
            }
            
            /// 略过小于等于pivot的元素
            while (i < j && comparator(self[i], pivot) != .orderedDescending) {
                i = i + 1
            }
            if (i < j) {
                // i、j未相遇，说明找到了大于pivot的元素。交换。
                exchange(forIndex: i, andIndex: j, didExchange: exchangeCallback)
                j = j - 1
            }
        }
        return i
        
    }
    
    
    
}
