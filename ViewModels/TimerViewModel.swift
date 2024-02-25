//
//  TimerViewModel.swift
//  TimerApp
//
//  Created by Nicola Kaleta on 25/02/2024.
//

import SwiftUI
import AudioToolbox
import AVFoundation

class TimerViewModel : NSObject, ObservableObject {
    // MARK: - Published properties
    @Published var progress: Double
    @Published var seconds: TimeInterval
    @Published var displayTime: String = ""
    @Published var goalTime: Double = 0
    
    // MARK: - Private properties
    private var timer: Timer = Timer()
    private var soundID: SystemSoundID = 1407 // id for playing the sound
    private var feedback =  UIImpactFeedbackGenerator(style: .soft)
    
    // MARK: - Initializer
    init(seconds: TimeInterval, goalTime: Double) {
        self.seconds = seconds
        self.goalTime = goalTime
    }
    
    // MARK: - Timer Methods
    @objc func fireTimer(){
        seconds += 0.2
        progress = Double(seconds) / Double(goalTime)
        self.displayTime = calculateDisplayTime()
        
        // Timer is completed
        if progress >= 1 {
            stopSession()
            makeSoundAndVibration()
        }
    }
}
