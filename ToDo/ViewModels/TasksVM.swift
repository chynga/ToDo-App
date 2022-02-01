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
    
    @Published var isUserCurrentlyLoggedOut = false

    @Published var settings = Settings.instance {
        didSet {
            saveSettings()
        }
    }
    
    let lifeLimit = 10
    @AppStorage("com.stickHero.lifeAmount") var currentLifeAmount = 0
    
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItems()
        }
    }

    init() {
        DispatchQueue.main.async {
            self.isUserCurrentlyLoggedOut = FirebaseManager.shared.auth.currentUser?.uid == nil
        }
        
        getItems()
        getSettings()
        fetchCurrentUser()
    }
    
    func getItems() {
        guard let id = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let document = FirebaseManager.shared.firestore.collection("todos").document(id)
        
        document.getDocument { doc, error in
            guard error == nil else { return }
            
            if let data = doc!.data() {
                
                self.text = "1"
                var items: [ItemModel] = []
                for (id, d) in data {
                    guard let d = d as? [String : Any] else {
                        self.text = "2"
                        return
                    }
                    self.text = "3"
//                    let name = d["name"] as? String
                    let item = ItemModel(id: id, name: d["name"] as? String ?? "", isCompleted: d["isCompleted"] as? Bool ?? false, priority: PriorityType(rawValue: d["priority"] as? String ?? "") ?? .third, date: d["date"] as? String ?? "", pomodoros: [])
                    items.append(item)
                    self.text = "4"
                }
                self.items = items
            }
        }
    }
    
    @Published var text = "12345"
    
    
    func saveItems() {
        guard let id = FirebaseManager.shared.auth.currentUser?.uid else { return }

        let document = FirebaseManager.shared.firestore.collection("todos").document(id)
            
        document.setData(getDictionaryOfItems(items: self.items))
    }
    
    private func getDictionaryOfItems(items: [ItemModel]) -> [String : [String : Any]] {
        
        var dictionary: [String : [String : Any]] = [:]
        
        for item in items {
            dictionary[item.id] = ["name" : item.name, "priority" : item.priority.rawValue, "date" : item.date, "pomodoros" : []]
        }
        
        return dictionary
    }
    
    func getSettings() {
        guard
            let data = UserDefaults.standard.data(forKey: settingsKey),
            let savedSettings = try? JSONDecoder().decode(Settings.self, from: data)
        else { return }
        self.settings = savedSettings
    }
    
    func saveSettings() {
        if let encodedData = try? JSONEncoder().encode(settings) {
            UserDefaults.standard.set(encodedData, forKey: settingsKey )
        }
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
    
    func updateItem(item: ItemModel) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item
        }
    }
    
    func addPomodoro(item: ItemModel, pomodoro: Pomodoro) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.addPomodoro(pomodoro: pomodoro)
        }
    }
    
    // MARK: user
    @Published var errorMessage = ""
    @Published var user: User?

    func fetchCurrentUser() {

        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            self.errorMessage = "Could not find firebase uid"
            return
        }

        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                self.errorMessage = "Failed to fetch current user: \(error)"
                print("Failed to fetch current user:", error)
                return
            }

            guard let data = snapshot?.data() else {
                self.errorMessage = "No data found"
                return

            }
            
            self.user = .init(data: data)
        }
    }
    
    func handleSignOut() {
        isUserCurrentlyLoggedOut.toggle()
        try? FirebaseManager.shared.auth.signOut()
    }
}
