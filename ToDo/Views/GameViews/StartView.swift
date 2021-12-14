//
//  StartView.swift
//  ToDo
//
//  Created by Шынгыс Курбан on 11.12.2021.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var tasksVM: TasksVM
    
    var body: some View {
        if tasksVM.currentLifeAmount <= 0 {
            NoGameView()
        } else {
            PlayView()
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
