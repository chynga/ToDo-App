//
//  ToDoItemModel.swift
//  ToDo
//
//  Created by Шынгыс Курбан on 11.11.2021.
//

import Foundation

struct ItemModel: Identifiable, Codable {
    var id: String
    var name: String
    var isCompleted: Bool
    var priority: PriorityType
    var date: String
    var pomodoros: [Pomodoro]
    
    init(id: String = UUID().uuidString, name: String, isCompleted: Bool, priority: PriorityType, date: String, pomodoros: [Pomodoro] = []) {
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

struct Pomodoro: Identifiable, Equatable, Codable {
    let id = UUID().uuidString
    let time: Int
    let isCompleted: Bool
}
