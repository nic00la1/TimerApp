//
//  ProgressBarView.swift
//  TimerApp
//
//  Created by Nicola Kaleta on 25/02/2024.
//

import SwiftUI

struct ProgressBarView: View {
    // MARK: - Binding properties
    @Binding var progress : TimeInterval
    @Binding var goal : Double
    
    // MARK: - View Body
    var body: some View {
        ZStack {
            // Default Circle
            defaultCircle
            // Overlap Circle
            progressCircle
        }
    }
    
    private var defaultCircle: some View {
        Circle()
            .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .butt, dash: [2, 6]))
            .fill(.gray)
            .rotationEffect(Angle(degrees: -90))
            .frame(width: 300, height: 300)
    }
    
    private var progressCircle: some View {
        Circle()
            .trim(from: 0.0, to: CGFloat(progress) / CGFloat(goal))
            .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .butt, dash: [2, 6]))
            .fill(Color(red: 236/255, green: 230/255, blue: 0/255))
            .animation(.spring(), value: progress)
            .rotationEffect(Angle(degrees: -90))
            .frame(width: 300, height: 300)
    }
}

#Preview {
    ProgressBarView(progress: .constant(0), goal: .constant(0))
}
