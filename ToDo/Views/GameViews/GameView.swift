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
    
    var scene: SKScene {
        let scene = StickHeroGameScene(size:CGSize(width: DefinedScreenWidth, height: DefinedScreenHeight))
        scene.scaleMode = .aspectFill
        return scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .frame(width: screenSize.width, height: screenSize.height)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GameView()
        }
        .environmentObject(TasksVM())
    }
}
