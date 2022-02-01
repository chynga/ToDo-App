//
//  GameView.swift
//  ToDo
//
//  Created by Шынгыс Курбан on 09.12.2021.
//

import SpriteKit
import SwiftUI

struct GameView: View {
    let screenSize: CGRect = UIScreen.main.bounds
    @EnvironmentObject var tasksVM: TasksVM
    @Binding var isGameStarted: Bool
    
    var scene: SKScene {
        let scene = StickHeroGameScene(size:CGSize(width: DefinedScreenWidth, height: DefinedScreenHeight))
        scene.scaleMode = .aspectFill
        return scene
    }
    
    var body: some View {
        ZStack {
            SpriteView(scene: scene)
                .frame(width: screenSize.width, height: screenSize.height)
                .statusBar(hidden: true)
                .onAppear {
                    if tasksVM.settings.isMusicOn {
                        SoundManager.instance.playMusic()
                    }
                }
                .onDisappear {
                    SoundManager.instance.stopMusic()
                }
            
            VStack {
                HStack {
                    Button {
                        tasksVM.currentLifeAmount -= 1
                        isGameStarted = false
                    } label: {
                        Image(systemName: "arrowtriangle.backward.fill")
                            .foregroundColor(.white)
                            .padding()
                            .padding(.horizontal)
                            .background(.black)
                            .cornerRadius(10)
                    }

                    Spacer()
                }
                
                Spacer()
            }
            .padding()
            .padding(.top)
        }
        
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GameView(isGameStarted: .constant(true))
        }
        .environmentObject(TasksVM())
    }
}
