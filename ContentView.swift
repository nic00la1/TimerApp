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
    @State var isPause = false
    @State private var rotation = 0
    
    // MARK: - Initializer
    init(seconds: TimeInterval = 0) {
        timerViewModel = TimerViewModel(seconds: seconds, goalTime: 20)
    }
    
    // MARK: - View Body
    var body: some View {
        ZStack {
            backgroundColor
            ProgressBarView(progress: $timerViewModel.seconds, goal: $timerViewModel.goalTime)
            centerTitle
            bottomButtons
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
        }
    }
    private var buttonView: some View {
        HStack {
            resetButton
        }
    }
    private var resetButton: some View {
        Button {
           // reset()
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
}

#Preview {
    ContentView()
}

