//
//  TaskListView.swift
//  HabitHero
//
//  Created by Mircea Ionita on 28.03.2025.
//

import SwiftUI

struct HabitListView: View {
    
    @State var isCreateHabit = false
    @State private var path = NavigationPath()
    
    @State private var items: [Habit] = habits
    @State private var selectedHabit: Habit?
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(items) { habit in
                        Button {
                            path.append(habit)
                        } label: {
                            HabitListItemView(habit: habit)
                        }
                        .listRowInsets(.init(top: 0, leading: 10, bottom: 5, trailing: 10))
                        .listRowSeparator(.hidden)
                        .listRowSeparator(.hidden)
                    }
                }
                .padding(.horizontal, 5.0)
            }
            .listStyle(.plain)
            .navigationDestination(for: Habit.self) { habit in
                HabitTimerView(habit: .constant(habit))
            }
            .navigationTitle("Habits")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add", action: {
                        isCreateHabit = true
                        selectedHabit = Habit.newInstance()
                        habits.append(selectedHabit!)
                        items.append(selectedHabit!)
                    })
                    .fullScreenCover(isPresented: $isCreateHabit, content: { CreateHabitFormView(habit: $selectedHabit) })
                }
            }
        }
    }
}

#Preview {
    HabitListView()
}
