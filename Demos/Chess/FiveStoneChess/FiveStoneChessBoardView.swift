//
//  BoardView.swift
//  Demos
//
//  Created by 焦国辉 on 2018/10/30.
//  Copyright © 2018 zyxx. All rights reserved.
//

import UIKit

//五子棋
fileprivate let kLineCounts:CGFloat = 15
fileprivate let kStoneGridRatio: CGFloat = 0.8
fileprivate let kBoardEdge:CGFloat = 20
fileprivate let kGridWidth = (kViewWidth - 2 * kBoardEdge) / (kLineCounts - 1)
fileprivate let kStoneR = kGridWidth / 2 - 4



enum Direction {
    case horizontal, vertical, obliqueDown, obliqueUp
}

class FiveStoneChessBoardView: UIView {
    var steps:[String] = []
    var stoneSteps: [String: UIView] = [:]
    var isOver: Bool = false
    var isBlack: Bool {
        get {
            if stoneSteps.count % 2 == 0 {
                return true
            }
            return false
        }
    }


    //MARK:--绘制五子棋棋盘
    func drawBoard(size: CGSize) {
        UIGraphicsBeginImageContext(size)
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.setLineWidth(1.0)
        
        for i in 0 ... 14 {
            
            
            ctx?.move(to: CGPoint(x: kBoardEdge + CGFloat(i) * kGridWidth, y: kBoardEdge))
            ctx?.addLine(to: CGPoint(x: kBoardEdge + CGFloat(i) * kGridWidth, y: kBoardEdge + (kLineCounts - 1) * kGridWidth))
            
            ctx?.move(to: CGPoint(x: kBoardEdge, y: kBoardEdge + CGFloat(i) * kGridWidth))
            ctx?.addLine(to: CGPoint(x: kBoardEdge + (kLineCounts - 1) * kGridWidth, y: kBoardEdge + CGFloat(i) * kGridWidth))
        }
        
        ctx?.strokePath()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        self.addSubview(UIImageView(image: image!))
        UIGraphicsEndImageContext()
        
    }
    
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        self.tapBoard(sender)
    }
    //MARK:--点击棋盘， 下棋
    func tapBoard(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: sender.view)
        let colF = (point.x - kBoardEdge) / kGridWidth
        let rowF = (point.y - kBoardEdge) / kGridWidth
        
        let col = Int(colF + 0.5)
        let row = Int(rowF + 0.5)
        let key = "\(col)-\(row)"
        
        if !stoneSteps.keys.contains(key) {
            let stoneView = self.makeAStoneView()
            stoneView.center = CGPoint(x: kBoardEdge + CGFloat(col) * kGridWidth, y: kBoardEdge + CGFloat(row) * kGridWidth)
            self.addSubview(stoneView)
            self.stoneSteps[key] = stoneView
            self.steps.append(key)
            
            //检查游戏结果
            self.checkResult(col: col, row: row, isBlackColor: isBlack)
        }
    }
    
    
    func checkResult(col: Int, row: Int, isBlackColor: Bool) {
//        if sameStoneArray.count >= 5 {
//            return true
//        }
        var count = 1
        //横向
        for i in 1...4 {
            let key = "\(col + i)-\(row)"
            if !stoneSteps.keys.contains(key) {
                break
            } else if stoneSteps[key]?.backgroundColor == (self.isBlack ? UIColor.black : UIColor.white) {
                break
            }
            count += 1
        }
        for i in 1...4 {
            let key = "\(col - i)-\(row)"
            if !stoneSteps.keys.contains(key) {
                break
            } else if stoneSteps[key]?.backgroundColor == (self.isBlack ? UIColor.black : UIColor.white) {
                break
            }
            count += 1
        }
        if count >= 5 {
            print("赢了")
            self.isOver = true
            self.isUserInteractionEnabled = false
            return
        }
        
        count = 1
        //纵向
        for i in 1...4 {
            let key = "\(col)-\(row + i)"
            if !stoneSteps.keys.contains(key) {
                break
            } else if stoneSteps[key]?.backgroundColor == (self.isBlack ? UIColor.black : UIColor.white) {
                break
            }
            count += 1
        }
        for i in 1...4 {
            let key = "\(col)-\(row - i)"
            if !stoneSteps.keys.contains(key) {
                break
            } else if stoneSteps[key]?.backgroundColor == (self.isBlack ? UIColor.black : UIColor.white) {
                break
            }
            count += 1
        }
        if count >= 5 {
            print("赢了")
            self.isOver = true
            self.isUserInteractionEnabled = false
            return
        }
        
        
        count = 1
        //升向
        for i in 1...4 {
            let key = "\(col + i)-\(row + i)"
            if !stoneSteps.keys.contains(key) {
                break
            } else if stoneSteps[key]?.backgroundColor == (self.isBlack ? UIColor.black : UIColor.white) {
                break
            }
            count += 1
        }
        for i in 1...4 {
            let key = "\(col - i)-\(row - i)"
            if !stoneSteps.keys.contains(key) {
                break
            } else if stoneSteps[key]?.backgroundColor == (self.isBlack ? UIColor.black : UIColor.white) {
                break
            }
            count += 1
        }
        if count >= 5 {
            print("赢了")
            self.isOver = true
            self.isUserInteractionEnabled = false
            return
        }
        
        
        count = 1
        //降向
        for i in 1...4 {
            let key = "\(col + i)-\(row - i)"
            if !stoneSteps.keys.contains(key) {
                break
            } else if stoneSteps[key]?.backgroundColor == (self.isBlack ? UIColor.black : UIColor.white) {
                break
            }
            count += 1
        }
        for i in 1...4 {
            let key = "\(col - i)-\(row + i)"
            if !stoneSteps.keys.contains(key) {
                break
            } else if stoneSteps[key]?.backgroundColor == (self.isBlack ? UIColor.black : UIColor.white) {
                break
            }
            count += 1
        }
        if count >= 5 {
            print("赢了")
            self.isOver = true
            self.isUserInteractionEnabled = false
            return
        }
        
        
        
    }
    
    func newGame() {
        self.isOver = false
        self.stoneSteps = [:]
        self.isUserInteractionEnabled = true
        for view in self.subviews {
            if view.isKind(of: UIImageView.self) {
                continue
            }
            view.removeFromSuperview()
        }
        
    }
    
    func makeAStoneView() -> UIView {
        let stone = UIView(frame: CGRect(x: 0, y: 0, width: kGridWidth * kStoneGridRatio, height: kGridWidth * kStoneGridRatio))
        stone.layer.cornerRadius = kGridWidth * kStoneGridRatio * 0.5
        stone.backgroundColor = self.isBlack ? UIColor.black : UIColor.white
        stone.layer.borderWidth = 1
        stone.layer.borderColor = UIColor.gray.cgColor
        return stone
    }
    
    
    func backStep() {
        if steps.count > 0 {
            let key = steps.removeLast()
            stoneSteps[key]?.removeFromSuperview()
            stoneSteps[key] = nil
        }
        
        
    }
    
    

    override func draw(_ rect: CGRect) {
        self.drawBoard(size: rect.size)
    }
    


}
