//
//  SettingsView.swift
//  ToDo
//
//  Created by Шынгыс Курбан on 14.12.2021.
//

import SwiftUI

struct Settings: Codable {
    static let instance = Settings()
    var isMusicOn = false
    var isSoundOn = false
    
    private init() {}
}

struct SettingsView: View {
    @EnvironmentObject var tasksVM: TasksVM
    var body: some View {
        Form {
            Section("Account") {
                Text("Email: \(tasksVM.user?.email ?? "")")
                Button {
                    self.tasksVM.handleSignOut()
                } label: {
                    Text("Log out")
                        .foregroundColor(.red)
                }
                .fullScreenCover(isPresented: $tasksVM.isUserCurrentlyLoggedOut, onDismiss: nil) {
                    LoginView(didCompleteLoginProcess: {
                        self.tasksVM.isUserCurrentlyLoggedOut = false
                        self.tasksVM.fetchCurrentUser()
                    })
                }

            }
            Section("Game") {
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
