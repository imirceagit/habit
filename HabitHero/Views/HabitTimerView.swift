//
//  TaskTimerView.swift
//  HabitHero
//
//  Created by Mircea Ionita on 28.03.2025.
//

import SwiftUI

struct HabitTimerView: View {
    
    @State var isEditHabit = false
    
    @Binding var habit: Habit?
    
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
                .trim(from: 0.0, to: habit!.progressRatio())
                .stroke(habit!.colorValue(), style: StrokeStyle(lineWidth: 30, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .frame(width: 250, height: 250)
            VStack {
                Text("Elapsed time: \(String(format: "%02d", percentageTimeLapsed()))%")
                    .font(.footnote)
                    .padding(.bottom, 2.0)
                Text(formatter.string(from: habit!.progressTimeInterval())!)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 2.0)
            }
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Add", action: { isEditHabit = true })
                    .fullScreenCover(isPresented: $isEditHabit, content: { CreateHabitFormView(habit: $habit) })
            }
        }
    }
    
    func percentageTimeLapsed() -> Int {
        Int(habit!.progressRatio() * 100)
    }
}

#Preview {
    HabitTimerView(habit: .constant(preloadedHabits[1]))
}
