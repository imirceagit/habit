//
//  IconSelectorView.swift
//  HabitHero
//
//  Created by Mircea Ionita on 30.03.2025.
//

import SwiftUI

struct GoalUnitOfMeasureSelectorView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var selectedUnitOfMeasure: String
    let color: Color
    
    var items: [String] = unitsOfMeasure
    let rows = [GridItem(.fixed(50)), GridItem(.fixed(50))]
    
    var body: some View {
        HStack {
            Button(action: { dismiss() }) {
                Image(systemName: "xmark")
            }
            Spacer()
            Text("Select unit")
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 20.0)
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: 20) {
                ForEach(items, id: \.self) { item in
                    Button(action: { selectedUnitOfMeasure = item } ) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(selectionColor(item))
                                .frame(height: 25)
                            Text(item)
                                .foregroundStyle(.black)
                        }
                        .frame(width: 60)
                    }
                }
            }
            .padding()
        }
    }
    
    func selectionColor(_ unit: String) -> Color {
        selectedUnitOfMeasure == unit ? color.opacity(0.8) : color.opacity(0.3)
    }
}

#Preview {
    GoalUnitOfMeasureSelectorView(selectedUnitOfMeasure: .constant("times"), color: .cyan)
}
