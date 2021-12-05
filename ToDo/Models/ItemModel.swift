//
//  ToDoItemModel.swift
//  ToDo
//
//  Created by Шынгыс Курбан on 11.11.2021.
//

import Foundation

struct ItemModel: Identifiable {
    var id = UUID().uuidString
    var name: String
    var isCompleted: Bool
    var priority: PriorityType
//    var notes: String
//    var tag: String
    var date: Date
    var pomodoros: [Pomodoro]
    
    init(id: String = UUID().uuidString, name: String, isCompleted: Bool, priority: PriorityType, date: Date, pomodoros: [Pomodoro] = []) {
        self.id = id
        self.name = name
        self.isCompleted = isCompleted
        self.priority = priority
        self.date = date
        self.pomodoros = pomodoros
    }
    
    func addPomodoro(pomodoro: Pomodoro) -> ItemModel {
        return ItemModel(id: id, name: name, isCompleted: isCompleted, priority: priority, date: date, pomodoros: pomodoros + [pomodoro])
    }
}

struct Pomodoro: Identifiable, Equatable {
    let id = UUID().uuidString
    let time: Int
    let isCompleted: Bool
}
