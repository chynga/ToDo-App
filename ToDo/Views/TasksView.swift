//
//  TasksView.swift
//  ToDo
//
//  Created by Шынгыс Курбан on 11.11.2021.
//

import SwiftUI

struct TasksView: View {
    
    @EnvironmentObject var tasksVM: TasksVM
    @State var showView: Bool = false
    
    let backgroundColor = Color("BackgroundColor")
    let rowSeparatorColor = Color("RowSeparatorColor")
    
    var body: some View {
            
        ZStack {
            backgroundColor
                .ignoresSafeArea()
        
            //MARK: LIST
            List {
                ForEach(tasksVM.items.indices) { i in
                    ItemView(item: self.$tasksVM.items[i])
                        .listRowBackground(backgroundColor)
                        .listRowSeparatorTint(rowSeparatorColor)
                }
                .onDelete(perform: tasksVM.deleteItem)
            }
            .listStyle(.plain)
            
            
            // MARK: NAVIGATION STUFF
            .navigationTitle("Tasks")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                        Text("\(tasksVM.currentLifeAmount)")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        AddView()
                    } label: {
                        Image(systemName: "plus")
                            .accentColor(.black)
                    }
                }
            }
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TasksView()
        }
        .environmentObject(TasksVM())
    }
}

