//
//  DemosTableViewController.swift
//  Demos
//
//  Created by 焦国辉 on 2018/10/24.
//  Copyright © 2018 zyxx. All rights reserved.
//

import UIKit


let 动画: (name: String, list: [String]) = ("动画", ["基本动画", "转场动画", "Other"])
let 算法: (name: String, list: [String]) = ("算法", ["排序算法", "只能"])
let 多媒体: (name: String, list: [String]) = ("多媒体", ["AVAudioPlayer", "MPMovie"])
let 棋牌:  (name: String, list: [String]) = ("棋牌", ["象棋", "五子棋"])
let 加密认证: (name: String, list: [String]) = ("加密认证", ["TouchID / FaceID", "加密算法"])
let 文件共享: (name: String, list: [String]) = ("文件共享", ["接收", "发送"])
let sections = [动画, 算法, 多媒体, 棋牌, 加密认证]
class DemosTableViewController: UITableViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sections[section].list.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DemosCell", for: indexPath)
        cell.textLabel?.text = sections[indexPath.section].list[indexPath.row]

        return cell
    }
    

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].name
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var name = ""
        var id = ""
        switch indexPath.section {
        case 0:
            name = "Animation"
            if indexPath.row == 0 {
                id = "BaseAnimationController"
            } else if indexPath.row == 1 {
                id = "TransitionViewController"
            } else if indexPath.row == 2 {
                id = "OtherAnimationViewController"
            }
        case 1:
            name = "Algorithm"
            if indexPath.row == 0 {
                id = "SortViewController"
            } else if indexPath.row == 1 {
                id = "B"
            }
        case 2:
            name = "AudioVideo"
            if indexPath.row == 0 {
                id = "AVAudioPlayerViewController"
            } else if indexPath.row == 1 {
                id = "B"
            }
        case 3:
            name = "Chess"
            if indexPath.row == 0 {
                id = "ChineseChessViewController"
            } else if indexPath.row == 1 {
                id = "FiveStoneChessViewController"
            }
        case 4:
            name = "Encryption"
            if indexPath.row == 0 {
                id = ""
            } else if indexPath.row == 1 {
                id = ""
            }
        case 5:
            name = ""
            if indexPath.row == 0 {
                id = ""
            } else if indexPath.row == 1 {
                id = ""
            }
        default:
            name = "Algorithm"
            id = "SortViewController"
        }
        let sb = UIStoryboard(name: name, bundle: nil)
        let controller = sb.instantiateViewController(withIdentifier: id)
        self.navigationController?.pushViewController(controller, animated: true)
    }

  


   

}
