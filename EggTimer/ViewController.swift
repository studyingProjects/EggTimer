//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var eggMessage: UILabel!
    @IBOutlet var eggBar: UIProgressView!
        
    var count: Float = 0.0
    var selectedTime: Float = 0.0
    var timer = Timer()
    var player: AVAudioPlayer!
    let eggTime = ["Soft": 300, "Medium": 320, "Hard": 720]
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        let hardness = sender.currentTitle!
        count = 0.0
        selectedTime = Float(eggTime[hardness]!)
        
        eggBar.progress = 0.0
        eggMessage.text = hardness
        
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    @objc func update() {
        if(count <= selectedTime) {
            eggBar.progress = count / selectedTime
            count += 1
        } else {
            playSound(soundName: "alarm_sound", extensionName: "mp3")
            eggMessage.text = "DONE"
            timer.invalidate()
        }
    }
    
    func playSound(soundName: String, extensionName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: extensionName)
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }
}
