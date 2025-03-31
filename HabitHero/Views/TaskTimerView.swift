//
//  TaskTimerView.swift
//  HabitHero
//
//  Created by Mircea Ionita on 28.03.2025.
//

import SwiftUI

struct TaskTimerView: View {
    
    var task: Task
    
    let formatter = DateComponentsFormatter()
    
    private let gradient = AngularGradient(
        gradient: Gradient(colors: [Color.blue, .purple]),
        center: .center,
        startAngle: .degrees(270),
        endAngle: .degrees(0))

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 30)
                .frame(width: 250, height: 250)
            
            Circle()
                .trim(from: 0.0, to: task.progressRatio())
                .stroke(task.colorValue(), style: StrokeStyle(lineWidth: 30, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .frame(width: 250, height: 250)
            VStack {
                Text("Elapsed time: \(String(format: "%02d", percentageTimeLapsed()))%")
                    .font(.footnote)
                    .padding(.bottom, 2.0)
                Text(formatter.string(from: task.progressTimeInterval())!)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 2.0)
            }
        }
        .padding()
    }
    
    func percentageTimeLapsed() -> Int {
        Int(task.progressRatio() * 100)
    }
}

#Preview {
    TaskTimerView(task: preloadedTasks[1])
}
