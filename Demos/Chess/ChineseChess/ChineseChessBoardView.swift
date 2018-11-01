//
//  ChineseChessBoardView.swift
//  Demos
//
//  Created by 焦国辉 on 2018/11/1.
//  Copyright © 2018 zyxx. All rights reserved.
//

import UIKit

//象棋
fileprivate let kBoardImageRate = (kScreenWidth - 2 * kEdgeScreen) / 558
fileprivate let kBoardEdgeWidth = 48.0 * kBoardImageRate
fileprivate let kBoardEdgeHeight = 52.0 * kBoardImageRate
fileprivate let kGridWidth = kBoardImageRate * 462 / 8
fileprivate let kStoneR = kGridWidth / 2 - 4

typealias Point = (x:Int, y:Int)

enum Type {
    case ju, ma, xiang, shi, jiang, pao, bing
}
enum Color {
    case red, black
}



class ChineseChessStone: UIImageView {
    
    var type: Type = .bing
    var color: Color = .black
    var point: Point = (-1, -1) {
        willSet {
            center = CGPoint(x: kBoardEdgeWidth + CGFloat(newValue.y) * kGridWidth, y: kBoardEdgeHeight + CGFloat(newValue.x) * kGridWidth)
            //            frame.origin = CGPoint(x: kBoardEdgeWidth + CGFloat(newValue.x) * kGridWidth - kStoneR, y: kBoardEdgeHeight + CGFloat(newValue.y) * kGridWidth - kStoneR)
        }
    }
    
    var isLiving = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


enum ChessError: Error {
    case notStartError, selectedStoneError, moveStoneError, otherError
}


class ChineseChessBoardView: UIImageView {

    let rJu = UIImage(named: "红车.gif")!
    let bJu = UIImage(named: "黑车.gif")!
    let rMa = UIImage(named: "红马.gif")!
    let bMa = UIImage(named: "黑马.gif")!
    let rXiang = UIImage(named: "红象.gif")!
    let bXiang = UIImage(named: "黑象.gif")!
    let rShi = UIImage(named: "红士.gif")!
    let bShi = UIImage(named: "黑士.gif")!
    let rShuai = UIImage(named: "红帅.gif")!
    let bJiang = UIImage(named: "黑将.gif")!
    let rBing = UIImage(named: "红兵.gif")!
    let bZu = UIImage(named: "黑卒.gif")!
    let rPao = UIImage(named: "红炮.gif")!
    let bPao = UIImage(named: "黒炮.gif")!
    
    enum State {
        case noRunning, redC, redT, blackC, blackT, gameover
    }
    
    var state: State = .noRunning
    var stones:[ChineseChessStone] = []
    var selectedStone: ChineseChessStone? = nil
    var steps: [(stoneA:ChineseChessStone, stoneA:ChineseChessStone?)] = []
    
    
    //再开一局
    func againGame() {
        self.stones = []
        for i in 0 ... 31 {
            let stone = ChineseChessStone(frame: CGRect(x: -1, y: -1, width: 2 * kStoneR, height: 2 * kStoneR))
            if i < 16 {
                stone.color = .red
                
            }else {
                stone.color = .black
            }
            switch i {
            case 0, 8, 16, 24:
                stone.type = .ju
                if i > 15 {
                    stone.image = rJu
                }else {
                    stone.image = bJu
                }
            case 1, 7, 17, 23:
                stone.type = .ma
                if i > 15 {
                    stone.image = rMa
                }else {
                    stone.image = bMa
                }
            case 2, 6, 18, 22:
                stone.type = .xiang
                if i > 15 {
                    stone.image = rXiang
                }else {
                    stone.image = bXiang
                }
            case 3, 5, 19, 21:
                stone.type = .shi
                if i > 15 {
                    stone.image = rShi
                }else {
                    stone.image = bShi
                }
            case 4, 20:
                stone.type = .jiang
                if i > 15 {
                    stone.image = rShuai
                }else {
                    stone.image = bJiang
                }
            case 9, 10, 25, 26:
                stone.type = .pao
                if i > 15 {
                    stone.image = rPao
                }else {
                    stone.image = bPao
                }
            default:
                stone.type = .bing
                if i > 15 {
                    stone.image = rBing
                }else {
                    stone.image = bZu
                }
            }
            self.addSubview(stone)
            self.stones.append(stone)
        }

        for row in 0 ... 9 {
            for col in 0 ... 8 {
                switch (row, col) {
                case (0, _):
                    stones[col].point = (0, col)
                case (2,1):
                    stones[9].point = (2, 1)
                case (2,7):
                    stones[10].point = (2,7)
                case (3, _):
                    if col % 2 == 0 {
                        stones[11 + col / 2].point = (3, col)
                    }
                case (9, _):
                    stones[col + 16].point = (9, col)
                    
                case (7,1):
                    stones[25].point = (7, 1)
                case (7,7):
                    stones[26].point = (7, 7)
                case (6,_):
                    if col % 2 == 0 {
                        stones[27 + col / 2].point = (6, col)
                    }
                default:
                    continue
                }
            }
        }
        
        
        self.state = .noRunning
        
    }
    
