//
//  ToDoApp.swift
//  ToDo
//
//  Created by Шынгыс Курбан on 20.10.2021.
//

import SwiftUI

@main
struct ToDoApp: App {
    @StateObject var tasksVM: TasksVM = TasksVM()
    
    var body: some Scene {
        
        WindowGroup {
            NavigationView {
                TasksView()
            }
            .environmentObject(tasksVM)
        }
    }
}
