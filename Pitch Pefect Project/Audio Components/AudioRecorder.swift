//
//  AudioRecorder.swift
//  Pitch Pefect Project
//
//  Created by Jawaune on 4/15/18.
//  Copyright © 2018 jaelong. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

//Recorder Functionality

extension RecordVoiceViewController {
    
    var settings: [String : Any] {
        return [AVFormatIDKey : Int(kAudioFormatMPEG4AAC), AVSampleRateKey : 12000, AVNumberOfChannelsKey : 1, AVEncoderAudioQualityKey : AVAudioQuality.high.rawValue ]}
    
    func recordAudio(){
        do {
            try audioRecorder = AVAudioRecorder(url: audioFile, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.isMeteringEnabled = true
            audioRecorder?.prepareToRecord()
            audioRecorder?.record()
            print("Success with recording audio")
        } catch AudioError.couldntRecordAudio
        { print("Error is \(AudioError.couldntRecordAudio.localizedDescription)")}
        catch { print(error.localizedDescription)}
    }
    
    func stopRecording(){
        audioRecorder?.stop()
    }
}
