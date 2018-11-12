//
//  KeyFrameAnimationViewController.swift
//  Demos
//
//  Created by 焦国辉 on 2018/11/7.
//  Copyright © 2018 zyxx. All rights reserved.
//

import UIKit

private var kWidth: CGFloat = 250
private var kHeight: CGFloat = 400
private var kBallD: CGFloat = 100



class OtherAnimationViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func delSubviews() {
        
        for v in self.view.subviews {
            if !v.isKind(of: UIStackView.self) {
                v.removeFromSuperview()
            }
        }
        for l in self.view.layer.sublayers! {
            if l.isKind(of: CAShapeLayer.self) {
                l.removeFromSuperlayer()
            }
        }
    }
    
    @IBAction func SpringAnimationAction(_ sender: UIButton) {
        delSubviews()
        
        let jellyView = UIView(frame: CGRect(x: (kScreenWidth - kBallD)/2, y: 100, width: kBallD, height: kBallD))
        jellyView.backgroundColor = UIColor.red
        jellyView.layer.cornerRadius = kBallD / 2
        jellyView.layer.masksToBounds = true
        self.view.addSubview(jellyView)
        let point2 = CGPoint(x: kScreenWidth/2, y: 300)
        let point1 = jellyView.layer.position
        print(point1, point2)
        // 不同的keypath，不同的效果
        let springAnimation = CASpringAnimation(keyPath: "position")
        
        
        springAnimation.fromValue = NSValue.init(cgPoint: point1 )
        springAnimation.toValue = NSValue.init(cgPoint: point2)
        
        //质量，弹性，阻尼，初速度
        springAnimation.mass = 5
        springAnimation.stiffness = 100
        springAnimation.damping = 10
        springAnimation.initialVelocity = 10
        springAnimation.duration = springAnimation.settlingDuration
        
//        springAnimation.isRemovedOnCompletion = false
        
        jellyView.layer.add(springAnimation, forKey: "springAnimation")
    }
    
    
    @IBAction func drowLineAction(_ sender: UIButton) {
        delSubviews()
        
        let tempView = UIView(frame: CGRect(x: (kScreenWidth - kWidth) / 2, y: 100, width: kWidth, height: kHeight))
        let bezierPath = UIBezierPath(ovalIn: tempView.frame)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.purple.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.path = bezierPath.cgPath
        view.layer.addSublayer(shapeLayer)
        
        let pathAnim = CABasicAnimation(keyPath: "strokeEnd")
        pathAnim.duration = 5.0
        pathAnim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        pathAnim.fromValue = 0
        pathAnim.toValue = 1
        pathAnim.autoreverses = true
        pathAnim.fillMode = CAMediaTimingFillMode.forwards
        //        pathAnim.isRemovedOnCompletion = false
        pathAnim.repeatCount = Float.infinity
        shapeLayer.add(pathAnim, forKey: "strokeEndAnim")
    }
    
}
