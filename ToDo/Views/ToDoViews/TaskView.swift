//
//  ItemView.swift
//  ToDo
//
//  Created by Шынгыс Курбан on 11.11.2021.
//

import SwiftUI

struct TaskView: View {
    @EnvironmentObject var tasksVM: TasksVM
    var item: ItemModel
    var body: some View {
        NavigationLink {
            PomodorosView(item: item)
        } label: {
            HStack {
                Image(systemName: "circle")
                    .foregroundColor(getPriorityColor(priority: item.priority))
                    .font(.system(size: 25))
                    .onTapGesture {
                        withAnimation {
                            tasksVM.updateItemCompletion(item: item)
                        }
                    }
                Text(item.name)
                    .font(.system(size: 25))
                
                Spacer()
                
                Text(item.date)
//                Text(item.date, style: .date)
            }
            .frame(maxWidth: .infinity, maxHeight: 45)
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            let item1 = ItemModel(name: "Cisco", isCompleted: false, priority: .first, date: getFomatted(date: Date()), pomodoros: [])
            TaskView(item: item1)
                .previewLayout(.sizeThatFits)
        }
    }
}

func getPriorityColor(priority: PriorityType?) -> Color? {
    if priority == PriorityType.first {
        return Color(red: 0.7216, green: 0.2314, blue: 0.3686)
    } else if priority == PriorityType.second {
        return Color(red: 0.9412, green: 0.5412, blue: 0.3647)
    } else if priority == PriorityType.third {
//        return Color(red: 0.6666, green: 0.5882, blue: 0.8549)
        return .gray
    }
    return Color.black
}
