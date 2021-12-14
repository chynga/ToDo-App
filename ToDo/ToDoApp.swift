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
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(named: "BackgroundColor")
    }
    
    var body: some Scene {
        
        WindowGroup {
            TabView {
                NavigationView {
                    StartView()
                }
                .tabItem {
                    Label("Play", systemImage: "gamecontroller.fill")
                }
                
                NavigationView {
                    TasksView()
                }
                .tabItem {
                    Label("ToDo", systemImage: "checkmark.circle")
                }
                
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape")
                    }
            }
            .environmentObject(tasksVM)
        }
    }
}
