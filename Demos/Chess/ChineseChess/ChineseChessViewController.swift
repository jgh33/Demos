//
//  ChineseChessViewController.swift
//  Demos
//
//  Created by 焦国辉 on 2018/10/25.
//  Copyright © 2018 zyxx. All rights reserved.
//

import UIKit


func alertMe(_ controller:UIViewController, title:String, message:String? = nil) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let ok = UIAlertAction(title: "好的", style: .default, handler: nil)
    alert.addAction(ok)
    controller.present(alert, animated: true, completion: nil)
}



class ChineseChessViewController: UIViewController {
    
    @IBOutlet weak var boardImageView: ChineseChessBoardView!

    let boardImage = UIImage(named: "棋盘.gif")!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.boardImageView.image = boardImage
        self.boardImageView.isUserInteractionEnabled = true
        self.boardImageView.againGame()
        
        
    }
    
    @IBAction func playGameAction(_ sender: UIButton) {
        self.boardImageView.play()
    }

    

}

