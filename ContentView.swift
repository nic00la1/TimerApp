//
//  ContentView.swift
//  TimerApp
//
//  Created by Nicola Kaleta on 25/02/2024.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @ObservedObject var timerViewModel : TimerViewModel
    @State var isPaused = false
    @State private var rotation = 0
    @State private var userInputSeconds = ""
    
    // MARK: - Initializer
    init(seconds: TimeInterval = 0) {
        timerViewModel = TimerViewModel(goalTime: 20) // Default goal time is 20 seconds
    }
    
    // MARK: - View Body
    var body: some View {
        ZStack {
            backgroundColor
            ProgressBarView(progress: $timerViewModel.seconds, goal: $timerViewModel.goalTime)
            centerTitle
            bottomButtons
                .onAppear {
                    timerViewModel.startSession()
                    timerViewModel.viewDidLoad()
                }
        }
    }
    
    // MARK: - Private Views
    private var backgroundColor: some View {
        Color(red: 63/255, green: 68/255, blue: 3/55)
            .ignoresSafeArea()
    }
    private var centerTitle: some View {
        VStack {
            Text(timerViewModel.progress >= 1 ? "Done" : timerViewModel.displayTime )
                .font(.system(size: 50, weight: .bold))
                .foregroundStyle(.white)
            Text("\(timerViewModel.goalTime.asString(style: .short))")
                .foregroundStyle(.white)
                .opacity(0.6)
        }
    }
    private var bottomButtons: some View {
        VStack {
            Text("Timer App")
                .font(.title)
                .foregroundStyle(Color(red: 180/255, green: 187/255, blue: 62/255))
            Spacer()
            buttonView
            TextField("Enter seconds", text: $userInputSeconds)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .keyboardType(.numberPad)
                .foregroundColor(.black)
                .onChange(of: userInputSeconds) { newValue in
                        if let seconds = Double(newValue), seconds > 0 {
                            timerViewModel.goalTime = seconds
                        } else {
                            // Reset to a default value
                            userInputSeconds = ""
                        }
                    }
        }
    }
    private var buttonView: some View {
        HStack {
            resetButton
            startPauseButton
        }
        .padding(.bottom, 40)
        .padding(.horizontal, 20)
    }
    private var resetButton: some View {
        Button {
            reset()
        } label: {
            HStack(spacing: 0) {
                Image(systemName: "arrow.clockwise")
                    .rotationEffect(.degrees(Double(rotation)))
                Text("Reset")
            }
            .padding()
            .tint(.black)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .font(.system(size: 18, weight: .bold))
        }
        .background(Color(red: 236/255, green: 230/255, blue: 0/255))
        .cornerRadius(15)
    }
    private var startPauseButton: some View {
        Button {
            if timerViewModel.progress < 1 {
                isPaused.toggle()
                isPaused ? timerViewModel.pauseSession() : timerViewModel.startSession()
            }
        } label: {
            HStack(spacing: 8) {
                Image(systemName: isPaused ? "play.fill" : "pause.fill")
                Text(isPaused ? "Start" : "Pause")
            }
            .padding()
            .tint(.black)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .font(.system(size: 18, weight: .bold))
        }
        .background(Color(red: 236/255, green: 230/255, blue: 0/255))
        .cornerRadius(15)
    }
    // MARK: - Private Methods
    private func reset() {
        withAnimation(.easeInOut(duration: 0.4)) {
            rotation += 360
        }
        if timerViewModel.progress >= 1 {
            timerViewModel.reset()
            timerViewModel.stopSession()
        } else {
            timerViewModel.reset()
            timerViewModel.displayTime = "00:00"
        }
    }
}

#Preview {
    ContentView()
}

