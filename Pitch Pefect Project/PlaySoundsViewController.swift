//
//  PlaySoundsViewController.swift
//  Pitch Pefect Project
//
//  Created by Jawaune on 4/15/18.
//  Copyright © 2018 jaelong. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation



class PlaySoundsViewController: UIViewController{
    var audioPlayer: AVAudioPlayer?
    var audioFile: URL?
    var audioEngine: AVAudioEngine?
    var audioFileAVA: AVAudioFile?
    var audioPlayerNode: AVAudioPlayerNode?
    var audioTimer: Timer?
    
    
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var darthVaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    
    @IBAction func stopButtonPressed(_ sender: UIButton){
        stopAudio()
    }
    
    enum buttonEffect: Int {
        case chipmunk = 1
        case darthVader
        case echo
        case fast
        case reverb
        case snail
    }
    
    @IBAction func soundEffectButtonPressed(_ sender: UIButton) {
        switch buttonEffect(rawValue: sender.tag)!{
            
        case .chipmunk:
            playSound(pitch: 1000)
        case .darthVader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .fast:
            playSound(rate: 1.5)
        case .reverb:
            playSound(reverb: true)
        case .snail:
            playSound(rate: 0.5)
        }
        configureUI(playState: .playing)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let buttonArray = [chipmunkButton,darthVaderButton, echoButton, fastButton, reverbButton, slowButton]
        
        for button in buttonArray {
            button?.imageView?.contentMode = .scaleAspectFit
        }

        configureUI(playState: .notPlaying)
    }
    
    override func viewDidLoad() {
        setupAudio()
    }
    
    func stopAudio() {
        audioPlayerNode?.stop()
        audioTimer?.invalidate()
        configureUI(playState: .notPlaying)
    }
    
    enum playState {
        case playing
        case notPlaying
    }
    
    func configureUI(playState: playState) {
        switch(playState) {
        case .playing:
            setPlayButtonsEnabled(false)
            stopButton.isEnabled = true
        case .notPlaying:
            setPlayButtonsEnabled(true)
            stopButton.isEnabled = false
        }
    }
    
    func setPlayButtonsEnabled(_ enabled: Bool){
        chipmunkButton.isEnabled = enabled
        darthVaderButton.isEnabled = enabled
        fastButton.isEnabled = enabled
        slowButton.isEnabled = enabled
        echoButton.isEnabled = enabled
        reverbButton.isEnabled = enabled
    }
    
}
