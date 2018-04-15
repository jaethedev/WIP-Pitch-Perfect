//
//  AudioPlayer.swift
//  Pitch Pefect Project
//
//  Created by Jawaune on 4/15/18.
//  Copyright © 2018 jaelong. All rights reserved.
//

import Foundation
import AVFoundation

extension RecordVoiceViewController {
    func playAudio(){
        do {
            try  audioPlayer = AVAudioPlayer(contentsOf: audioFile)
            print("Playing back recording")
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        }
        catch AudioError.playbackFailed {
            print(AudioError.playbackFailed.localizedDescription)
        } catch {
            print(error.localizedDescription)
        }
    }
}
