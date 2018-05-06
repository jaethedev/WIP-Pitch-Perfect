//
//  AudioErrors.swift
//  Pitch Pefect Project
//
//  Created by Jawaune on 4/15/18.
//  Copyright © 2018 jaelong. All rights reserved.
//

import Foundation


enum AudioError: Error {
    case sessionCreationFailed
    case couldntRecordAudio
    case sessionStillActive
    case playbackFailed
    case startEngineFailed
}
