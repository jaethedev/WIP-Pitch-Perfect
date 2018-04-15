//
//  AudioSession.swift
//  Pitch Pefect Project
//
//  Created by Jawaune on 4/15/18.
//  Copyright © 2018 jaelong. All rights reserved.
//


import Foundation
import  AVFoundation

extension RecordVoiceViewController {
    func stopAudioSession(){ let audioSession  = AVAudioSession.sharedInstance()
        do {
            
            try audioSession.setActive(false)
        } catch AudioError.sessionStillActive {
            print(AudioError.sessionStillActive.localizedDescription)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func customizeAudioSession(){
        try? audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
    }
    
    func createAudioSession(){
        audioSession.requestRecordPermission({hasPermission in
            if hasPermission {try? self.audioSession.setActive(true)}})
        
        
    }
    
}
