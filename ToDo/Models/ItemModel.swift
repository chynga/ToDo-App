//
//  ToDoItemModel.swift
//  ToDo
//
//  Created by Шынгыс Курбан on 11.11.2021.
//

import Foundation

struct ItemModel: Identifiable {
    let id = UUID().uuidString
    var name: String
    var isCompleted: Bool
    var priority: PriorityType
//    var notes: String
//    var tag: String
    var date: Date
}
