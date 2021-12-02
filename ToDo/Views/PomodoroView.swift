//
//  PomodoroView.swift
//  ToDo
//
//  Created by Шынгыс Курбан on 01.12.2021.
//

import SwiftUI

struct PomodoroView: View {
    let pomodoro: Pomodoro
    var body: some View {
        HStack {
            Image(systemName: pomodoro.isCompleted ? "checkmark" : "xmark")
                .foregroundColor(pomodoro.isCompleted ? .green : .red)
                .font(.system(size: 25))
            
            Spacer()
            
            Text("\(pomodoro.time) minutes")
                .foregroundColor(pomodoro.isCompleted ? .green : .red)
                .font(.system(size: 25))
        }
    }
}

struct PomodoroView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PomodoroView(pomodoro: Pomodoro(time: 17, isCompleted: false))
            PomodoroView(pomodoro: Pomodoro(time: 25, isCompleted: true))
        }
        .previewLayout(.sizeThatFits)
    }
}
