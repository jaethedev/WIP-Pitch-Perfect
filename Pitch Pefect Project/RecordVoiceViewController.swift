//
//  ViewController.swift
//  Pitch Pefect Project
//
//  Created by Jawaune on 4/15/18.
//  Copyright © 2018 jaelong. All rights reserved.
//

import UIKit
import AVFoundation

class RecordVoiceViewController: UIViewController {
    
    @IBOutlet weak var currentStateLabel: UILabel!
    
    
    lazy var audioFile = getDocumentsDirectory().appendingPathComponent("recordedVoice.mp4")
    
    lazy var audioSession = AVAudioSession.sharedInstance()
    
    var audioRecorder: AVAudioRecorder?
    var audioEngine: AVAudioEngine?
    var audioMixer: AVAudioMix?
    var audioPlayer: AVAudioPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        currentStateLabel.text = "Tap to record"
        createAudioSession()
        customizeAudioSession()
        
    }
    @IBAction func recordButtonTapped(_ sender: Any) {
        recordAudio()
        currentStateLabel.text = "Recording in Progress"

    }
    @IBAction func stopButtonTapped(_ sender: Any) {
        stopAudioSession()
        stopRecording()
        currentStateLabel.text = "Tap to record"

    }
    @IBAction func playbackButton(_ sender: Any) {
        playAudio()
    }
    
    //Helper Methods
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

 


}

