//
//  ItemView.swift
//  ToDo
//
//  Created by Шынгыс Курбан on 11.11.2021.
//

import SwiftUI

struct ItemView: View {
    @EnvironmentObject var tasksVM: TasksVM
    var item: ItemModel
    var body: some View {
        NavigationLink {
//            TaskView(item: item)
        } label: {
            HStack {
                Image(systemName: "circle")
                    .foregroundColor(getPriorityColor(priority: item.priority))
                    .font(.system(size: 25))
                    .onTapGesture {
                        if !item.isCompleted {
                            
                            tasksVM.currentLifeAmount += 1
                            if tasksVM.currentLifeAmount >= tasksVM.lifeLimit {
                                tasksVM.currentLifeAmount = 10
                            }
                        }
                        withAnimation {
                            tasksVM.items.removeAll { $0.id == item.id }
                        }
//                        item.isCompleted = true
                    }
                Text(item.name)
                    .font(.system(size: 25))
                
                Spacer()
                
                Text(item.date, style: .date)
            }
            .frame(maxWidth: .infinity, maxHeight: 45)
        }
    }
}

//struct ItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        var item1 = ItemModel(name: "Cisco", isCompleted: false, priority: .first, date: Date.now)
//        NavigationView {
//            ItemView(item: $item1)
//                .previewLayout(.sizeThatFits)
//        }
//    }
//}

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
