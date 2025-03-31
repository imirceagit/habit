//
//  CreateTaskFormView.swift
//  HabitHero
//
//  Created by Mircea Ionita on 29.03.2025.
//

import SwiftUI

struct CreateHabitFormView: View {
    @Environment(\.dismiss) var dismiss
    
    let weekDays = Calendar(identifier: .gregorian).weekdaySymbols
    let dayOfWeek = Calendar.current.component(.weekday, from: .now)
    let dayOfMonth = Calendar.current.component(.day, from: .now)
    
    @Binding var habit: Habit?
    
    @State private var selectIcon: Bool = false
    @State private var selectColor: Bool = false
    @State private var selectUnitOfMeasure: Bool = false
    @State private var selectGoalPeriod: Bool = false
    @State private var selectStartDate: Bool = false
    @State private var selectEndDate: Bool = false
    
    @State private var habitName: String = ""
    @State private var habitDescription: String = ""
    @State private var selectedIcon: String = "plus"
    @State private var selectedColor: Color = .gray
    
    @State private var goalValue: Int = 0
    @State private var selectedGoalUnitOfMeasure: String = "times"
    @State private var selectedGoalPeriod: GoalPeriodType = .everyDay
    @State private var specificWeekDays: Array<Int> = []
    @State private var numberOfDaysPerWeek: Int = 1
    @State private var specificDaysOfMonth: Array<Int> = []
    @State private var numberOfDaysPerMonth: Int = 1
    
