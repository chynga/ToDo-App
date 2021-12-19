//
//  EditView.swift
//  ToDo
//
//  Created by Шынгыс Курбан on 19.12.2021.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var tasksVM: TasksVM
    let item: ItemModel
    
    @State private var textFieldText = ""
    @State private var dayForTask: Date = Date()
    @State private var priority: PriorityType = .third
    
    @State private var showDatePicker: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                
                // MARK: TEXTFIELD
                HStack {

                    TextField("Enter Title", text: $textFieldText)
                    
                    Spacer()
                }
                Divider()
                
                // MARK: DATE
                HStack {
                    Button {
                        showDatePicker.toggle()
                    } label: {
                        Image(systemName: "calendar")
                        Text(dayForTask, style: .date)
                    }
                    .sheet(isPresented: $showDatePicker) {
                        SelectDate(dayForTask: $dayForTask, showDatePicker: $showDatePicker)
                    }

                    
                    Spacer()
                }
                
                Spacer()
            }
            .padding()
            .font(.title)
            .foregroundColor(.secondary)
            
        }
        .onAppear(perform: {
            self.textFieldText = self.item.name
            self.priority = self.item.priority
            self.dayForTask = getUnFomatted(dateString: self.item.date)
        })
        // MARK: NAVIGATION
        .navigationTitle(Text("Edit Task"))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    tasksVM.updateItem(item: ItemModel(id: item.id, name: self.textFieldText, isCompleted: false, priority: self.priority, date: getFomatted(date: self.dayForTask), pomodoros: item.pomodoros))
                    dismiss()
                } label: {
                    Text("Save")
                }

            }
        }
    }
}

//struct EditView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            EditView(ItemModel(name: "test", isCompleted: false, priority: .third, date: getFomatted(date: Date()), pomodoros: []))
//        }
//    }
//}

func getUnFomatted(dateString: String) -> Date {
    let format="d MMM y"
    let dateFmt = DateFormatter()
    dateFmt.dateFormat = format
    let newreadableDate = dateFmt.date(from: dateString)
    return newreadableDate ?? Date()
//    dateFmt.dateFormat = "MMM dd hh:mm a"
//    print("Formatted date is : \(dateFmt.string(from: newreadableDate!))")
//    let formatter1 = DateFormatter()
//    formatter1.dateFormat = "d MMM y"
//    return formatter1.string(from: date)
}
