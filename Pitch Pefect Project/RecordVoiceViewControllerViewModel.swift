//
//  RecordVoiceViewControllerViewModel.swift
//  Pitch Pefect Project
//
//  Created by Jawaune on 4/21/18.
//  Copyright © 2018 jaelong. All rights reserved.
//

import Foundation


enum labelTitles: String, CustomStringConvertible {
    case inProgress = "Recording is in Progress.."
    case recordingFailed = "Recording failed"
    case startRecording = "Tap to record"
    
    var description: String {
        return self.rawValue
    }
}
