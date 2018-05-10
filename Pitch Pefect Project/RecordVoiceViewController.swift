//
//  ViewController.swift
//  Pitch Pefect Project
//
//  Created by Jawaune on 4/15/18.
//  Copyright © 2018 jaelong. All rights reserved.
//

import UIKit
import AVFoundation

class RecordVoiceViewController: UIViewController, AVAudioRecorderDelegate{
    
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var currentStateLabel: UILabel!
    
    @IBOutlet weak var recordButton: UIButton!
    
    lazy var audioFile = getDocumentsDirectory().appendingPathComponent("recordedVoice.mp4")
    
    
    var audioRecorder: AVAudioRecorder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI(.startRecording)
    }
    
    @IBAction func recordButtonTapped(_ sender: UIButton) {
        recordAudio()
        configureUI(.inProgress)
    }
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        stopRecording()
        stopAudioSession()
        configureUI(.startRecording)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stoppedRecording", sender: stopButton)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("called prepare for segue")
        if segue.identifier == "stoppedRecording" {
            guard let playSoundsViewController = segue.destination as? PlaySoundsViewController else { return }
            
            playSoundsViewController.audioFile = audioFile
        }
    }
    
    //MARK: Helper Methods
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func configureUI(_ playState: labelTitles){
        switch(playState){
        case .inProgress:
            currentStateLabel.text = labelTitles.inProgress.description
            recordButton.isEnabled = false
            stopButton.isEnabled = true
            
        case .startRecording:
            currentStateLabel.text = labelTitles.startRecording.description
            recordButton.isEnabled = true
            stopButton.isEnabled = false
            
        case .recordingFailed:
            currentStateLabel.text = labelTitles.recordingFailed.description
            recordButton.isEnabled = true
            stopButton.isEnabled = false
        }
    }
}
