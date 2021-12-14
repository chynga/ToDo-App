//
//  SettingsView.swift
//  ToDo
//
//  Created by Шынгыс Курбан on 14.12.2021.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var tasksVM: TasksVM
    var body: some View {
        Form {
            Section {
                Toggle(isOn: $tasksVM.settings.isMusicOn) {
                    Text("Music")
                }
                Toggle(isOn: $tasksVM.settings.isSoundOn) {
                    Text("Sound")
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
