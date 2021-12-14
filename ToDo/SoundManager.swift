//
//  SoundManager.swift
//  ToDo
//
//  Created by Шынгыс Курбан on 14.12.2021.
//

import AVKit

class SoundManager {
    
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    func playMusic() {
        guard let url = Bundle.main.url(forResource: "bg_country", withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func stopMusic() {
        player?.stop()
    }
}
