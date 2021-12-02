//
//  PomodoroView.swift
//  ToDo
//
//  Created by Шынгыс Курбан on 01.12.2021.
//

import SwiftUI

struct PomodorosView: View {
    var item: ItemModel
    var body: some View {
        VStack {
//            List {
//                ForEach(item.pomodoros) { pomodoro in
//                    PomodoroView(pomodoro: pomodoro)
//                }
//            }
            ForEach(item.pomodoros) { pomodoro in
                if item.pomodoros.first == pomodoro {
                    Divider()
                }
                PomodoroView(pomodoro: pomodoro)
                Divider()
            }
            .navigationTitle("Pomodoros")
            .listStyle(.grouped)
            
            NavigationLink {
                TimerView(item: item)
            } label: {
                Text("Start Pomodoro")
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(.red)
                    .cornerRadius(20)
            }

            Spacer()
        }
        .padding()
    }
}

struct PomodorosView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PomodorosView(item: ItemModel(name: "Cisco", isCompleted: false, priority: .third, date: Date.now, pomodoros: [Pomodoro(time: 25, isCompleted: true), Pomodoro(time: 17, isCompleted: false), Pomodoro(time: 25, isCompleted: true)]))
        }
        
    }
}
