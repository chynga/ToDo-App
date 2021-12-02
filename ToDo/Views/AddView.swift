//
//  AddView.swift
//  ToDo
//
//  Created by Шынгыс Курбан on 10.11.2021.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var tasksVM: TasksVM
    
    @State private var textFieldText = ""
    @State private var textEditorText = ""
    @State private var dayForTask = Date.now
    @State private var priority: PriorityType = .third
    
    @State private var showDatePicker: Bool = false
    
    var body: some View {
        ZStack {
//            Color("BackgroundColor")
//                .ignoresSafeArea()
            VStack {
                
                // MARK: PRIORITY, TEXTFIELD
                HStack {
                    
//                    Picker("Please choose a priority", selection: $priority) {
//                        
//                    }
//                    Picker("sdfsd", selection: $priority) {
//                        Image(systemName: "flag")
//                    }
//                        .padding(.leading)
//                    Picker(selection: $priority) {
//                        ForEach(PriorityType.allCases) {
//                            
//                            Text($0.rawValue).tag($0)
//                        }
//                    } label: {
//                        Image(systemName: "flag")
//                    }
//                    .pickerStyle(MenuPickerStyle())

                    TextField("Enter Title", text: $textFieldText)
                    
                    Spacer()
                }
                
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .foregroundColor(Color("RowSeparatorColor"))
                
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
        // MARK: NAVIGATION
        .navigationTitle(Text("Add Task"))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    let item = ItemModel(name: textFieldText, isCompleted: false, priority: priority, date: dayForTask, pomodoros: [])
                    tasksVM.items.append(item)
                    dismiss()
                } label: {
                    Text("Save")
                }

            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddView()
        }
        .preferredColorScheme(.dark)
    }
}

// MARK: DATE PICKER
struct SelectDate: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var dayForTask: Date
    @Binding var showDatePicker: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Add") {
                    showDatePicker.toggle()
                    presentationMode.wrappedValue.dismiss()
                }
            }
            
            DatePicker("Task Day", selection: $dayForTask, in: Date()..., displayedComponents: .date)
                .datePickerStyle(.graphical)
//            DatePicker("Enter", selection: $dayForTask)
            
            Spacer()
        }
        .padding()
    }
}

//func getFlag(type: PriorityType) -> Image {
//    if type == .first {
//        return Image(systemName: "flag.fill").foregroundColor(.red) as! Image
//    } else if type == .second {
//        return Image(systemName: "flag.fill").foregroundColor(.yellow) as! Image
//    } else {
//        return Image(systemName: "flag.fill").foregroundColor(.red) as! Image
//    }
//}
