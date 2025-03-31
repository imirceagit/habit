//
//  HomeView.swift
//  HabitHero
//
//  Created by Mircea Ionita on 28.03.2025.
//

import SwiftUI

struct HomeView: View {
    
    @State private var selectedTab = 0
    @State private var navigateToNewView = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            TaskListView()
            .tabItem {
                Image(systemName: "house")
            }
            .tag(0)
            
            Button("Go to New View") {
                navigateToNewView = true
            }
            .tabItem {
                Image(systemName: "gearshape")
            }
            .badge("1")
            .tag(1)
        }
    }
}

#Preview {
    HomeView()
}
