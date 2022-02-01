//
//  PlayView.swift
//  ToDo
//
//  Created by Шынгыс Курбан on 09.12.2021.
//

import SwiftUI

struct PlayView: View {
    @EnvironmentObject var tasksVM: TasksVM
    @State var isGameStarted = false
    
    var body: some View {
        VStack {
            Text("Lifes: \(tasksVM.currentLifeAmount)")
            
//            NavigationLink {
//                GameView()
//            } label: {
//                Text("Play")
//                    .foregroundColor(.white)
//                    .frame(width: 100, height: 40)
//                    .background(.gray)
//                    .cornerRadius(10)
//            }
            Button {
                isGameStarted = true
            } label: {
                Text("Play")
                    .foregroundColor(.white)
                    .frame(width: 100, height: 40)
                    .background(.gray)
                    .cornerRadius(10)
            }

        }
        .fullScreenCover(isPresented: $isGameStarted, onDismiss: nil, content: {
            GameView(isGameStarted: $isGameStarted)
        })
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
