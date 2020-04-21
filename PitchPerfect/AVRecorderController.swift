//
//  AVRecorderController.swift
//  PitchPerfect
//
//  Created by Renan Maganha on 10/04/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import SwiftUI
import AVFoundation

class AVRecorderController: NSObject, ObservableObject, AVAudioRecorderDelegate {
    
    //MARK: - Change Recorded status
    var isRecorded = false
    
    //MARK: - Defines the url of recorded audio
    var audioRecordedURL: URL {
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        return filePath!
    }
    
    var audioRecorder: AVAudioRecorder!
    
    //MARK: - Record Audio
    func recordAudio() {

        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        do {
            try audioRecorder = AVAudioRecorder(url: audioRecordedURL, settings: [:])
        } catch {
            print(error.localizedDescription)
        }

        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    //MARK: - Stop Recording
    func stopRecording() {
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    //MARK: - Send the user to the another view
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        isRecorded = true
    }
    
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    //MARK: - Plays the sound
    func playSound(rate: Float? = nil, pitch: Float? = nil, echo: Bool = false, reverb: Bool = false) {
        // stop ongoing audio playback
        stopAudio()
        
        // initialize audio engine components
        audioEngine = AVAudioEngine()
        
        // node for playing audio
        audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attach(audioPlayerNode)
        
        // node for adjusting rate/pitch
        let changeRatePitchNode = AVAudioUnitTimePitch()
        if let pitch = pitch {
            changeRatePitchNode.pitch = pitch
        }
        if let rate = rate {
            changeRatePitchNode.rate = rate
        }
        audioEngine.attach(changeRatePitchNode)
        
        // node for echo
        let echoNode = AVAudioUnitDistortion()
        echoNode.loadFactoryPreset(.multiEcho1)
        audioEngine.attach(echoNode)
        
        // node for reverb
        let reverbNode = AVAudioUnitReverb()
        reverbNode.loadFactoryPreset(.cathedral)
        reverbNode.wetDryMix = 50
        audioEngine.attach(reverbNode)
        
        let audioFile = try! AVAudioFile(forReading: audioRecordedURL)
        
        // connect nodes
        if echo == true && reverb == true {
            connectAudioNodes(audioFile: audioFile, audioPlayerNode, changeRatePitchNode, echoNode, reverbNode, audioEngine.outputNode)
        } else if echo == true {
            connectAudioNodes(audioFile: audioFile, audioPlayerNode, changeRatePitchNode, echoNode, audioEngine.outputNode)
        } else if reverb == true {
            connectAudioNodes(audioFile: audioFile, audioPlayerNode, changeRatePitchNode, reverbNode, audioEngine.outputNode)
        } else {
            connectAudioNodes(audioFile: audioFile, audioPlayerNode, changeRatePitchNode, audioEngine.outputNode)
        }
        
        // schedule to play and start the engine!
        audioPlayerNode.stop()
        audioPlayerNode.scheduleFile(audioFile, at: nil) {
            
            var delayInSeconds: Double = 0
            
            if let lastRenderTime = self.audioPlayerNode.lastRenderTime, let playerTime = self.audioPlayerNode.playerTime(forNodeTime: lastRenderTime) {
                
                if let rate = rate {
                    delayInSeconds = Double(audioFile.length - playerTime.sampleTime) / Double(audioFile.processingFormat.sampleRate) / Double(rate)
                } else {
                    delayInSeconds = Double(audioFile.length - playerTime.sampleTime) / Double(audioFile.processingFormat.sampleRate)
                }
            }
            self.stopTimer = Timer(timeInterval: delayInSeconds, target: self, selector: #selector(AVRecorderController.stopAudio), userInfo: nil, repeats: false)
        }
        
        do {
            try audioEngine.start()
        } catch {
            return
        }
        
        // play the recording!
        audioPlayerNode.play()
    }
    
    func connectAudioNodes(audioFile: AVAudioFile, _ nodes: AVAudioNode...) {
        for x in 0..<nodes.count-1 {
            audioEngine.connect(nodes[x], to: nodes[x+1], format: audioFile.processingFormat)
        }
    }
    
    //MARK: - Stop playing audio
    @objc func stopAudio() {
        
        if let audioPlayerNode = audioPlayerNode {
            audioPlayerNode.stop()
        }

        if let stopTimer = stopTimer {
            stopTimer.invalidate()
        }

        if let audioEngine = audioEngine {
            audioEngine.stop()
            audioEngine.reset()
        }
    }
}
