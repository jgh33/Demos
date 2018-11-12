//
//  AVAudioPlayerViewController.swift
//  Demos
//
//  Created by 焦国辉 on 2018/10/24.
//  Copyright © 2018 zyxx. All rights reserved.
//

import UIKit
import AVFoundation


class AVAudioPlayerViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    var url: URL!
    var timer: Timer? = nil
    
    @IBOutlet weak var time1: UILabel!
    @IBOutlet weak var time2: UILabel!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var playButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        url = URL(fileURLWithPath: Bundle.main.path(forResource: "summer", ofType: "mp3")!)
        progressSlider.isContinuous = false
        if audioPlayer == nil {
            audioPlayer = try! AVAudioPlayer(contentsOf: url)
        }
        audioPlayer.numberOfLoops = -1
        if audioPlayer.prepareToPlay() == true {
            self.progressSlider.maximumValue = Float(audioPlayer.duration)
        }

        refreshUI()
    }
    

    @IBAction func playorPauseAction() {
        if audioPlayer!.isPlaying {
            audioPlayer!.pause()
            refreshUI()
            self.timer?.invalidate()
            
        } else {
            audioPlayer.play()
            self.timer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(refreshUI), userInfo: nil, repeats: true)
        }
    }
    
    

    @IBAction func valueChangeAction(_ sender: UISlider) {
        self.audioPlayer.currentTime = Double(sender.value)
        self.setTimeLabel()
    }
    
    
    @IBAction func valueChangeOver(_ sender: UISlider) {
        self.audioPlayer.currentTime = Double(sender.value)
        audioPlayer.play()
        self.timer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(refreshUI), userInfo: nil, repeats: true)
    }
    
    
    @objc func refreshUI() {
        self.progressSlider.value = Float(self.audioPlayer.currentTime)
        if audioPlayer.isPlaying {
            playButton.setTitle("暂停", for: .normal)
            self.setTimeLabel()
        } else {
            playButton.setTitle("播放", for: .normal)
            
            
        }
    }
    
    func setTimeLabel() {
        var min = Int(self.audioPlayer.currentTime) / 60
        var sec = Int(self.audioPlayer.currentTime) % 60
        var mins = min > 9 ? "\(min)" : "0\(min)"
        var secs = sec > 9 ? "\(sec)" : "0\(sec)"
        self.time1.text = mins + ":" + secs
        
        min = Int(self.audioPlayer.duration - self.audioPlayer.currentTime) / 60
        sec = Int(self.audioPlayer.duration - self.audioPlayer.currentTime) % 60
        mins = min > 9 ? "\(min)" : "0\(min)"
        secs = sec > 9 ? "\(sec)" : "0\(sec)"
        self.time2.text = mins + ":" + secs
    }
    
}
