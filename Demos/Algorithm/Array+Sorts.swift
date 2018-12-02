//
//  SortAlgorithms.swift
//  Demos
//
//  Created by 焦国辉 on 2018/10/24.
//  Copyright © 2018 zyxx. All rights reserved.
//

import Foundation
typealias IsDescending = Bool
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
    
    mutating func selectionF(usingComparator comparator:((Element,Element) -> IsDescending), didExchange exchangeCallback:(()->Void)?){
        if count < 2 {
            return
        }
        var minIndex = 0
       
        for i in 1 ... (count - 1) {
            minIndex = i - 1
            for j in i ... (count - 1) {
                if comparator(self[minIndex], self[j])  {
                    minIndex = j
                }
            }
            exchange(forIndex: i - 1, andIndex: minIndex, didExchange: exchangeCallback)
        }
    }
    
    mutating func bubbleF(usingComparator comparator:((Element,Element) -> IsDescending), didExchange exchangeCallback:(()->Void)?){
        if count < 2 {
            return
        }
        
        for i in 1 ... (count - 1) {
            for j in 0 ... (count - 1 - i) {
                if comparator(self[j], self[j + 1]) {
                    exchange(forIndex: j, andIndex: j + 1, didExchange: exchangeCallback)
                }
            }
        }
        
    }
    
    mutating func insertionF(usingComparator comparator:((Element,Element) -> IsDescending), didExchange exchangeCallback:(()->Void)?){
        for i in 1 ... (count - 1) {
            for  j in (0...i - 1).reversed() {
                if comparator(self[j + 1], self[j]) {
                    exchange(forIndex: j + 1, andIndex: j, didExchange: exchangeCallback)
                }
                
            }
        }
    }
    
    mutating func quickF(usingComparator comparator:((Element,Element) -> IsDescending), didExchange exchangeCallback:(()->Void)?){
        if self.count < 2 {
            return
        }
        quickSort(withLowIndex: 0, heightIndex: self.count - 1, usingComparator:comparator, didExechange: exchangeCallback)
        
        
        
        
        
    }
    private mutating func quickSort(withLowIndex low:Index, heightIndex height:Index, usingComparator comparator:((Element,Element) -> IsDescending), didExechange exchangeCallback:(()->Void)?){
        if low  >= height{
            return
        }
        let pivotIndex = quickParttition(withLowIndex: low, heightIndex: height, usingComparator: comparator, didExechange: exchangeCallback)
        quickSort(withLowIndex: low, heightIndex: pivotIndex - 1, usingComparator: comparator, didExechange: exchangeCallback)
        quickSort(withLowIndex: pivotIndex + 1, heightIndex: height, usingComparator: comparator, didExechange: exchangeCallback)
    }
    
    private mutating func quickParttition(withLowIndex low:Index, heightIndex height:Index, usingComparator comparator:((Element,Element) -> IsDescending), didExechange exchangeCallback:(()->Void)?) -> Int{
        let pivot = self[low]
        var i = low
        var j = height
        while i < j {
            while i < j && comparator(self[j], pivot) {
                j = j - 1
            }
            if (i < j) {
                // i、j未相遇，说明找到了小于pivot的元素。交换。
                self.exchange(forIndex: i, andIndex: j, didExchange: exchangeCallback)
                i = i + 1
            }
            
            /// 略过小于等于pivot的元素
            while (i < j && !comparator(self[i], pivot)) {
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
