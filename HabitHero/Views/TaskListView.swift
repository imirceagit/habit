//
//  TaskListView.swift
//  HabitHero
//
//  Created by Mircea Ionita on 28.03.2025.
//

import SwiftUI

struct TaskListView: View {
    
    @State var isRootPresented = false
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(preloadedTasks) { task in
                        Button {
                            path.append(task)
                        } label: {
                            TaskListItemView(task: task)
                        }
                        .listRowInsets(.init(top: 0, leading: 10, bottom: 5, trailing: 10))
                        .listRowSeparator(.hidden)
                        .listRowSeparator(.hidden)
                    }
                }
                .padding(.horizontal, 5.0)
            }
            .listStyle(.plain)
            .navigationDestination(for: Task.self) { task in
                TaskTimerView(task: task)
            }
            .navigationTitle("Tasks")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add", action: { isRootPresented = true })
                        .fullScreenCover(isPresented: $isRootPresented, content: { CreateTaskFormView(root: $isRootPresented) })
                }
            }
        }
    }
}

#Preview {
    TaskListView()
}
