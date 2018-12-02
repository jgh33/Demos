//
//  SortAlgorithmViewController.swift
//  Demos
//
//  Created by 焦国辉 on 2018/10/24.
//  Copyright © 2018 zyxx. All rights reserved.
//

import UIKit



class SortViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sortsSegmentedControl: UISegmentedControl!
    
    private var datas = [Int]()
    private var timer: Timer!
    private var beginTimer: TimeInterval = 0
    var sema = DispatchSemaphore(value: 1)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.timer = Timer.scheduledTimer(withTimeInterval: theTimeInterval, repeats: true, block: {timer in
            self.sema.signal()
            print("AAA")
            let interval = Date().timeIntervalSince1970 - self.beginTimer
            let millisecond = Int(round(interval * 1000))
            self.timeLabel.text = "耗时\(millisecond)毫秒"
        })
        reset()
    }
    
    @IBAction func playItemAction(_ sender: UIBarButtonItem) {
        play()
    }
    
    @IBAction func refreshItemAction(_ sender: UIBarButtonItem) {
        reset()
    }
    
    @IBAction func changeSort(_ sender: UISegmentedControl) {
        reset()
    }
    
    
    @IBAction func playButtonAction(_ sender: UIButton) {
        play()
    }
    
    @IBAction func refreshButtonAction(_ sender: UIButton) {
        reset()
    }
    private func reset() {
        self.timer.fireDate = Date.distantFuture
        datas = []
        timeLabel.text = nil
        for _ in 1 ... kBarCount {
            datas.append(Int(arc4random_uniform(UInt32(kBarHeightMax - kBarHeightMin)) + UInt32(kBarHeightMin)))
        }
        (self.view as! SortView).array = datas
        self.view.setNeedsDisplay()
    }
    
    private func play() {
        self.beginTimer = Date().timeIntervalSince1970
        self.timer.fireDate = Date.distantPast
        
        let index = self.sortsSegmentedControl.selectedSegmentIndex
        DispatchQueue.global().async {
            switch index {
            case 0:
                self.selectionSort()
            case 1:
                self.bubbleSort()
            case 2:
                self.insertionSort()
            case 3:
                self.quickSort()
            default:
                print("--------")
            }
            self.timer.fireDate = Date.distantFuture
//            self.printArray()
        }
    }
    
    
    private func comp(fromA s1:Int, toB s2:Int) -> IsDescending{
        self.sema.wait()
        return s1 > s2
    }
    
//    private func printArray() {
//        print("数组：\(self.datas)")
//    }
    
    //MARK: --排序算法
    private func selectionSort(){
        self.datas.selectionF(usingComparator: { (s1, s2) -> IsDescending in
            return comp(fromA: s1, toB: s2)
        }) {
            self.drowSortView()
        }
    }
    
    
    private func bubbleSort(){
        self.datas.bubbleF(usingComparator: { (s1, s2) -> IsDescending in
            return comp(fromA: s1, toB: s2)
        }) {
            self.drowSortView()
        }
        
    }
    private func insertionSort(){
        self.datas.insertionF(usingComparator: { (s1, s2) -> IsDescending in
            return comp(fromA: s1, toB: s2)
        }) {
            self.drowSortView()
        }
        
    }
    
    private func quickSort(){
        self.datas.quickF(usingComparator: { (s1, s2) -> IsDescending in
            return comp(fromA: s1, toB: s2)
        }) {
            self.drowSortView()
        }
        
    }
    
    func drowSortView() {
        
        DispatchQueue.main.async {
            (self.view as! SortView).array = self.datas
            self.view.setNeedsDisplay()
            
        }
    }

}
