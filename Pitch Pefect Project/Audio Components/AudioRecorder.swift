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

//Recorder Functionality, Helper Methods?

extension RecordVoiceViewController {
    var settings: [String : Any] {
        return [AVFormatIDKey : Int(kAudioFormatMPEG4AAC), AVSampleRateKey : 12000, AVNumberOfChannelsKey : 1, AVEncoderAudioQualityKey : AVAudioQuality.high.rawValue ]
    }
    func recordAudio(){
        do {
            try audioRecorder = AVAudioRecorder(url: audioFile, settings: settings)
            audioRecorder?.delegate = self as? AVAudioRecorderDelegate
            audioRecorder?.prepareToRecord()
            audioRecorder?.record()
            print("Success")
        } catch AudioError.couldntRecordAudio {
            print("Error is \(AudioError.couldntRecordAudio.localizedDescription)")
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func stopRecording(){
        audioRecorder?.stop()
        print("Stopped Recording")
    }
    
    
    
}
