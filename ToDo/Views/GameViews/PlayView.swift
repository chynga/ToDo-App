//
//  PlayView.swift
//  ToDo
//
//  Created by Шынгыс Курбан on 09.12.2021.
//

import SwiftUI

struct PlayView: View {
    @EnvironmentObject var tasksVM: TasksVM
    
    var body: some View {
        VStack {
            Text("Lifes: \(tasksVM.currentLifeAmount)")
            
            NavigationLink {
                GameView()
            } label: {
                Text("Play")
                    .foregroundColor(.white)
                    .frame(width: 100, height: 40)
                    .background(.gray)
                    .cornerRadius(10)
            }
        }
        .onAppear {
            tasksVM.currentLifeAmount = UserDefaults.standard.integer(forKey: "com.stickHero.lifeAmount")
        }
    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PlayView()
        }
        .environmentObject(TasksVM())
    }
}
