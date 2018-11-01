//
//  FiveStoneChessViewController.swift
//  Demos
//
//  Created by 焦国辉 on 2018/10/30.
//  Copyright © 2018 zyxx. All rights reserved.
//

import UIKit


class FiveStoneChessViewController: UIViewController {

    @IBOutlet weak var boardView: FiveStoneChessBoardView!
    @IBOutlet weak var tipsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.boardView.backgroundColor = UIColor.orange

    }
    
    @IBAction func newGameAction(_ sender: UIButton) {
        self.boardView.newGame()
    }
    
    @IBAction func startAction(_ sender: UIButton) {
        
    }
    
    @IBAction func backStepAction(_ sender: UIButton) {
        self.boardView.backStep()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