    @State private var selectedStartDate: Date = Date.now
    @State private var selectedEndDate: Date = Date.now.addingTimeInterval(86400)
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Button(action: { selectIcon = true }) {
                            Image(systemName: selectedIcon)
                                .frame(width: 40, height: 50)
                                .imageScale(.large)
                        }
                        .padding(.trailing, 5.0)
                        .buttonStyle(.borderedProminent)
                        .tint(selectedColor.opacity(0.8))
                        .sheet(isPresented: $selectIcon) {
                            IconSelectorView(selectedIcon: $selectedIcon, color: selectedColor)
                                .presentationDetents([.small])
                        }
                        VStack(spacing: 18) {
                            TextField("Habit name", text: $habitName)
                            TextField("Description", text: $habitDescription)
                        }
                    }
                    HStack {
                        Text("Color")
                            .font(.headline)
                        Spacer()
                        Button(action: { selectColor = true }) {
                            Text("            ")
                                .font(.system(size: 10))
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(selectedColor.opacity(0.8))
                        .sheet(isPresented: $selectColor) {
                            ColorSelectorView(selectedColor: $selectedColor)
                                .presentationDetents([.small])
                        }
                    }
                }
                Section {
                    HStack {
                        Text("Goal value")
                            .font(.headline)
                        Spacer()
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(selectedColor.opacity(0.3))
                                .frame(height: 25)
                            TextField("", value: $goalValue, format: .number)
                                .frame(width: 80)
                                .multilineTextAlignment(.center)
                                .keyboardType(.numberPad)
                        }
                        .frame(width: 80)
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(selectedColor.opacity(0.3))
                                .frame(height: 25)
                            Button(action: { selectUnitOfMeasure = true }) {
                                Text(selectedGoalUnitOfMeasure)
                                    .foregroundStyle(.black)
                            }
                            .sheet(isPresented: $selectUnitOfMeasure) {
                                GoalUnitOfMeasureSelectorView(selectedUnitOfMeasure: $selectedGoalUnitOfMeasure, color: selectedColor)
                                    .presentationDetents([.xsmall])
                            }
                        }
                        .frame(width: 60)
                        Text("/Day")
                    }
                    VStack(spacing: 18) {
                        HStack {
                            Text("Goal period")
                                .font(.headline)
                            Spacer()
                            Button(action: { selectGoalPeriod = true }) {
                                HStack {
                                    Text(selectedGoalPeriod.rawValue)
                                        .foregroundStyle(selectedColor.opacity(0.8))
                                        .font(.system(size: 15))
                                    Image(systemName: "chevron.right")
                                }
                            }
                            .sheet(isPresented: $selectGoalPeriod) {
                                GoalPeriodSelectorView(selectedGoalPeriod: $selectedGoalPeriod, specificWeekDays: $specificWeekDays, numberOfDaysPerWeek: $numberOfDaysPerWeek, specificDaysOfMonth: $specificDaysOfMonth, numberOfDaysPerMonth: $numberOfDaysPerMonth, color: selectedColor)
                            }
                        }
                        HStack {
                            Spacer()
                            if selectedGoalPeriod == .specificWeekDays {
                                Text("\(specificWeekDays.sorted().map {it in weekDays[it-1]}.joined(separator: ", "))")
                                    .font(.caption)
                            }
                            if selectedGoalPeriod == .numberOfDaysPerWeek {
                                Text("\(numberOfDaysPerWeek)")
                                    .font(.caption)
                            }
                            if selectedGoalPeriod == .specificDaysOfMonth {
                                Text("\(specificDaysOfMonth.sorted().map {it in String(it)}.joined(separator: ", "))")
                                    .font(.caption)
                            }
                            if selectedGoalPeriod == .numberOfDaysPerMonth {
                                Text("\(numberOfDaysPerMonth)")
                                    .font(.caption)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .onAppear {
                        specificWeekDays = [dayOfWeek]
                        numberOfDaysPerWeek = 1
                        specificDaysOfMonth = [dayOfMonth]
                        numberOfDaysPerMonth = 1
                    }
                }
                Section {
                    VStack {
                        Text("Habit Term")
                            .font(.headline)
                        HStack {
                            VStack {
                                Text("Start Date")
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(selectedColor.opacity(0.3))
                                        .frame(height: 25)
                                    Button(action: { selectStartDate = true }) {
                                        Text(selectedStartDate.formatted(date: .numeric, time: .omitted))
                                            .foregroundStyle(.black)
                                    }
                                    .sheet(isPresented: $selectStartDate) {
                                        DateSelectorView(minDate: Date.now, selectedDate: $selectedStartDate, isEndDate: false)
                                            .presentationDetents([.small])
                                    }
                                }
                            }
                            Spacer(minLength: 50)
                            VStack {
                                Text("End Date")
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(selectedColor.opacity(0.3))
                                        .frame(height: 25)
                                    Button(action: {
                                        normalizeEndDate()
                                        selectEndDate = true
                                    }) {
                                        Text(selectedEndDate < selectedStartDate ? "No Date" : selectedEndDate.formatted(date: .numeric, time: .omitted))
                                            .foregroundStyle(.black)
                                    }
                                    .sheet(isPresented: $selectEndDate) {
                                        DateSelectorView(minDate: selectedStartDate, selectedDate: $selectedEndDate, isEndDate: true)
                                            .presentationDetents([.small])
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Create habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {  }) {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save", action: { saveNewHabit() })
                }
            }
        }
        .onAppear {
            loadHabitData()
        }
    }
    
    func normalizeEndDate() {
        if selectedEndDate <= Date.distantPast {
            selectedEndDate = selectedStartDate
        }
    }
    
    func saveNewHabit() {
        let color: String = reversedColors[selectedColor] ?? "gray"
        habit = Habit(name: habitName, description: habitDescription, icon: selectedIcon, color: color, goal: goalValue, unitOfMeasure: selectedGoalUnitOfMeasure, goalPeriod: selectedGoalPeriod, specificWeekDays: specificWeekDays, numberOfDaysPerWeek: numberOfDaysPerWeek, specificDaysOfMonth: specificDaysOfMonth, numberOfDaysPerMonth: numberOfDaysPerMonth, startDate: selectedStartDate, endDate: selectedEndDate)
        
        dismiss()
    }
    
    func loadHabitData() {
        habitName = habit?.name ?? ""
        habitDescription = habit?.description ?? ""
        selectedIcon = habit?.icon ?? "plus"
        let color = habit?.color ?? "gray"
        selectedColor = colors[color] ?? .gray
        
        goalValue = habit?.goal ?? 0
        selectedGoalUnitOfMeasure = habit?.unitOfMeasure ?? "times"
        selectedGoalPeriod = habit?.goalPeriod ?? .everyDay
        specificWeekDays = habit?.specificWeekDays ?? []
        numberOfDaysPerWeek = habit?.numberOfDaysPerWeek ?? 1
        specificDaysOfMonth = habit?.specificDaysOfMonth ?? []
        numberOfDaysPerMonth = habit?.numberOfDaysPerMonth ?? 1
        
        selectedStartDate = habit?.startDate ?? Date.now
        selectedEndDate = habit?.endDate ?? Date.now.addingTimeInterval(86400)
    }
}

#Preview {
    CreateHabitFormView(habit: .constant(preloadedHabits[0]))
}
