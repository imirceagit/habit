//
//  Task.swift
//  HabitHero
//
//  Created by Mircea Ionita on 28.03.2025.
//
import Foundation
import SwiftUI

extension PresentationDetent {
    static let small = Self.fraction(0.4)
    static let xsmall = Self.fraction(0.25)
    static let extraLarge = Self.fraction(0.75)
}

extension Array where Element == Int {
    mutating func upsert(_ item: Int) {
        if let existingIndex = firstIndex(of: item) {
            remove(at: existingIndex)
        } else {
            append(item)
        }
    }
}

var unitsOfMeasure: Array<String> = ["times", "steps", "m", "km", "sec", "min", "hr"]

var colors: [String: Color] = ["blue": .blue, "red": .red, "green": .green, "yellow": .yellow, "orange": .orange, "purple": .purple, "brown": .brown, "gray": .gray, "cyan": .cyan, "indigo": .indigo, "mint": .mint, "teal": .teal]

enum GoalPeriodType: String, CaseIterable, Codable, Identifiable {
    case everyDay = "Every day"
    case specificWeekDays = "Specific week days"
    case numberOfDaysPerWeek = "Number of days per week"
    case specificDaysOfMonth = "Specific days of month"
    case numberOfDaysPerMonth = "Number of days per month"
    var id: Self { self }
}
//
//enum WeekDays: String, CaseIterable, Codable, Identifiable {
//    case Calendar.Component.weekday. = "Monday"
//    case 2 = "Tuesday"
//    case 3 = "Wednesday"
//    case 4 = "Thursday"
//    case 5 = "Friday"
//    case 6 = "Saturday"
//    case 7 = "Sunday"
//    var id: Self { self }
//}

let taskIcons: [String] = ["figure.run", "figure.walk", "book", "graduationcap", "bed.double", "figure.walk.treadmill", "figure.basketball", "figure.elliptical", "dumbbell", "pills.fill", "desktopcomputer"]

struct Task: Hashable, Identifiable, Codable {
    var id: UUID
    
    var name: String
    var icon: String
    var color: String
    
    var goal: Int
    var unitOfMeasure: String
    
    var goalPeriod: GoalPeriodType
    var specificWeekDays: Array<Int>
    var numberOfDaysPerWeek: Int
    var specificDaysOfMonth: Array<Int>
    var numberOfDaysPerMonth: Int
    
    var startDate: Date
    var endDate: Date
    
    var progress: Int
    
    var isActive: Bool
    var isCompleted: Bool
    
    func goalValue() -> Int {
        if unitOfMeasure == "sec" {
            return goal
        } else if unitOfMeasure == "min" {
            return goal / 60
        } else if unitOfMeasure == "hr" {
            return goal / 3600
        } else {
            return goal
        }
    }
    
    func isTimeable() -> Bool {
        unitOfMeasure == "sec" || unitOfMeasure == "min" || unitOfMeasure == "hr"
    }
    
    func colorValue() -> Color {
        colors[color] ?? .blue
    }
    
    func progressTimeInterval() -> TimeInterval {
        if isTimeable() {
            return TimeInterval(progress)
        }
        return 0
    }
    
    func progressFormatted() -> String {
        if isTimeable() {
            return progressIfTimeable()
        }
        return "\(progress)"
    }
    
    func progressRatio() -> Double {
        return Double(progress) / Double(goal)
    }
    
    private static func convertToSeccondsIfTimeable(time: Int, unitOfMeasure: String) -> Int {
        if unitOfMeasure == "sec" {
            return time
        } else if unitOfMeasure == "min" {
            return time * 60
        } else if unitOfMeasure == "hr" {
            return time * 3600
        } else {
            return time
        }
    }
    
    private func progressIfTimeable() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        let duration: TimeInterval = Double(progress)
        return formatter.string(from: duration)!
    }
    
    init(name: String, icon: String, color: String, goal: Int, unitOfMeasure: String, goalPeriod: GoalPeriodType, specificWeekDays: Array<Int>, numberOfDaysPerWeek: Int, specificDaysOfMonth: Array<Int>, numberOfDaysPerMonth: Int, startDate: Date, endDate: Date) {
        self.id = UUID.init()
        self.name = name
        self.icon = icon
        self.color = color
        self.goal = Task.convertToSeccondsIfTimeable(time: goal, unitOfMeasure: unitOfMeasure)
        self.unitOfMeasure = unitOfMeasure
        self.goalPeriod = goalPeriod
        self.specificWeekDays = specificWeekDays
        self.numberOfDaysPerWeek = numberOfDaysPerWeek
        self.specificDaysOfMonth = specificDaysOfMonth
        self.numberOfDaysPerMonth = numberOfDaysPerMonth
        self.startDate = startDate
        self.endDate = endDate
        self.progress = 0
        self.isActive = true
        self.isCompleted = false
    }
}

var tasks: [Task] = []
var preloadedTasks: [Task] = load("preloaded_tasks.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }


    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }


    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
