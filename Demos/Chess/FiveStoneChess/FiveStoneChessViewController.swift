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
    
    var viewModel = FiveStoneChessViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //画棋盘
        drawBoard(size: boardView.bounds.size)
        //设置棋盘的触摸方法
        setBoardView()
        //初始化模型
        //设置tip监听
        self.boardView.backgroundColor = UIColor.orange

    }
    
    @IBAction func newGameAction(_ sender: UIButton) {
        newGame()
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        
        self.viewModel.saveModel(withKey: "BBB")
    }
    
    @IBAction func backStepAction(_ sender: UIButton) {
        backStep()
    }
    
    func tagForStone(index: Int) -> Int {
        return index + 10000
    }
    
    func newGame() {
        for index in 0 ..< self.viewModel.stepCounts {
            self.boardView.viewWithTag(tagForStone(index: index))?.removeFromSuperview()
        }
        self.viewModel.initModel()
        self.boardView.isUserInteractionEnabled = true
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
        
        if !self.viewModel.modelStepsContains(key:key) {
            let stoneView = self.makeAStoneView()
            stoneView.tag = tagForStone(index: self.viewModel.stepCounts)
            stoneView.center = CGPoint(x: kBoardEdge + CGFloat(col) * kGridWidth, y: kBoardEdge + CGFloat(row) * kGridWidth)
            self.boardView.addSubview(stoneView)
            self.viewModel.modelStepsAppend(key)
            
            //检查游戏结果
            let isFive = self.viewModel.isFive(col: col, row: row)
            if isFive {
                self.boardView.isUserInteractionEnabled = false
            }
        }
    }
    
    
    func makeAStoneView() -> UIView {
        let stone = UIView(frame: CGRect(x: 0, y: 0, width: kGridWidth * kStoneGridRatio, height: kGridWidth * kStoneGridRatio))
        stone.layer.cornerRadius = kGridWidth * kStoneGridRatio * 0.5
        stone.backgroundColor = self.viewModel.model.isBlack ? UIColor.black : UIColor.white
        stone.layer.borderWidth = 1
        stone.layer.borderColor = UIColor.gray.cgColor
        return stone
    }
    
    
    func backStep() {
        if self.viewModel.stepCounts > 0 {
            //删除棋子UIView
            self.boardView.viewWithTag(tagForStone(index: self.viewModel.stepCounts - 1))?.removeFromSuperview()
            //删除模型的数据
            self.viewModel.backStep()
        }
    }

}
