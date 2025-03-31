//
//  TaskListItemView.swift
//  HabitHero
//
//  Created by Mircea Ionita on 29.03.2025.
//

import SwiftUI

struct HabitListItemView: View {
    
    var habit: Habit
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(habit.colorValue().opacity(0.2))
                
                Rectangle()
                    .fill(habit.colorValue().opacity(0.2))
                    .frame(width: geometry.size.width * habit.progressRatio())
                HStack {
                    Image(systemName: habit.icon)
                        .foregroundColor(habit.colorValue())
                        .font(.system(size: 24))
                        .fixedSize()
                        
                    Text(habit.name)
                        .font(.system(size: 24))
                    
                    Spacer()
                    
                    Text(progressText(habit))
                        .font(.system(size: 18))
                        .fontWeight(.light)
                }
                .padding(.horizontal)
            }
        }
        .frame(height: 80)
        .cornerRadius(10)
    }
    
    func progressText(_ habit: Habit) -> String {
        "\(habit.progressFormatted())/\(habit.goalValue())\(habit.unitOfMeasure)"
    }
}

#Preview {
    Group {
        HabitListItemView(habit: preloadedHabits[0])
        HabitListItemView(habit: preloadedHabits[1])
    }
}
