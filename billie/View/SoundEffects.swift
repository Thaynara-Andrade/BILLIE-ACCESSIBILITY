//
//  SoundEffects.swift
//  billie
//
//  Created by Thaynara da Silva Andrade on 06/03/23.
//

import SwiftUI
import AVKit

class SoundManager {
    static let instance = SoundManager()
    var player: AVAudioPlayer?
    
    func PlaySound() {
        guard let url = Bundle.main.url(forResource: "sucess", withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("erro \(error.localizedDescription)")
        }
    }
}

struct SoundsBootCamp: View {
    var body: some View {
        VStack{
            Button("Play") {
                //SoundManager.instance.PlaySound()
                
            }
            
        }
        
    }
}

struct SoundsBootcamp_previews: PreviewProvider {
static var previews: some View {
    SoundsBootCamp()
}
}
