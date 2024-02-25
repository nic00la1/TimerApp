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
        }
    }
    
    // MARK: - Private Views
    private var backgroundColor: some View {
        Color(red: 63/255, green: 68/255, blue: 3/55)
            .ignoresSafeArea()
    }
    
}

#Preview {
    ContentView()
}
