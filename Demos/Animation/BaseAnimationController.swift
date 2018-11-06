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
private let kStartPointX:CGFloat = 20
private let kStartPointY:CGFloat = 200

class BaseAnimationController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func delSubviews() {
        for v in self.view.subviews {
            if !v.isKind(of: UIButton.self) {
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
        moveAnim.fromValue = NSValue(cgPoint: CGPoint(x: kStartPointX, y: kStartPointY))
        moveAnim.toValue = NSValue(cgPoint: CGPoint(x: kScreenWidth - 2 * kStartPointX - kWidth, y: kStartPointY))
        moveAnim.duration = 2
        moveAnim.repeatCount = Float.infinity
        moveAnim.autoreverses = true
        moveView.layer.add(moveAnim, forKey: "moveAnim")
    }
    
  
    @IBAction func rorationAction(_ sender: UIButton) {
    }
    
    @IBAction func scaleAction(_ sender: UIButton) {
    }
    
    @IBAction func backgroundColorAction(_ sender: UIButton) {
    }
    
    @IBAction func contentAction(_ sender: UIButton) {
    }
    
    @IBAction func alphaAction(_ sender: UIButton) {
    }
    
    @IBAction func cornerAction(_ sender: UIButton) {
    }
    
    @IBAction func bounds(_ sender: UIButton) {
    }
    
    
    
    
}
