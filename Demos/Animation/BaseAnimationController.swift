//
//  BaseAnimationController.swift
//  Demos
//
//  Created by 焦国辉 on 2018/11/6.
//  Copyright © 2018 zyxx. All rights reserved.
//

import UIKit

private let kWidth:CGFloat = 70
private let kHeight:CGFloat = 70
private let kStartPointX:CGFloat = 40
private let kStartPointY:CGFloat = 200

class BaseAnimationController: UIViewController {

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
    }
    

    @IBAction func positionAction(_ sender: UIButton) {
        delSubviews()
        
        let moveView = UIView(frame: CGRect(x: kStartPointX, y: kStartPointY, width: kWidth, height: kHeight))
        moveView.backgroundColor = UIColor.red
        view.addSubview(moveView)
        
        let moveAnim = CABasicAnimation(keyPath: "position")
        let startPoint = CGPoint(x: kStartPointX + kWidth / 2, y: kStartPointY)
        let endPoint = CGPoint(x: kScreenWidth - kStartPointX - kWidth / 2, y: kStartPointY)
        moveAnim.fromValue = NSValue(cgPoint: startPoint)
        moveAnim.toValue = NSValue(cgPoint: endPoint)
        moveAnim.duration = 2
        moveAnim.repeatCount = Float.infinity
        moveAnim.autoreverses = true
        moveView.layer.add(moveAnim, forKey: "moveAnim")
    }
    
  
    @IBAction func rorationAction(_ sender: UIButton) {
        self.delSubviews()
        
        let rorationViewX = UIView(frame: CGRect(x: kStartPointX, y: kStartPointY, width: kWidth, height: kHeight))
        rorationViewX.backgroundColor = UIColor.red
        view.addSubview(rorationViewX)
        let rotationAnimX = CABasicAnimation(keyPath: "transform.rotation.x")
//        rotationAnimX.beginTime = 0.0
        rotationAnimX.toValue = 2 * Double.pi
        rotationAnimX.duration = 1.5
        rotationAnimX.repeatCount = Float.infinity
        rorationViewX.layer.add(rotationAnimX, forKey: "rotationAnimX")
        
        let rorationViewY = UIView(frame: CGRect(x: (kScreenWidth - kWidth) / 2, y: kStartPointY, width: kWidth, height: kHeight))
        rorationViewY.backgroundColor = UIColor.red
        view.addSubview(rorationViewY)
        let rotationAnimY = CABasicAnimation(keyPath: "transform.rotation.y")
//        rotationAnimY.beginTime = 0.0
        rotationAnimY.toValue = 2 * Double.pi
        rotationAnimY.duration = 1.5
        rotationAnimY.repeatCount = Float.infinity
        rorationViewY.layer.add(rotationAnimY, forKey: "rotationAnimY")
        
        let rorationViewZ = UIView(frame: CGRect(x: kScreenWidth - kWidth - kStartPointX, y: kStartPointY, width: kWidth, height: kHeight))
        rorationViewZ.backgroundColor = UIColor.red
        view.addSubview(rorationViewZ)
        let rotationAnimZ = CABasicAnimation(keyPath: "transform.rotation.z")
//        rotationAnimZ.beginTime = 0.0
        rotationAnimZ.toValue = 2 * Double.pi
        rotationAnimZ.duration = 1.5
        rotationAnimZ.repeatCount = Float.infinity
        rorationViewZ.layer.add(rotationAnimZ, forKey: "rotationAnimZ")
    }
    
    @IBAction func scaleAction(_ sender: UIButton) {
        self.delSubviews()
        
        /**------------------------比例缩放动画-------------------------------------*/
        let scaleView = UIView(frame: CGRect(x: kStartPointX, y: kStartPointY, width: kWidth, height: kHeight))
        scaleView.backgroundColor = UIColor.red
        view.addSubview(scaleView)
        let scaleAnim = CABasicAnimation(keyPath: "transform.scale")
        scaleAnim.fromValue = 0.3
        scaleAnim.toValue = 1.3
        scaleAnim.duration = 2
        scaleAnim.autoreverses = true
        scaleAnim.repeatCount = Float.infinity
        scaleView.layer.add(scaleAnim, forKey: "scaleAnim")
        
        /**------------------------比例缩放动画X-------------------------------------*/
        let scaleViewX = UIView(frame: CGRect(x: (kScreenWidth - kWidth) / 2, y: kStartPointY, width: kWidth, height: kHeight))
        scaleViewX.backgroundColor = UIColor.red
        view.addSubview(scaleViewX)
        let scaleAnimX = CABasicAnimation(keyPath: "transform.scale.x")
        scaleAnimX.fromValue = 0.3
        scaleAnimX.toValue = 1.3
        scaleAnimX.duration = 2
        scaleAnimX.autoreverses = true
        scaleAnimX.repeatCount = Float.infinity
        scaleViewX.layer.add(scaleAnimX, forKey: "scaleAnimX")
        
        /**------------------------比例缩放动画Y-------------------------------------*/
        let scaleViewY = UIView(frame: CGRect(x: kScreenWidth - kWidth - kStartPointX, y: kStartPointY, width: kWidth, height: kHeight))
        scaleViewY.backgroundColor = UIColor.red
        view.addSubview(scaleViewY)
        let scaleAnimY = CABasicAnimation(keyPath: "transform.scale.y")
        scaleAnimY.fromValue = 0.3
        scaleAnimY.toValue = 1.3
        scaleAnimY.duration = 2
        scaleAnimY.autoreverses = true
        scaleAnimY.repeatCount = Float.infinity
        scaleViewY.layer.add(scaleAnimY, forKey: "scaleAnimY")
        
    }
    
    @IBAction func backgroundColorAction(_ sender: UIButton) {
        self.delSubviews()
        
        /**------------------------背景颜色变化动画-------------------------------------*/
        let colorView = UIView(frame: CGRect(x: (kScreenWidth - kWidth) / 2, y: kStartPointY, width: kWidth, height: kHeight))
        colorView.backgroundColor = UIColor.red
        view.addSubview(colorView)
        let colorAnim = CABasicAnimation(keyPath: "backgroundColor")
        colorAnim.fromValue = UIColor.red.cgColor
        colorAnim.toValue = UIColor.green.cgColor
        colorAnim.autoreverses = true
        colorAnim.repeatCount = Float.infinity
        colorAnim.duration = 2
        colorView.layer.add(colorAnim, forKey: "colorAnim")
    }
    
    @IBAction func contentAction(_ sender: UIButton) {
        self.delSubviews()
        
        /**------------------------内容变化动画-------------------------------------*/
        let imageView = UIImageView(frame: CGRect(x: (kScreenWidth - kWidth) / 2, y: kStartPointY, width: kWidth, height: kHeight))
        imageView.image = UIImage(named: "黑将.gif")
        view.addSubview(imageView)
        let contentsAnim = CABasicAnimation(keyPath: "contents")
        contentsAnim.toValue = UIImage(named: "红帅.gif")?.cgImage
        contentsAnim.duration = 1.5
        contentsAnim.autoreverses = true
        contentsAnim.repeatCount = Float.infinity
        imageView.layer.add(contentsAnim, forKey: "contentsAnim")
    }
    
    @IBAction func alphaAction(_ sender: UIButton) {
        self.delSubviews()
        
        /**------------------------透明动画-------------------------------------*/
        let alphaView = UIView(frame: CGRect(x: (kScreenWidth - kWidth) / 2, y: kStartPointY, width: kWidth, height: kHeight))
        alphaView.backgroundColor = UIColor.red
        view.addSubview(alphaView)
        let alphaAnim = CABasicAnimation(keyPath: "opacity")
        alphaAnim.fromValue = 0.3
        alphaAnim.toValue = 1
        alphaAnim.duration = 2
        alphaAnim.autoreverses = true
        alphaAnim.repeatCount = Float.infinity
        alphaView.layer.add(alphaAnim, forKey: "alphaAnim")
    }
    
    @IBAction func cornerAction(_ sender: UIButton) {
        self.delSubviews()
        /**------------------------圆角变化动画-------------------------------------*/
        let cornerRadiusView = UIView(frame: CGRect(x: (kScreenWidth - kWidth) / 2, y: kStartPointY, width: kWidth, height: kHeight))
        cornerRadiusView.backgroundColor = UIColor.red
        view.addSubview(cornerRadiusView)
        cornerRadiusView.layer.masksToBounds = true
        let cornerRadiusAnim = CABasicAnimation(keyPath: "cornerRadius")
        cornerRadiusAnim.toValue = 35
        cornerRadiusAnim.duration = 2
        cornerRadiusAnim.autoreverses = true
        cornerRadiusAnim.repeatCount = Float.infinity
        cornerRadiusView.layer.add(cornerRadiusAnim, forKey: "cornerRadiusAnim")
    }
    
    @IBAction func bounds(_ sender: UIButton) {
        self.delSubviews()
        
        /**------------------------指定大小缩放-------------------------------------*/
        let boundsView = UIView(frame: CGRect(x: (kScreenWidth - kWidth + 50) / 2, y: kStartPointY, width: kWidth - 50, height: kHeight + 50))
        boundsView.backgroundColor = UIColor.red
        view.addSubview(boundsView)
        let boundsAnim = CABasicAnimation(keyPath: "bounds")
        boundsAnim.toValue = NSValue(cgRect: CGRect(x: (kScreenWidth - kWidth - 50) / 2, y: kStartPointY, width: kWidth + 50, height: kHeight - 50))
        boundsAnim.duration = 2
        boundsAnim.autoreverses = true
        boundsAnim.repeatCount = Float.infinity
        boundsView.layer.add(boundsAnim, forKey: "boundsAnim")
    }
    
    
    
    
}
