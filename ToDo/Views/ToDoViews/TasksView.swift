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
    let rowSeparatorColor = Color("RowSeparatorColor")
    
    var body: some View {
        
            
        ZStack {
        
            //MARK: LIST
            List {
                ForEach(tasksVM.items) { item in
                    TaskView(item: item)
                }
                .onDelete(perform: tasksVM.deleteItem)
            }
            .listStyle(.grouped)
            
            
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
                            .accentColor(.primary)
                    }
                }
            }
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                TasksView()
            }
            .environmentObject(TasksVM())
        }
    }
}