    func play() {
        self.state = .redC
    }
    
    
    
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: sender.view)
        let colF = (location.x - kBoardEdgeWidth) / kGridWidth
        let rowF = (location.y - kBoardEdgeHeight) / kGridWidth
        
        let col = Int(colF + 0.5)
        let row = Int(rowF + 0.5)
        let point = Point(col, row)
        let key = "\(col)-\(row)"
        
        switch self.state {
        case .noRunning:
            print("请开始")
        case .redC:
            if let stone = self.getStone(in: point) {
                if stone.color == .red {
                    self.selectedStone = stone
                    self.state = .redT
                }
            }
        case .redT:
            if self.canMove(stone: self.selectedStone!, to: point) {
                self.selectedStone!.point = point
                self.state = .blackC
            } else {
                self.state = .redC
            }
        case .blackC:
            if let stone = self.getStone(in: point) {
                if stone.color == .black {
                    self.selectedStone = stone
                    self.state = .blackT
                }
            }
        
        case .blackT:
            if self.canMove(stone: self.selectedStone!, to: point) {
                self.selectedStone!.point = point
                self.state = .redC
            } else {
                self.state = .blackC
            }
        case .gameover:
            print("ok")
        }
        
        print("state: \(self.state)")
        
    }
    

    
    
    //行走规则
    func canMove(stone:ChineseChessStone, to newPoint: Point) -> Bool {
        let point = stone.point
        if point == newPoint {
            return false
        }
        let xx = abs(point.x - newPoint.x)
        let xMin = min(point.x, newPoint.x)
        let yy = abs(point.y - newPoint.y)
        let yMin = min(point.y, newPoint.y)
        
        switch (stone.type) {
            
        case .ju:
            if point.x == newPoint.x {
                for i in 0 ..< yy {
                    if ishaveStone(in: Point(newPoint.x, yMin + i)) {
                        return false
                    }
                }
            } else if point.y == newPoint.y {
                for i in 1 ..< xx {
                    if ishaveStone(in: Point(xMin + i, newPoint.y)) {
                        return false
                    }
                }
            }
            return true
            
        case .ma:
            
            return true
            
        case .xiang:
            
            return true
            
        case .shi:
            
            return true
            
        case .jiang:
            
            return true
            
        case .pao:
            
            return true
            
        case .bing:
            
            return true
            
        }
    }
    
    
    //某位置是否有棋子
    func ishaveStone(in point: Point) -> Bool {
        for stone in stones {
            if stone.isLiving && stone.point == point {
                return true
            }
        }
        return false
    }
    
    //获取某位置的棋子
    func getStone(in point: Point) -> ChineseChessStone? {
        for stone in stones {
            if stone.isLiving && stone.point == point {
                return stone
            }
        }
        return nil
    }
    
    //悔棋
    func backStep() {
        
    }
    
}

