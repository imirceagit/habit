//
//  TaskListItemView.swift
//  HabitHero
//
//  Created by Mircea Ionita on 29.03.2025.
//

import SwiftUI

struct TaskListItemView: View {
    
    var task: Task
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(task.colorValue().opacity(0.2))
                
                Rectangle()
                    .fill(task.colorValue().opacity(0.2))
                    .frame(width: geometry.size.width * task.progressRatio())
                HStack {
                    Image(systemName: task.icon)
                        .foregroundColor(task.colorValue())
                        .font(.system(size: 24))
                        .fixedSize()
                        
                    Text(task.name)
                        .font(.system(size: 24))
                    
                    Spacer()
                    
                    Text(progressText(task))
                        .font(.system(size: 18))
                        .fontWeight(.light)
                }
                .padding(.horizontal)
            }
        }
        .frame(height: 80)
        .cornerRadius(10)
    }
    
    func progressText(_ task: Task) -> String {
        "\(task.progressFormatted())/\(task.goalValue())\(task.unitOfMeasure)"
    }
}

#Preview {
    Group {
        TaskListItemView(task: preloadedTasks[0])
        TaskListItemView(task: preloadedTasks[1])
    }
}
