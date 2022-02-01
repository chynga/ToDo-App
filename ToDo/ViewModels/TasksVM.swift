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
                let data = try? JSONDecoder().decode([ItemModel].self, from: data[id] as! Data)
                self.items = data ?? []
            }
        }
    }
    
    
    func saveItems() {
        guard let id = FirebaseManager.shared.auth.currentUser?.uid else { return }

        let document = FirebaseManager.shared.firestore.collection("todos").document(id)
            
        document.setData([id:getDictionaryOfItems(items: self.items)])
    }
    
    private func getDictionaryOfItems(items: [ItemModel]) -> Any {
        let data = try? JSONEncoder().encode(items)
        return data ?? []
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
