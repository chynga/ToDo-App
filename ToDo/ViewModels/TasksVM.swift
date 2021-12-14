//
//  TasksVM.swift
//  ToDo
//
//  Created by Шынгыс Курбан on 11.11.2021.
//

import Foundation
import SwiftUI

class TasksVM: ObservableObject {
    let itemsKey: String = "items_list"
    let settingsKey: String = "settings"
    @Published var settings = Settings.instance {
        didSet {
            saveSettings()
        }
    }
    
    let lifeLimit = 10
    @AppStorage("com.stickHero.lifeAmount") var currentLifeAmount = 0
    
    
//    @Published var items: [ItemModel] = [
//        ItemModel(name: "Cisco", isCompleted: false, priority: .first, date: getDate(), pomodoros: [Pomodoro(time: 25, isCompleted: true), Pomodoro(time: 17, isCompleted: false), Pomodoro(time: 25, isCompleted: true)]),
//        ItemModel(name: "DEA", isCompleted: false, priority: .second, date: getDate(), pomodoros: [Pomodoro(time: 25, isCompleted: true), Pomodoro(time: 17, isCompleted: false), Pomodoro(time: 25, isCompleted: true)]),
//        ItemModel(name: "HCI", isCompleted: false, priority: .third, date: getDate(), pomodoros: [Pomodoro(time: 25, isCompleted: true), Pomodoro(time: 17, isCompleted: false), Pomodoro(time: 25, isCompleted: true)])
//    ]
    
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItems()
        }
    }

    init() {
        getItems()
        getSettings()
    }
    
    func getItems() {
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        self.items = savedItems
    }
    
    func getSettings() {
        guard
            let data = UserDefaults.standard.data(forKey: settingsKey),
            let savedSettings = try? JSONDecoder().decode(Settings.self, from: data)
        else { return }
        self.settings = savedSettings
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func addItem (title: String, priority: PriorityType, dayForTask: String) {
        let item = ItemModel(name: title, isCompleted: false, priority: priority, date: dayForTask, pomodoros: [])
        items.append(item)
    }
    
    func updateItemCompletion(item: ItemModel) {
        if !item.isCompleted {
            
            self.currentLifeAmount += 1
            if self.currentLifeAmount >= self.lifeLimit {
                self.currentLifeAmount = 10
            }
        }
        self.items.removeAll { $0.id == item.id }
    }
    
    func addPomodoro(item: ItemModel, pomodoro: Pomodoro) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.addPomodoro(pomodoro: pomodoro)
        }
    }
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey )
        }
    }
    
    func saveSettings() {
        if let encodedData = try? JSONEncoder().encode(settings) {
            UserDefaults.standard.set(encodedData, forKey: settingsKey )
        }
    }
}

struct Settings: Codable {
    static let instance = Settings()
    var isMusicOn = false
    var isSoundOn = false
    
    private init() {}
}

//func getDate() -> String {
//    let today = Date()
//    let formatter1 = DateFormatter()
//    formatter1.dateFormat = "d MMM y"
//    return formatter1.string(from: today)
//}
