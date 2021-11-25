//
//  TasksVM.swift
//  ToDo
//
//  Created by Шынгыс Курбан on 11.11.2021.
//

import Foundation

class TasksVM: ObservableObject {
    let lifeLimit = 10
    @Published var currentLifeAmount = 0
    
    @Published var items: [ItemModel] = [
        ItemModel(name: "Cisco", isCompleted: false, priority: .first, date: Date.now),
        ItemModel(name: "DEA", isCompleted: false, priority: .second, date: Date.now),
        ItemModel(name: "HCI", isCompleted: false, priority: .third, date: Date.now)
    ]
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
}
