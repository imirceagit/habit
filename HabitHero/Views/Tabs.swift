//
//  Tabs.swift
//  HabitHero
//
//  Created by Mircea Ionita on 28.03.2025.
//
import SwiftUI

struct Tabs: View {
    @State private var selectedTab = 0
    @State private var navigateToNewView = false  // Track navigation

    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                HomeaView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag(0)
                
                Button("Go to New View") {
                    navigateToNewView = true
                }
                .tabItem {
                    Label("Go", systemImage: "arrow.right.circle")
                }
                .tag(1)
            }
            .navigationDestination(isPresented: $navigateToNewView) {
                NewView()
            }
        }
    }
}

struct HomeaView: View {
    var body: some View {
        Text("Home Screen")
    }
}

struct NewView: View {
    var body: some View {
        Text("New View")
            .font(.largeTitle)
    }
}

#Preview {
    Tabs()
}
