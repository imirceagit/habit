//
//  IconSelectorView.swift
//  HabitHero
//
//  Created by Mircea Ionita on 30.03.2025.
//

import SwiftUI

struct GoalPeriodSelectorView: View {
    @Environment(\.dismiss) var dismiss
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
        
    @Binding var selectedGoalPeriod: GoalPeriodType
    @Binding var specificWeekDays: Array<Int>
    @Binding var numberOfDaysPerWeek: Int
    @Binding var specificDaysOfMonth: Array<Int>
    @Binding var numberOfDaysPerMonth: Int
    let color: Color
    
    let weekDays = Calendar(identifier: .iso8601).weekdaySymbols
    
    var body: some View {
        ScrollView {
            HStack {
                Spacer()
                Text("Goal period")
                Spacer()
                Button(action: { dismiss() }) {
                    Image(systemName: "checkmark")
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 20.0)
            
            Button(action: { selectGoalPeriodType(.everyDay) }){
                VStack {
                    Text("Every Day")
                        .foregroundColor(.black)
                }
                .frame(width: 320)
                .padding()
                .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(selectionColor(.everyDay), lineWidth: 2)
                    )
            }
            
            Button(action: { selectGoalPeriodType(.specificWeekDays) }) {
                VStack {
                    Text("Specific week days")
                        .foregroundColor(.black)
                    if selectedGoalPeriod == .specificWeekDays {
                        HStack {
                            ForEach(Array(weekDays.enumerated()), id: \.element) { index, element in
                                Button(action: { specificWeekDays.upsert(index + 1) }) {
                                    ZStack {
                                        Circle()
                                            .fill(selectionColorForItem(specificWeekDays, index + 1))
                                            .frame(width: 32, height: 32)
                                        Text(element)
                                            .foregroundStyle(.black)
                                    }
                                    .padding(.horizontal, 2.0)
                                }
                            }
                        }
                        .padding(.vertical, 2.0)
                        Text("*Task needs to be done every \(specificWeekDays.map { day in weekDays[day - 1] }.joined(separator: ", "))")
                            .font(.caption)
                            .padding(.top, 2.0)
                            .foregroundStyle(.red.opacity(0.5))
                    }
                }
                .frame(width: 320)
                .padding()
                .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(selectionColor(.specificWeekDays), lineWidth: 2)
                    )
            }
            Button(action: { selectGoalPeriodType(.numberOfDaysPerWeek) }) {
                VStack {
                    Text("Number of days per week")
                        .foregroundColor(.black)
                    if selectedGoalPeriod == .numberOfDaysPerWeek {
                        HStack {
                            Button(action: { numberOfDaysPerWeek-=1 }) {
                                Image(systemName: "minus")
                            }
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(color.opacity(0.3))
                                                .frame(width: 100, height: 25)
                                Text("\(numberOfDaysPerWeek)")
                                    .foregroundStyle(.black)
                            }
                            .padding(.horizontal, 40)
                            Button(action: { numberOfDaysPerWeek+=1 }) {
                                Image(systemName: "plus")
                            }
                        }
                        .padding(.vertical, 2.0)
                        Text("*Complete on any 3 days of the week")
                            .font(.caption)
                            .padding(.top, 2.0)
                            .foregroundStyle(.red.opacity(0.5))
                    }
                }
                .frame(width: 320)
                .padding()
                .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(selectionColor(.numberOfDaysPerWeek), lineWidth: 2)
                    )
            }
            Button(action: { selectGoalPeriodType(.specificDaysOfMonth) }) {
                VStack {
                    Text("Specific days of month")
                        .foregroundColor(.black)
                    if selectedGoalPeriod == .specificDaysOfMonth {
                        HStack {
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(1...31, id: \.self) { index in
                                    Button(action: { specificDaysOfMonth.upsert(index) }) {
                                        ZStack {
                                            Circle()
                                                .fill(selectionColorForItem(specificDaysOfMonth, index))
                                                .frame(width: 32, height: 32)
                                            Text("\(index)")
                                                .foregroundStyle(.black)
                                        }
                                        .padding(.horizontal, 2.0)
                                    }
                                }
                            }
                            .padding()
                        }
                        .padding(.vertical, 2.0)
                        Text("*Task needs to be done every \(specificWeekDays.map { day in weekDays[day - 1] }.joined(separator: ", "))")
                            .font(.caption)
                            .padding(.top, 2.0)
                            .foregroundStyle(.red.opacity(0.5))
                    }
                }
                .frame(width: 320)
                .padding()
                .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(selectionColor(.specificDaysOfMonth), lineWidth: 2)
                    )
            }
            Button(action: { selectGoalPeriodType(.numberOfDaysPerMonth) }) {
                VStack {
                    Text("Number of days per month")
                        .foregroundColor(.black)
                    if selectedGoalPeriod == .numberOfDaysPerMonth {
                        HStack {
                            Button(action: { numberOfDaysPerMonth-=1 }) {
                                Image(systemName: "minus")
                            }
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(color.opacity(0.3))
                                                .frame(width: 100, height: 25)
                                Text("\(numberOfDaysPerMonth)")
                                    .foregroundStyle(.black)
                            }
                            .padding(.horizontal, 40)
                            Button(action: { numberOfDaysPerMonth+=1 }) {
                                Image(systemName: "plus")
                            }
                        }
                        .padding(.vertical, 2.0)
                        Text("*Complete on any 3 days of the month")
                            .font(.caption)
                            .padding(.top, 2.0)
                            .foregroundStyle(.red.opacity(0.5))
                    }
                }
                .frame(width: 320)
                .padding()
                .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(selectionColor(.numberOfDaysPerMonth), lineWidth: 2)
                    )
            }
        }

    }
    
    func selectGoalPeriodType(_ type: GoalPeriodType) {
        selectedGoalPeriod = type
        let dayOfWeek = Calendar.current.component(.weekday, from: .now)
        let dayOfMonth = Calendar.current.component(.day, from: .now)
        switch type {
        case .everyDay:
            specificWeekDays = [dayOfWeek]
            numberOfDaysPerWeek = 1
            specificDaysOfMonth = [dayOfMonth]
            numberOfDaysPerMonth = 1
        case .specificWeekDays:
            numberOfDaysPerWeek = 1
            specificDaysOfMonth = [dayOfMonth]
            numberOfDaysPerMonth = 1
        case .numberOfDaysPerWeek:
            specificWeekDays = [dayOfWeek]
            specificDaysOfMonth = [dayOfMonth]
            numberOfDaysPerMonth = 1
        case .specificDaysOfMonth:
            specificWeekDays = [dayOfWeek]
            numberOfDaysPerWeek = 1
            numberOfDaysPerMonth = 1
        case .numberOfDaysPerMonth:
            specificWeekDays = [dayOfWeek]
            numberOfDaysPerWeek = 1
            specificDaysOfMonth = [dayOfMonth]
        }
    }
    
    func selectionColor(_ type: GoalPeriodType) -> Color {
        selectedGoalPeriod == type ? color.opacity(0.8) : color.opacity(0.3)
    }
    
    func selectionColorForItem(_ array: Array<Int>, _ item: Int) -> Color {
        array.contains(item) ? color.opacity(0.8) : color.opacity(0.3)
    }
}

#Preview {
    GoalPeriodSelectorView(
        selectedGoalPeriod: .constant(.everyDay),
        specificWeekDays: .constant([1, 3, 5]),
        numberOfDaysPerWeek: .constant(3),
        specificDaysOfMonth: .constant([1, 8, 15, 23, 29]),
        numberOfDaysPerMonth: .constant(5),
        color: .green
    )
}
