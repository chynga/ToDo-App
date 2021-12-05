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
    @State private var dayForTask = Date.now
    @State private var priority: PriorityType = .third
    
    @State private var showDatePicker: Bool = false
    
    var body: some View {
        ZStack {
//            Color("BackgroundColor")
//                .ignoresSafeArea()
            VStack {
                
                // MARK: TEXTFIELD
                HStack {

                    TextField("Enter Title", text: $textFieldText)
                    
                    Spacer()
                }
                Divider()
                
//                Rectangle()
//                    .frame(maxWidth: .infinity, maxHeight: 1)
//                    .foregroundColor(Color("RowSeparatorColor"))
                
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
                    tasksVM.addItem(title: textFieldText, priority: priority, dayForTask: dayForTask)
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
        .preferredColorScheme(.light)
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
