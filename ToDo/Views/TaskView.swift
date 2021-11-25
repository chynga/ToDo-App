//
//  TaskView.swift
//  ToDo
//
//  Created by Шынгыс Курбан on 24.11.2021.
//

import SwiftUI

struct TaskView: View {
    var item: ItemModel
    var body: some View {
        Text("\(item.name)")
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(item: ItemModel(name: "Cisco", isCompleted: false, priority: .third, date: Date.now))
    }
}
