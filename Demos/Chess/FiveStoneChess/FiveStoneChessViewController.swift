//
//  FiveStoneChessViewController.swift
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

class FiveStoneChessViewController: UIViewController {

    @IBOutlet weak var boardView: UIView!
    @IBOutlet weak var tipsLabel: UILabel!
    
    var model = FiveStoneChessModel()
    var stoneSteps: [String: UIView] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //画棋盘
        drawBoard(size: boardView.bounds.size)
        //设置棋盘的触摸方法
        setBoardView()
        
        //初始化模型
        newGame()
        //设置tip监听
        
        self.boardView.backgroundColor = UIColor.orange

    }
    
    @IBAction func newGameAction(_ sender: UIButton) {
        newGame()
    }
    
    @IBAction func startAction(_ sender: UIButton) {
        
    }
    
    @IBAction func backStepAction(_ sender: UIButton) {
        backStep()
    }
    
    
    func newGame() {
        self.model.steps = []
        self.model.isOver = false
        self.boardView.isUserInteractionEnabled = true
        
        for view in self.stoneSteps.values {
            view.removeFromSuperview()
        }
        self.stoneSteps = [:]
        
        
    }
    
    func setBoardView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        self.boardView.addGestureRecognizer(tap)
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
        self.boardView.addSubview(UIImageView(image: image!))
        UIGraphicsEndImageContext()
    }
    
    
    @objc func tapAction(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: sender.view)
        let colF = (point.x - kBoardEdge) / kGridWidth
        let rowF = (point.y - kBoardEdge) / kGridWidth
        
        let col = Int(colF + 0.5)
        let row = Int(rowF + 0.5)
        let key = "\(col)-\(row)"
        if col < 0 || col > 14 || row < 0 || row > 14 {
            return
        }
        
        if !self.model.steps.contains(key) {
            let stoneView = self.makeAStoneView()
            stoneView.center = CGPoint(x: kBoardEdge + CGFloat(col) * kGridWidth, y: kBoardEdge + CGFloat(row) * kGridWidth)
            self.boardView.addSubview(stoneView)
            self.model.steps.append(key)
            self.stoneSteps[key] = stoneView
            
            //检查游戏结果
            self.checkResult(col: col, row: row, isBlackColor: self.model.isBlack)
        }
    }
    
    
    func makeAStoneView() -> UIView {
        let stone = UIView(frame: CGRect(x: 0, y: 0, width: kGridWidth * kStoneGridRatio, height: kGridWidth * kStoneGridRatio))
        stone.layer.cornerRadius = kGridWidth * kStoneGridRatio * 0.5
        stone.backgroundColor = self.model.isBlack ? UIColor.black : UIColor.white
        stone.layer.borderWidth = 1
        stone.layer.borderColor = UIColor.gray.cgColor
        return stone
    }
    
    
    func backStep() {
        if self.model.steps.count > 0 {
            //删除棋子UIView
            self.boardView.viewWithTag(self.model.steps.count)?.removeFromSuperview()
            //删除模型的数据
            self.model.steps.removeLast()
            
        }
    }
    
    func checkResult(col: Int, row: Int, isBlackColor: Bool) {
        var count = 1
        //横向
        for i in 1...4 {
            let key = "\(col + i)-\(row)"
            if !self.model.steps.contains(key) {
                break
            } else if self.stoneSteps[key]?.backgroundColor == (self.model.isBlack ? UIColor.black : UIColor.white) {
                break
            }
            count += 1
        }
        for i in 1...4 {
            let key = "\(col - i)-\(row)"
            if !stoneSteps.keys.contains(key) {
                break
            } else if self.stoneSteps[key]?.backgroundColor == (self.model.isBlack ? UIColor.black : UIColor.white) {
                break
            }
            count += 1
        }
        if count >= 5 {
            print("赢了")
            self.model.isOver = true
            self.boardView.isUserInteractionEnabled = false
            return
        }
        
        count = 1
        //纵向
        for i in 1...4 {
            let key = "\(col)-\(row + i)"
            if !stoneSteps.keys.contains(key) {
                break
            } else if self.stoneSteps[key]?.backgroundColor == (self.model.isBlack ? UIColor.black : UIColor.white) {
                break
            }
            count += 1
        }
        for i in 1...4 {
            let key = "\(col)-\(row - i)"
            if !stoneSteps.keys.contains(key) {
                break
            } else if self.stoneSteps[key]?.backgroundColor == (self.model.isBlack ? UIColor.black : UIColor.white) {
                break
            }
            count += 1
        }
        if count >= 5 {
            print("赢了")
            self.model.isOver = true
            self.boardView.isUserInteractionEnabled = false
            return
        }
        
        
        count = 1
        //升向
        for i in 1...4 {
            let key = "\(col + i)-\(row + i)"
            if !stoneSteps.keys.contains(key) {
                break
            } else if self.stoneSteps[key]?.backgroundColor == (self.model.isBlack ? UIColor.black : UIColor.white) {
                break
            }
            count += 1
        }
        for i in 1...4 {
            let key = "\(col - i)-\(row - i)"
            if !stoneSteps.keys.contains(key) {
                break
            } else if self.stoneSteps[key]?.backgroundColor == (self.model.isBlack ? UIColor.black : UIColor.white) {
                break
            }
            count += 1
        }
        if count >= 5 {
            print("赢了")
            self.model.isOver = true
            self.boardView.isUserInteractionEnabled = false
            return
        }
        
        
        count = 1
        //降向
        for i in 1...4 {
            let key = "\(col + i)-\(row - i)"
            if !stoneSteps.keys.contains(key) {
                break
            } else if self.stoneSteps[key]?.backgroundColor == (self.model.isBlack ? UIColor.black : UIColor.white) {
                break
            }
            count += 1
        }
        for i in 1...4 {
            let key = "\(col - i)-\(row + i)"
            if !stoneSteps.keys.contains(key) {
                break
            } else if self.stoneSteps[key]?.backgroundColor == (self.model.isBlack ? UIColor.black : UIColor.white) {
                break
            }
            count += 1
        }
        if count >= 5 {
            print("赢了")
            self.model.isOver = true
            self.boardView.isUserInteractionEnabled = false
            return
        }
        
        
        
    }

}
