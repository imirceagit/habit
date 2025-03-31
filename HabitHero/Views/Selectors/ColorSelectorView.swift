//
//  IconSelectorView.swift
//  HabitHero
//
//  Created by Mircea Ionita on 30.03.2025.
//

import SwiftUI

struct ColorSelectorView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var selectedColor: Color
    
    var items: [Color] = colors.map { color in color.value }
    let rows = [GridItem(.fixed(50)), GridItem(.fixed(50)), GridItem(.fixed(50))]
    
    var body: some View {
        HStack {
            Button(action: { dismiss() }) {
                Image(systemName: "xmark")
            }
            Spacer()
            Text("Select color")
            Spacer()
            Image("")
                .imageScale(.large)
                .cornerRadius(7)
                .padding(5)
                .frame(width: 50, height: 50)
                .background(selectedColor.opacity(0.9))
                .cornerRadius(10)
        }
        .padding(.horizontal)
        .padding(.top, 35.0)
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: 20) {
                ForEach(items, id: \.self) { item in
                    Button(action: { selectedColor = item } ) {
                        ZStack {
                            if selectedColor == item {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(selectedColor.opacity(0.4), lineWidth: 7)
                            }
                            Image("")
                                .imageScale(.large)
                                .frame(width: 50, height: 50)
                                .background(item.opacity(0.9))
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
    ColorSelectorView(selectedColor: .constant(.gray))
}
