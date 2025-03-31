//
//  IconSelectorView.swift
//  HabitHero
//
//  Created by Mircea Ionita on 30.03.2025.
//

import SwiftUI

struct DateSelectorView: View {
    @Environment(\.dismiss) var dismiss
    
    let minDate: Date
    @Binding var selectedDate: Date
    let isEndDate: Bool
    
    var items: [Color] = colors.map { color in color.value }
    let rows = [GridItem(.fixed(50)), GridItem(.fixed(50)), GridItem(.fixed(50)), GridItem(.fixed(50))]
    
    var body: some View {
        HStack {
            Button(action: { dismiss() }) {
                Image(systemName: "xmark")
            }
            Spacer()
            Text("Select date")
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 35.0)
        DatePicker("", selection: $selectedDate, displayedComponents: .date)
            .datePickerStyle(.wheel)
            .labelsHidden()
            .id(UUID.init())
            .onChange(of: selectedDate) {
                if selectedDate == Date.distantPast {
                    return
                }
                if selectedDate < minDate {
                    selectedDate = minDate
                }
            }
        HStack {
            if isEndDate {
                Button(action: { noEndDate() }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.red.opacity(0.5))
                            .frame(height: 30)
                        Text("No End")
                            .foregroundStyle(.black)
                            .font(.headline)
                    }
                    .frame(width: 150)
                }
            }
            Button(action: { dismiss() }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.green.opacity(0.5))
                        .frame(height: 30)
                    Text("Confirm")
                        .foregroundStyle(.black)
                        .font(.headline)
                }
                .frame(width: 150)
            }
        }
    }
    
    func noEndDate() {
        selectedDate = Date.distantPast
        dismiss()
    }
}

#Preview {
    DateSelectorView(minDate: Date.now, selectedDate: .constant(Date.now), isEndDate: true)
}
