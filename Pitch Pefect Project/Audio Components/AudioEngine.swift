//
//  AudioEngine.swift
//  Pitch Perfect Project
//
//  Created by Jawaune on 4/14/18.
//  Copyright © 2018 jaelong. All rights reserved.
//

import Foundation
import AVFoundation

extension PlaySoundsViewController {
    func connectAudioNodes(_ nodes: AVAudioNode...) {
        guard let audioEngine = audioEngine else { return }
        for x in 0..<nodes.count-1 {
            audioEngine.connect(nodes[x], to: nodes[x+1], format: audioFileAVA?.processingFormat)
        }
    }
    
    //Sets up the recorded file for reading
    func setupAudio(){
        guard let audioFile = audioFile else { return }
        do {
            try  audioFileAVA = AVAudioFile(forReading: audioFile)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func playSound(rate: Float? = nil, pitch: Float? = nil, echo: Bool = false, reverb: Bool = false) {
        audioEngine = AVAudioEngine()
        audioPlayerNode = AVAudioPlayerNode()
        
        guard let audioPlayerNode = audioPlayerNode, let audioEngine = audioEngine, let recordedFile = audioFileAVA else {
            return
        }
        
        // node for adjusting rate/pitch
        let changeRatePitchNode = AVAudioUnitTimePitch()
        if let pitch = pitch {
            changeRatePitchNode.pitch = pitch
        }
        if let rate = rate {
            changeRatePitchNode.rate = rate
        }
        
        // node for echo
        let echoNode = AVAudioUnitDistortion()
        echoNode.loadFactoryPreset(.multiEcho1)
        
        // node for reverb
        let reverbNode = AVAudioUnitReverb()
        reverbNode.loadFactoryPreset(.cathedral)
        reverbNode.wetDryMix = 50
        
        //attach all nodes to audioEngine
        audioEngine.attachAll(nodes: audioPlayerNode, echoNode, changeRatePitchNode, reverbNode)
        
        
        
        // connect nodes
        if echo && reverb {
            connectAudioNodes(audioPlayerNode, changeRatePitchNode, echoNode, reverbNode, audioEngine.outputNode)
        } else if echo {
            connectAudioNodes(audioPlayerNode, changeRatePitchNode, echoNode, audioEngine.outputNode)
        } else if reverb {
            connectAudioNodes(audioPlayerNode, changeRatePitchNode, reverbNode, audioEngine.outputNode)
        } else {
            connectAudioNodes(audioPlayerNode, changeRatePitchNode, audioEngine.outputNode)
        }
        
        // schedule to play and start the engine!
        audioPlayerNode.stop()
        try? audioEngine.start()
        audioPlayerNode.scheduleFile(recordedFile, at: nil)
        audioPlayerNode.play()
        
        var delayInSeconds: Double = 0
        
        if let lastRenderTime = audioPlayerNode.lastRenderTime, let playerTime = audioPlayerNode.playerTime(forNodeTime: lastRenderTime) {
            
            
            delayInSeconds = getDelayFrom(length: recordedFile.length, sampleTime: playerTime.sampleTime, sampleRate: recordedFile.processingFormat.sampleRate, rate: rate)
            
            // schedule a stop timer for when audio finishes playing
            
            self.audioTimer = Timer.scheduledTimer(withTimeInterval: delayInSeconds, repeats: false) { _ in
                self.stopAudio()
            }
            
        }
    }
}
func  getDelayFrom(length: AVAudioFramePosition, sampleTime: AVAudioFramePosition, sampleRate: Double, rate: Float? = nil) -> Double {
    if let rate = rate {
        
        return Double(length - sampleTime) / sampleRate / Double(rate)
    } else {
        
        return  Double(length - sampleTime) / sampleRate
    }
}
extension AVAudioFile {
    var sampleTime: Double {
        return Double(self.processingFormat.sampleRate)
    }
}

extension AVAudioEngine {
    func attachAll(nodes: AVAudioNode...) {
        for node in nodes {
            self.attach(node)
        }
    }
}
