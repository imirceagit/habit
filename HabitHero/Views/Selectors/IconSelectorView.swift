//
//  IconSelectorView.swift
//  HabitHero
//
//  Created by Mircea Ionita on 30.03.2025.
//

import SwiftUI

struct IconSelectorView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var selectedIcon: String
    var color: Color
    
    var items: [String] = taskIcons
    let rows = [GridItem(.fixed(50)), GridItem(.fixed(50)), GridItem(.fixed(50)), GridItem(.fixed(50))]
    
    var body: some View {
        HStack {
            Button(action: { dismiss() }) {
                Image(systemName: "xmark")
            }
            Spacer()
            Text("Select icon")
            Spacer()
            Image(systemName: selectedIcon)
                .imageScale(.large)
                .cornerRadius(7)
                .padding(5)
                .frame(width: 50, height: 50)
                .background(color.opacity(0.2))
                .cornerRadius(10)
        }
        .padding(.horizontal)
        .padding(.top, 35.0)
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: 20) {
                ForEach(items, id: \.self) { item in
                    Button(action: { selectedIcon = item } ) {
                        ZStack {
                            if selectedIcon == item {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(color.opacity(0.4), lineWidth: 3)
                            }
                            Image(systemName: item)
                                .imageScale(.large)
                                .frame(width: 50, height: 50)
                                .background(color.opacity(0.2))
                                .foregroundStyle(.black)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
            }
            .padding()
        }
        .padding(.bottom)
    }
}

#Preview {
    IconSelectorView(selectedIcon: .constant("figure.run"), color: .gray)
}
