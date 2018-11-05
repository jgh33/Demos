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
            center = CGPoint(x: kBoardEdgeWidth + CGFloat(newValue.x) * kGridWidth, y: kBoardEdgeHeight + CGFloat(newValue.y) * kGridWidth)
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
            if i >= 16 {
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

        for x in 0 ... 8 {
            for y in 0 ... 9 {
                switch (x, y) {
                case (_, 0):
                    stones[x].point = (x, y)
                case (1,2):
                    stones[9].point = (x, y)
                case (7,2):
                    stones[10].point = (x, y)
                case (_, 3):
                    if x % 2 == 0 {
                        stones[11 + x / 2].point = (x, y)
                    }
                case (_, 9):
                    stones[x + 16].point = (x, y)
                    
                case (1,7):
                    stones[25].point = (x, y)
                case (7,7):
                    stones[26].point = (x, y)
                case (_,6):
                    if x % 2 == 0 {
                        stones[27 + x / 2].point = (x, y)
                    }
                default:
                    continue
                }
            }
        }
        
        for stone in stones {
            print("\(stone.point)-\(stone.color)-\(stone.type)")
        }
        
        
        self.state = .noRunning
        
        
    }
    
    func play() {
        self.isUserInteractionEnabled = true
        self.state = .redC
        print(self.state)
    }
    
    
    
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: sender.view)
        let xF = (location.x - kBoardEdgeWidth) / kGridWidth
        let yF = (location.y - kBoardEdgeHeight) / kGridWidth
        
        let x = Int(xF + 0.5)
        let y = Int(yF + 0.5)
        if x > 8 || x < 0 || y < 0 || y > 9 {
            return
        }
        let point = Point(x, y)
        let key = "\(x)-\(y)"
        print(key)
        
        switch self.state {
        case .noRunning:
            print("请开始")
        case .redC:
            if let stone = self.getStone(in: point) {
                if stone.color == .red {
                    self.selectedStone = stone
                    self.selectedStone?.alpha = 0.6
                    self.state = .redT
                } else {
                    print("不能那么选择")
                }
                
            }
        case .redT:
            if self.canMove(stone: self.selectedStone!, to: point) {
                self.dieStone(at: point)
                self.selectedStone!.point = point
                self.state = .blackC
            } else {
                self.state = .redC
                print("不能那么走")
            }
            self.selectedStone?.alpha = 1
        case .blackC:
            if let stone = self.getStone(in: point) {
                if stone.color == .black {
                    self.selectedStone = stone
                    self.selectedStone?.alpha = 0.6
                    self.state = .blackT
                } else {
                    print("不能那么选择")
                }
                
            }
        
        case .blackT:
            if self.canMove(stone: self.selectedStone!, to: point) {
                self.dieStone(at: point)
                self.selectedStone!.point = point
                self.state = .redC
            } else {
                self.state = .blackC
                print("不能那么走")
            }
            self.selectedStone?.alpha = 1
        case .gameover:
            print("ok")
        }
        
        print("state: \(self.state)")
        
    }
    

    
    
    //行走规则
    func canMove(stone:ChineseChessStone, to newPoint: Point) -> Bool {
        let point = stone.point

        //不能吃自己的子
        if let s = self.getStone(in: newPoint){
            if s.color == stone.color {
                return false
            }
        }
        
        let xx = abs(point.x - newPoint.x)
//        let xMin = min(point.x, newPoint.x)
        let yy = abs(point.y - newPoint.y)
//        let yMin = min(point.y, newPoint.y)
        
        switch (stone.type) {
            
        case .ju:
            let inRule = (point.x == newPoint.x) || (point.y == newPoint.y)
            let noObstacle = self.noStoneInLine(between: point, pointB: newPoint)
            if inRule && noObstacle {
                return true
            }
            return false
            
        case .ma:
            let inRule = (xx == 1 && yy == 2) || (xx == 2 && yy == 1)
            var obstaclePoint = Point(0, 0)
            if yy == 2 {
                obstaclePoint = Point(point.x , (newPoint.y + point.y) / 2)
            } else {
                obstaclePoint = Point((newPoint.x + point.x) / 2 , point.y)
            }
                
            let noObstacle = !self.ishaveStone(in: obstaclePoint)
            if inRule && noObstacle {
                return true
            }
            return false
            
        case .xiang:
            let inRule = (xx == 2 && yy == 2)
            let noObstacle = !self.ishaveStone(in: Point((newPoint.x + point.x) / 2 , (newPoint.y + point.y) / 2))
            var noRiver = false
            if (stone.color == .red && newPoint.y > 4) || (stone.color == .black && newPoint.y < 5){
                noRiver = true
            }
            if inRule && noObstacle && noRiver {
                    return true
            }
            return false
            
        case .shi:
            let inRule = (xx == 1 && yy == 1)
            let inCityX = (newPoint.x > 2 && newPoint.x < 6)
            let inCityY = (newPoint.y < 3 || newPoint.y > 7)
            if  inRule && inCityX && inCityY  {
                return true
            }
            return false
            
        case .jiang:
            let inRule = (xx + yy == 1)
            let inCityX = (newPoint.x > 2 && newPoint.x < 6)
            let inCityY = (newPoint.y < 3 || newPoint.y > 7)
            var faceJiang = false
            if let jiangStone = getStone(in: newPoint) {
                if jiangStone.type == .jiang && self.noStoneInLine(between: newPoint, pointB: point) {
                    faceJiang = true
                }
            }
            
            if  (inRule && inCityX && inCityY) || faceJiang {
                return true
            }
            return false
            
        case .pao:
            let inRule = (point.x == newPoint.x) || (point.y == newPoint.y)
            let noObstacle = self.noStoneInLine(between: point, pointB: newPoint)
            let haveOneObstacle = (self.theStonesCountInLine(between: point, pointB: newPoint) == 1)
            if inRule && (haveOneObstacle || noObstacle) {
                return true
            }
            return false
            
        case .bing:
            let oneStep = (xx + yy == 1)
            var noBack = false
            var noLeftRight = true
            if stone.color == .red {
                noBack = (newPoint.y <= point.y)
                if point.y > 4 && xx == 1 {
                    noLeftRight = false
                }
            } else {
                noBack = (newPoint.y >= point.y)
                if point.y < 5 && xx == 1 {
                    noLeftRight = false
                }
            }
           
            if oneStep && noBack && noLeftRight {
                return true
            }
            return false
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
    
    func theStonesCountInLine(between pointA: Point, pointB: Point) -> Int {
        guard (pointA.x == pointB.x) || (pointA.y == pointB.y) else {
            print("出错了！A、B不在一条线上")
            return 0
        }
        var count = 0
        if pointA.x == pointB.x {
            if abs(pointA.y - pointB.y) < 2 {
                return 0
            }
            for i in 1 ... abs(pointA.y - pointB.y) - 1 {
                let point = Point(pointA.x, min(pointA.y, pointB.y) + i)
                if self.ishaveStone(in: point) {
                    count += 1
                }
            }
        } else if pointA.y == pointB.y {
            if abs(pointA.x - pointB.x) < 2 {
                return 0
            }
            for i in 1 ... abs(pointA.x - pointB.x) - 1 {
                let point = Point(min(pointA.x, pointB.x) + i, pointA.y)
                if self.ishaveStone(in: point) {
                    count += 1
                }
            }
        }
        return count
        
    }
    
    func noStoneInLine(between pointA:Point, pointB:Point) -> Bool {
        if self.theStonesCountInLine(between: pointA, pointB: pointB) == 0 {
            return true
        }
        return false
    }
    
    func dieStone(at point: Point) {
        if let stone = self.getStone(in: point) {
            stone.isLiving = false
            stone.point = Point(-100, -100)
            print("\(stone.color)\(stone.type)被吃！")
            if stone.type == .jiang {
                gameover()
            }
        }
    }
    
    func gameover() {
        self.isUserInteractionEnabled = false
        self.state = .gameover
        print("game over!")
    }
    
    //悔棋
    func backStep() {
        
    }
    
}

